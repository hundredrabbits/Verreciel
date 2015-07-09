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
				case  cardinals.n : radar.direction = cardinals.nw
				case  cardinals.ne : radar.direction = cardinals.n
				case  cardinals.e : radar.direction = cardinals.ne
				case  cardinals.se : radar.direction = cardinals.e
				case  cardinals.nw : radar.direction = cardinals.w
				case  cardinals.w : radar.direction = cardinals.sw
				case  cardinals.sw : radar.direction = cardinals.s
				default : radar.direction = cardinals.se
			}
		}
		else{
			switch radar.direction {
				case  cardinals.n : radar.direction = cardinals.ne
				case  cardinals.ne : radar.direction = cardinals.e
				case  cardinals.e : radar.direction = cardinals.se
				case  cardinals.se : radar.direction = cardinals.s
				case  cardinals.nw : radar.direction = cardinals.n
				case  cardinals.w : radar.direction = cardinals.nw
				case  cardinals.sw : radar.direction = cardinals.w
				default : radar.direction = cardinals.sw
			}
		}
		radar.update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}