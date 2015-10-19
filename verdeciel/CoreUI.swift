
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
	var canUpdate:Bool = false
	var displayHealth:SCNNode!
	var displayMagic:SCNNode!
	
	override init()
	{
		super.init()
		setup()
	}
	
	func setup()
	{
		addChildNode( SCNLine(nodeA: SCNVector3(x: -0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
		addChildNode( SCNLine(nodeA: SCNVector3(x: 0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		addChildNode( SCNLine(nodeA: SCNVector3(x: 0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		addChildNode( SCNLine(nodeA: SCNVector3(x: -0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
		
		displayHealth = SCNLabel(text: "99hp", scale: 0.05, align: alignment.left)
		displayHealth.position = SCNVector3(x: -0.7, y: -1, z: -1.01)
		displayHealth.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(displayHealth)
		
		displayMagic = SCNLabel(text: "34mp", scale: 0.05, align: alignment.right)
		displayMagic.position = SCNVector3(x: 0.7, y: -1, z: -1.01)
		displayMagic.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		addChildNode(displayMagic)
	}
	
	override func fixedUpdate()
	{
		if canUpdate == false { return }
		
		if (ui.eulerAngles.y - player.eulerAngles.y) > 0.0001 && ui.eulerAngles.y > player.eulerAngles.y {
			ui.eulerAngles.y -= (ui.eulerAngles.y - player.eulerAngles.y) * 0.1
		}
		if (ui.eulerAngles.y - player.eulerAngles.y) < -0.0001 && ui.eulerAngles.y < player.eulerAngles.y {
			ui.eulerAngles.y -= (ui.eulerAngles.y - player.eulerAngles.y) * 0.1
		}
		
		
		if (ui.eulerAngles.x - player.eulerAngles.x) > 0.0001 && ui.eulerAngles.x > player.eulerAngles.x {
			ui.eulerAngles.x -= (ui.eulerAngles.x - player.eulerAngles.x) * 0.1
		}
		if (ui.eulerAngles.x - player.eulerAngles.x) < -0.0001 && ui.eulerAngles.x < player.eulerAngles.x {
			ui.eulerAngles.x -= (ui.eulerAngles.x - player.eulerAngles.x) * 0.1
		}
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}