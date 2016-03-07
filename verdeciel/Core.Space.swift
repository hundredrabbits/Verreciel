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
	var currentStarsColor:Array<CGFloat> = [0,0,0]
	
	func onTic()
	{
		if currentSpaceColor[0] < targetSpaceColor[0] { currentSpaceColor[0] += 0.01 }
		if currentSpaceColor[0] > targetSpaceColor[0] { currentSpaceColor[0] -= 0.01 }
		if currentSpaceColor[1] < targetSpaceColor[1] { currentSpaceColor[1] += 0.01 }
		if currentSpaceColor[1] > targetSpaceColor[1] { currentSpaceColor[1] -= 0.01 }
		if currentSpaceColor[2] < targetSpaceColor[2] { currentSpaceColor[2] += 0.01 }
		if currentSpaceColor[2] > targetSpaceColor[2] { currentSpaceColor[2] -= 0.01 }
		
		if currentStarsColor[0] < currentStarsColor[0] { currentStarsColor[0] += 0.01 }
		if currentStarsColor[0] > currentStarsColor[0] { currentStarsColor[0] -= 0.01 }
		if currentStarsColor[1] < currentStarsColor[1] { currentStarsColor[1] += 0.01 }
		if currentStarsColor[1] > currentStarsColor[1] { currentStarsColor[1] -= 0.01 }
		if currentStarsColor[2] < currentStarsColor[2] { currentStarsColor[2] += 0.01 }
		if currentStarsColor[2] > currentStarsColor[2] { currentStarsColor[2] -= 0.01 }
		
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
		
		let color = UIColor(red: space.targetSpaceColor[0], green: space.targetSpaceColor[1], blue: space.targetSpaceColor[2], alpha: 1)
		
		let newLine = SCNLine(nodeA: SCNVector3(x: Float(randX), y: 0, z: Float(randZ)), nodeB: SCNVector3(x: Float(randX), y: 1, z: Float(randZ)), color: color)
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
		while starTimer > 2 {
			addStar()
			starTimer -= 2
		}
		updateStars()
	}
	
	func updateStars()
	{
		starsRoot.rotation = SCNVector4Make(0, 1, 0, Float(degToRad(capsule.direction)))
		
		var starSpeed = thruster.actualSpeed
		if capsule.isDocked == false && capsule.dock != nil { starSpeed = 0.3 }
		else{ starSpeed = thruster.actualSpeed }
		
		let lineSpeed = Float(starSpeed) / 6
		for node in starsRoot.childNodes
		{
			let line = node as! SCNLine
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