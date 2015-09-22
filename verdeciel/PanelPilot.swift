//
//  PanelBeacon.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelPilot : SCNNode
{
	var nameLabel = SCNLabel(text: "")
	
	var targetOrientation = SCNNode()
	var capsuleOrientation = SCNNode()
	var homeOrientation = SCNNode()

	// Ports
	
	var input:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "pilot"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z - 0.2)
		
		update()
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		nameLabel = SCNLabel(text: self.name!, scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(nameLabel)
		
		// 
		
		targetOrientation = SCNLine(nodeA: SCNVector3(0, 0.7, 0), nodeB: SCNVector3(0, -0.7, 0), color: white)
		targetOrientation.addChildNode(SCNLine(nodeA: SCNVector3(-0.2, 0.75, 0), nodeB: SCNVector3(0.2, 0.75, 0), color: white))
		self.addChildNode(targetOrientation)
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.7, y: highNode[7].y * scale, z: 0)
		self.addChildNode(input)
	}
	
	override func touch()
	{
		
	}
	
	override func update()
	{
		
	}
	
	override func listen(event:SCNEvent)
	{
		print("\(self.name!) -> Listen:\(event.name)")
		
		let value = (angleBetweenTwoPoints(capsule.location, point2: event.location, center: event.location) - 90) / 180
		let targetAngle = Double(value) * -1
		
		targetOrientation.runAction(SCNAction.rotateToAxisAngle(SCNVector4Make(0, 0, 1, Float(M_PI * targetAngle)), duration: 0.2))
		
		self.update()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}