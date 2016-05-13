//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreSpace: Empty
{
	var structuresRoot = Empty()
	var starsRoot = Empty()
	
	override init()
	{
		super.init()
		
		print("^ Space | Init")
		
		addChildNode(structuresRoot)
		addChildNode(starsRoot)
		
		starsRoot.position = SCNVector3(0,40,0)
	}
	
	// Space Color
	
	var targetSpaceColor:Array<CGFloat> = [0,0,0]
	var currentSpaceColor:Array<CGFloat> = [0,0,0]
	var stars_color:UIColor = white
	
	func onSystemEnter(system:Systems)
	{
		capsule.system = system
		
		white = true_white
		black = true_black
		cyan = true_cyan
		red = true_red
		grey = true_grey
		
		switch system {
		case .valen  : targetSpaceColor = [0.2,0.2,0.2] ; stars_color = white ; audio.playAmbience("ambience-1")
		case .senni  : targetSpaceColor = [0.0,0.0,0.0] ; stars_color = true_cyan ; audio.playAmbience("ambience-2")
		case .usul   : targetSpaceColor = [0.2,0.0,0.0] ; stars_color = true_white ; audio.playAmbience("ambience-3")
		case .close  : targetSpaceColor = [0.6,0.6,0.6] ; stars_color = black ; audio.playAmbience("ambience-4")
		default      : targetSpaceColor = [0.0,0.0,0.0] ; stars_color = white ; audio.playAmbience("ambience-3")
		}
		
		if capsule.closestStar().isComplete == true {
			targetSpaceColor = [44/255,73/255,65/255]
		}
	}
	
	// Instances
	
	func startInstance(location:Location)
	{
		structuresRoot.addChildNode(location.structure)
	}
	
	var lastStarAddedTime:Float = 0
	
	override func whenTime()
	{
		super.whenTime()
		
		return
		
		if capsule.isDockedAtLocation(universe.close) == true {
			journey.distance += 3
		}
		
		if starsRoot.childNodes.count < 100 && journey.distance > lastStarAddedTime + 1  {
			let randX = Float(Int(arc4random_uniform(40)) - 20)
			let randZ = Float(Int(arc4random_uniform(40)) - 20)
			starsRoot.addChildNode(star(SCNVector3(x:randX,y:0,z:randZ)))
			lastStarAddedTime = journey.distance
		}
		
		var starSpeed = thruster.actualSpeed
		if capsule.isDocked == false && capsule.dock != nil { starSpeed = 0.3 }
		else if capsule.isWarping == true { starSpeed = 40 }
		else{ starSpeed = thruster.actualSpeed }
		
		starSpeed *= 0.15
		
		if capsule.isDockedAtLocation(universe.close) == true {
			starSpeed = 0.15
		}
		
		for star in starsRoot.childNodes as! [SCNLine] {
			star.update([star.vertices.first!,SCNVector3(star.vertices.first!.x,star.vertices.first!.y + starSpeed + 0.1,star.vertices.first!.z)])
		}
		
		// Background
		
		if currentSpaceColor[0] < targetSpaceColor[0] { currentSpaceColor[0] += 0.01 }
		if currentSpaceColor[0] > targetSpaceColor[0] { currentSpaceColor[0] -= 0.01 }
		if currentSpaceColor[1] < targetSpaceColor[1] { currentSpaceColor[1] += 0.01 }
		if currentSpaceColor[1] > targetSpaceColor[1] { currentSpaceColor[1] -= 0.01 }
		if currentSpaceColor[2] < targetSpaceColor[2] { currentSpaceColor[2] += 0.01 }
		if currentSpaceColor[2] > targetSpaceColor[2] { currentSpaceColor[2] -= 0.01 }
		
		sceneView.backgroundColor = UIColor(red: currentSpaceColor[0], green: currentSpaceColor[1], blue: currentSpaceColor[2], alpha: 1)
		
		// Etc
		
		starsRoot.rotation = SCNVector4Make(0, 1, 0, (degToRad(capsule.direction)))
		
		// Update stars
		
		for star in starsRoot.childNodes as! [SCNLine] {
			star.position = SCNVector3(x: star.position.x, y: star.position.y - starSpeed, z: star.position.z)
			if star.position.y < -80 { star.removeFromParentNode() }
		}
	}
	
	func star(position:SCNVector3) -> SCNLine
	{
		return SCNLine(vertices: [position, SCNVector3(position.x,position.y + 1,position.z)], color: stars_color)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}