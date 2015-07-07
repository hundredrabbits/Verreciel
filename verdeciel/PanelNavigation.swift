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
	}
	
	func addInterface()
	{
		let panelNode = SCNNode()
		let scale:Float = 0.8
		
		let HookA = lowNode[7]
		let HookB = lowNode[0]
		let HookC = lowMidNode[7]
		let HookD = lowMidNode[0]
		
		let nodeA = SCNVector3(x: HookA.x * scale, y: HookA.y, z: HookA.z * 0.9)
		let nodeB = SCNVector3(x: HookB.x * scale, y: HookB.y, z: HookB.z * 0.9)
		let nodeC = SCNVector3(x: HookC.x * scale, y: HookC.y * 0.9, z: HookC.z * 1.1)
		let nodeD = SCNVector3(x: HookD.x * scale, y: HookD.y * 0.9, z: HookD.z * 1.1)
		
		panelNode.position = SCNVector3(x: 0, y: -2, z: HookA.z * 0.65)
		panelNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 0.85));
		
		let turnLeft = SCNNode(geometry: SCNPlane(width: 0.5, height: 0.5))
		turnLeft.geometry?.firstMaterial?.diffuse.contents = clear
		turnLeft.name = "trigger.turnLeft"
		turnLeft.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: 0.25, y: 0, z: 0)))
		turnLeft.addChildNode(line(SCNVector3(x: 0.25, y: 0, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnLeft.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnLeft.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: -0.25, y: 0, z: 0)))
		turnLeft.position = SCNVector3(x: 0.5, y: 0, z: 0)
		panelNode.addChildNode(turnLeft)
		
		let turnRight = SCNNode(geometry: SCNPlane(width: 0.5, height: 0.5))
		turnRight.geometry?.firstMaterial?.diffuse.contents = clear
		turnRight.name = "trigger.turnRight"
		turnRight.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: -0.25, y: 0, z: 0)))
		turnRight.addChildNode(line(SCNVector3(x: -0.25, y: 0, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnRight.addChildNode(line(SCNVector3(x: 0, y: 0.25, z: 0), SCNVector3(x: 0, y: -0.25, z: 0)))
		turnRight.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0.25, y: 0, z: 0)))
		turnRight.position = SCNVector3(x: -0.5, y: 0, z: 0)
		panelNode.addChildNode(turnRight)
		
		var nameLabel = SCNLabel(text: "navigation", scale: 0.05, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: -0.5, z: 0)
		nameLabel.name = "label.navigation"
		panelNode.addChildNode(nameLabel)
		
		self.addChildNode(panelNode)
	}
	
	func touch(right:Bool)
	{
		if right {
			user.orientation -= 1
		}
		else{
			user.orientation += 1
		}
		
		if user.orientation ==  5 { user.orientation = -3 }
		if user.orientation == -5 { user.orientation =  3 }
		
		radar.update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}