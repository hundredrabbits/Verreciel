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
	var directionLabel = SCNLabel(text: "")
	
	var targetDirection = CGFloat()
	var targetDirectionIndicator = SCNNode()
	var activeDirectionIndicator = SCNNode()
	var staticDirectionIndicator = SCNNode()
	var eventsDirectionIndicator = SCNNode()
	
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
		
		directionLabel = SCNLabel(text: "", scale: 0.1, align: alignment.center)
		directionLabel.position = SCNVector3(x: 0, y: lowNode[7].y * scale, z: 0)
		self.addChildNode(directionLabel)
		
		//
		
		targetDirectionIndicator = SCNNode()
		targetDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.55, 0), nodeB: SCNVector3(0, 0.7, 0), color: white))
		self.addChildNode(targetDirectionIndicator)
		
		activeDirectionIndicator = SCNNode()
		activeDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.4, -0.1), nodeB: SCNVector3(0, 0.55, -0), color: grey))
		self.addChildNode(activeDirectionIndicator)
		
		staticDirectionIndicator = SCNNode()
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, -0.1), nodeB: SCNVector3(0, 0.4, -0), color: cyan))
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, -0.1), nodeB: SCNVector3(0, -0.4, -0), color: red))
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0.2, 0, -0.1), nodeB: SCNVector3(0.4, 0, -0), color: red))
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(-0.2, 0, -0.1), nodeB: SCNVector3(-0.4, 0, -0), color: red))
		self.addChildNode(staticDirectionIndicator)
		
		eventsDirectionIndicator = SCNNode()
		eventsDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, -0.1), nodeB: SCNVector3(0.2, 0, -0), color: white))
		eventsDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, -0.1), nodeB: SCNVector3(-0.2, 0, -0), color: white))
		self.addChildNode(eventsDirectionIndicator)
		
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
		if capsule != nil {
			let targetDirectionNormal = Double(Float(targetDirection - capsule.direction)/180) * 1
			targetDirectionIndicator.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * targetDirectionNormal))
			let staticDirectionNormal = Double(Float(capsule.direction)/180) * 1
			staticDirectionIndicator.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * staticDirectionNormal))
			let eventsDirectionNormal = Double(Float(targetDirection - capsule.direction)/180) * 1
			eventsDirectionIndicator.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * eventsDirectionNormal))
			
			directionLabel.update(String(format: "%.0f",Float(targetDirection - capsule.direction)))
		}
	}
	
	override func tic()
	{
		if input.origin == nil { return }
		
		input.origin.host.bang(true)
		
		let testOri = abs(targetDirection - capsule.direction) % 360
		
		if testOri == 0 {}
		else if testOri >= 180 { capsule.direction! -= 1 }
		else if Int(capsule.direction) < Int(targetDirection) { capsule.direction! += 1 }
		else if Int(capsule.direction) > Int(targetDirection) { capsule.direction! -= 1 }
	}
	
	override func listen(event:SCNEvent)
	{
		targetDirection = (angleBetweenTwoPoints(capsule.location, point2: event.location, center: event.location) + 270) % 360
		self.update()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}