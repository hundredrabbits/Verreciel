//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreSpace: SCNNode
{
	var structuresRoot = SCNNode()
	var starsRoot = SCNNode()
	
	override init()
	{
		super.init()
		
		addChildNode(structuresRoot)
		addChildNode(starsRoot)
	}
	
	// Space Color
	
	var targetSpaceColor:Array<CGFloat>!
	var currentSpaceColor:Array<CGFloat> = [0,0,0]
	var stars_color:UIColor = white
	
	func onSystemEnter(system:Systems)
	{
		print("Entering \(system)")
		capsule.system = system
		
		white = true_white
		black = true_black
		cyan = true_cyan
		red = true_red
		grey = true_grey
		
		switch system {
		case .valen  : targetSpaceColor = [0.2,0.2,0.2] ; stars_color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
		case .nevic : targetSpaceColor = [0.0,0.0,0.0] ; stars_color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
		case .senni  : targetSpaceColor = [0.0,0.0,0.0] ; stars_color = true_cyan
		case .usul   : targetSpaceColor = [0.3,0.3,0.3] ; stars_color = true_red
		default      : targetSpaceColor = [0.0,0.0,0.0] ; stars_color = white
		}
	}
	
	func onTic()
	{
		if currentSpaceColor[0] < targetSpaceColor[0] { currentSpaceColor[0] += 0.01 }
		if currentSpaceColor[0] > targetSpaceColor[0] { currentSpaceColor[0] -= 0.01 }
		if currentSpaceColor[1] < targetSpaceColor[1] { currentSpaceColor[1] += 0.01 }
		if currentSpaceColor[1] > targetSpaceColor[1] { currentSpaceColor[1] -= 0.01 }
		if currentSpaceColor[2] < targetSpaceColor[2] { currentSpaceColor[2] += 0.01 }
		if currentSpaceColor[2] > targetSpaceColor[2] { currentSpaceColor[2] -= 0.01 }
		
		sceneView.backgroundColor = UIColor(red: currentSpaceColor[0], green: currentSpaceColor[1], blue: currentSpaceColor[2], alpha: 1)
	}
	
	// Stars
	
	var starTimer:Float = 0
	
	func addStar()
	{
		if starsRoot.childNodes.count > 100 { return }
		
		var randX = Int(arc4random_uniform(40)) - 20
		var randZ = Int(arc4random_uniform(40)) - 20
		
		while( distanceBetweenTwoPoints(CGPoint(x: CGFloat(randX), y: CGFloat(randZ)), point2: CGPoint(x: 0, y: 0)) < 6 ){
			randX = Int(arc4random_uniform(40)) - 20
			randZ = Int(arc4random_uniform(40)) - 20
		}
		
		let newLine = SCNLine(nodeA: SCNVector3(x: Float(randX), y: 0, z: Float(randZ)), nodeB: SCNVector3(x: Float(randX), y: 1, z: Float(randZ)), color: stars_color)
		newLine.position = SCNVector3(x: newLine.position.x, y: 45, z: newLine.position.z)
		starsRoot.addChildNode(newLine)
	}
	
	// Instances
	
	func startInstance(location:Location)
	{
		structuresRoot.addChildNode(Instance(event: location))
	}
	
	// Other
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		// Structures
		for instance in structuresRoot.childNodes{
			instance.update()
		}
		
		// Stars
		while starTimer > 4 {
			addStar()
			starTimer -= 4
		}
		updateStars()
	}
	
	func updateStars()
	{
		starsRoot.rotation = SCNVector4Make(0, 1, 0, (degToRad(capsule.direction)))
		
		var starSpeed = thruster.actualSpeed
		if capsule.isDocked == false && capsule.dock != nil { starSpeed = 0.3 }
		else{ starSpeed = thruster.actualSpeed }
		
		let lineSpeed = Float(starSpeed) / 6
		for line in starsRoot.childNodes as! [SCNLine] {
			line.position = SCNVector3(x: line.position.x, y: line.position.y - lineSpeed, z: line.position.z)
			line.updateHeight(starSpeed + 0.1)
			let distanceRatio = (50-line.position.distance(SCNVector3(0,0,0)))/50
			line.updateColor(UIColor(white: CGFloat(distanceRatio), alpha: 1))
			
			if line.position.y < -20 { line.removeFromParentNode() }
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}