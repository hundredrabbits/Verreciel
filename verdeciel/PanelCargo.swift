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
	
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	var line5:SCNLine!
	var line6:SCNLine!
	
	// Ports

	var input:SCNPort!
	var output:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "cargo"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z - 0.2)
		
		let warpGate = SCNEvent(newName: "warpgate", location: CGPoint(x: 0, y: 1), size: 1, type: eventTypes.location, details: "warp",note:"warp to world 1")
		self.addEvent(warpGate)
		
		let starMap = SCNEvent(newName: "starmap", location: CGPoint(x: 4, y: 4), size: 1, type: eventTypes.waypoint, details: "waypoint",note:"go somewhere")
		self.addEvent(starMap)
		
		let bullet = SCNEvent(newName: "bullet", size: 19, type: eventTypes.item, details: "ammo",note:"default ammo")
		self.addEvent(bullet)
		
		let disk = SCNEvent(newName: "disk", size: 1, type: eventTypes.item, details: "cypher",note:"crack something")
		self.addEvent(disk)
		
		update()
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		nameLabel = SCNLabel(text: self.name!, scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(nameLabel)
		
		// Quantity
		
		line1 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.5, z: 0),color:white)
		line2 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.3, z: 0),color:white)
		line3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.1, z: 0),color:white)
		line4 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.1, z: 0),color:grey)
		line5 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.3, z: 0),color:grey)
		line6 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.5, z: 0),color:grey)
			
		self.addChildNode(line1)
		self.addChildNode(line2)
		self.addChildNode(line3)
		self.addChildNode(line4)
		self.addChildNode(line5)
		self.addChildNode(line6)
		
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
	
	func addEvent(event:SCNEvent)
	{
		cargohold.content.append(event)
	}
	
	func removeEvent(event:SCNEvent)
	{
		// TODO
	}
	
	override func update()
	{
		let newCargohold = SCNEvent(newName: "cargohold", type: eventTypes.stack)
		for item in cargohold.content {
			if item.size > 0 {
				newCargohold.content.append(item)
			}
		}
		cargohold = newCargohold
		
		line1.color(grey)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
		line5.color(grey)
		line6.color(grey)
		
		if cargohold.content.count > 0 { line1.color(white) }
		if cargohold.content.count > 1 { line2.color(white) }
		if cargohold.content.count > 2 { line3.color(white) }
		if cargohold.content.count > 3 { line4.color(white) }
		if cargohold.content.count > 4 { line5.color(white) }
		if cargohold.content.count > 5 { line6.color(white) }
	}
	
	override func touch()
	{
		self.bang()
	}
	
	override func bang(param:Bool = true)
	{
		self.update()
		if output.connection != nil {
			output.connection.host.listen(cargohold)
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}