//
//  SCNNavigation.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelNavigation : SCNNode
{	
	override init()
	{
		super.init()
		name = "navigation"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: -2, z: lowNode[7].z * 0.65)
		self.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 0.85));
	}
	
	func addInterface()
	{
		let turnLeft = SCNNode(geometry: SCNPlane(width: 0.5, height: 0.5))
		turnLeft.geometry?.firstMaterial?.diffuse.contents = clear
		turnLeft.name = "trigger.turnLeft"
		turnLeft.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: 0.25, y: 0, z: 0)))
		turnLeft.addChildNode(line(SCNVector3(x: 0.25, y: 0, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnLeft.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnLeft.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: -0.25, y: 0, z: 0)))
		turnLeft.position = SCNVector3(x: 0.5, y: 0, z: 0)
		self.addChildNode(turnLeft)
		
		let turnRight = SCNNode(geometry: SCNPlane(width: 0.5, height: 0.5))
		turnRight.geometry?.firstMaterial?.diffuse.contents = clear
		turnRight.name = "trigger.turnRight"
		turnRight.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: -0.25, y: 0, z: 0)))
		turnRight.addChildNode(line(SCNVector3(x: -0.25, y: 0, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnRight.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnRight.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0.25, y: 0, z: 0)))
		turnRight.position = SCNVector3(x: -0.5, y: 0, z: 0)
		self.addChildNode(turnRight)
		
		var nameLabel = SCNLabel(text: "navigation", scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: -0.5, z: 0)
		nameLabel.name = "label.navigation"
		self.addChildNode(nameLabel)
	}
	
	func touch(right:Bool)
	{
		if right {
			switch radar.direction {
				case  .n : radar.direction = .nw
				case  .ne : radar.direction = .n
				case  .e : radar.direction = .ne
				case  .se : radar.direction = .e
				case  .nw : radar.direction = .w
				case  .w : radar.direction = .sw
				case  .sw : radar.direction = .s
				default : radar.direction = .se
			}
		}
		else{
			switch radar.direction {
				case  .n : radar.direction = .ne
				case  .ne : radar.direction = .e
				case  .e : radar.direction = .se
				case  .se : radar.direction = .s
				case  .nw : radar.direction = .n
				case  .w : radar.direction = .nw
				case  .sw : radar.direction = .w
				default : radar.direction = .sw
			}
		}
		radar.update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}