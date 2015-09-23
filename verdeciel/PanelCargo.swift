//
//  File.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelCargo : SCNNode
{
	var nameLabel = SCNNode()
	var cargohold = SCNEvent(newName: "cargohold", type: eventTypes.stack)
	
	// Ports

	var input:SCNPort!
	var output:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "cargo"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z - 0.2)
		
		// TEST Waypoints
		cargohold.content.append(SCNEvent(newName: "waypoint", location: CGPoint(x: 0, y: 1), size: 1, type: eventTypes.location, details: "warp"))
		
//		cargohold.content.append(SCNEvent(newName: "lifeforms", type: eventTypes.item, details: "element"))
//		cargohold.content.append(SCNEvent(newName: "bullets", type: eventTypes.item, details: "ammo", count: 31))
		
		update()
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		nameLabel = SCNLabel(text: self.name!, scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(nameLabel)
		
		// Quantity
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.5, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.3, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.1, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.1, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.3, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.5, z: 0),color:grey))
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.7, y: highNode[7].y * scale, z: 0)
		output = SCNPort(host: self,polarity: true)
		output.position = SCNVector3(x: lowNode[0].x * scale - 0.7, y: highNode[7].y * scale, z: 0)
		
		self.addChildNode(input)
		self.addChildNode(output)
		
		// Trigger
		
		self.addChildNode(SCNTrigger(host: self, size: 2, operation: true))
	}
	
	override func touch()
	{
		self.bang()
	}
	
	override func bang(param:Bool = true)
	{
		if output.connection != nil {
			output.connection.host.listen(cargohold)
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}