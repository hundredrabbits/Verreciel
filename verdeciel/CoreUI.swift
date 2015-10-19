
//
//  CapsuleNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreUI: SCNNode
{
	var canAlign:Bool = false
	
	var displayLeft:SCNNode!
	var displayRight:SCNNode!
	
	var displayHealth:SCNLabel!
	var displayMagic:SCNLabel!
	
	var visor:SCNNode!
	
	override init()
	{
		super.init()
		setup()
	}
	
	func setup()
	{
		let textSize:Float = 0.025
		
		visor = SCNNode()
		visor.position = SCNVector3(0,0,-1.2)
		
		displayLeft = SCNNode()
		displayLeft.position = SCNVector3(-0.5,0,0)
		displayLeft.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: -1.3, z: 0), nodeB: SCNVector3(x: 0, y: -1.3, z: 0), color: grey))
		displayLeft.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -1.3, z: 0), nodeB: SCNVector3(x: 0.01, y: -1.275, z: 0), color: grey))
		
		displayHealth = SCNLabel(text: "99hp", scale: textSize, align: alignment.left, color:grey)
		displayHealth.position = SCNVector3(x: -0.2, y: -1.375, z: 0)
		displayLeft.addChildNode(displayHealth)
		
		displayLeft.eulerAngles.y = Float(degToRad(10))
		
		visor.addChildNode(displayLeft)
		
		displayRight = SCNNode()
		displayRight.position = SCNVector3(0.5,0,0)
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: -1.3, z: 0), nodeB: SCNVector3(x: 0, y: -1.3, z: 0), color: grey))
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -1.3, z: 0), nodeB: SCNVector3(x: -0.01, y: -1.275, z: 0), color: grey))
		
		displayMagic = SCNLabel(text: "16mp", scale: textSize, align: alignment.right, color:grey)
		displayMagic.position = SCNVector3(x: 0.2, y: -1.375, z: 0)
		displayRight.addChildNode(displayMagic)
		
		displayRight.eulerAngles.y = Float(degToRad(-10))
		
		visor.addChildNode(displayRight)
		
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: 1.4, z: 0), nodeB: SCNVector3(x: 0.1, y: 1.4, z: 0), color: grey))
		displayLeft.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: 1.4, z: 0), nodeB: SCNVector3(x: -0.1, y: 1.4, z: 0), color: grey))
		
		addChildNode(visor)
	}
	
	override func fixedUpdate()
	{
		if canAlign == true {
			if (ui.eulerAngles.y - player.eulerAngles.y) > 0.0001 && ui.eulerAngles.y > player.eulerAngles.y {
				ui.eulerAngles.y -= (ui.eulerAngles.y - player.eulerAngles.y) * 0.1
			}
			if (ui.eulerAngles.y - player.eulerAngles.y) < -0.0001 && ui.eulerAngles.y < player.eulerAngles.y {
				ui.eulerAngles.y -= (ui.eulerAngles.y - player.eulerAngles.y) * 0.1
			}
			if (ui.eulerAngles.x - player.eulerAngles.x) > 0.0001 && ui.eulerAngles.x > player.eulerAngles.x {
				ui.eulerAngles.x -= (ui.eulerAngles.x - player.eulerAngles.x) * 0.1
			}
			if (ui.eulerAngles.x - player.eulerAngles.x) < -0.0001 && ui.eulerAngles.y < player.eulerAngles.x {
				ui.eulerAngles.x -= (ui.eulerAngles.x - player.eulerAngles.x) * 0.1
			}
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}