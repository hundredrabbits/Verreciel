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

class PanelHatch : SCNNode
{
	var nameLabel = SCNLabel(text: "")
	var quantityLabel = SCNLabel(text: "")
	
	var load:Event!

	var outline1:SCNLine!
	var outline2:SCNLine!
	var outline3:SCNLine!
	var outline4:SCNLine!
	
	// Ports
	
	var input:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "hatch"
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
		
		quantityLabel = SCNLabel(text: "", scale: 0.1, align: alignment.center)
		quantityLabel.position = SCNVector3(x: 0, y: lowNode[7].y * scale, z: 0)
		self.addChildNode(quantityLabel)
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.7, y: highNode[7].y * scale, z: 0)
		
		self.addChildNode(input)
		
		// Button
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.7, z: 0),nodeB: SCNVector3(x: 0.7, y: 0, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.7, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.7, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.7, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: 0.7, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.7, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.7, z: 0),color:grey))
		
		outline1 = SCNLine(nodeA: SCNVector3(x: 0, y: 0.5, z: 0), nodeB:SCNVector3(x: 0.5, y: 0, z: 0),color:red)
		self.addChildNode(outline1)
		outline2 = SCNLine(nodeA: SCNVector3(x: 0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.5, z: 0),color:red)
		self.addChildNode(outline2)
		outline3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: 0.5, z: 0),color:red)
		self.addChildNode(outline3)
		outline4 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.5, z: 0),color:red)
		self.addChildNode(outline4)

		// Trigger
		
		self.addChildNode(SCNTrigger(host: self, size: 2, operation: true))
	}
	
	override func touch()
	{
		bang(true)
	}
	
	override func bang(param: Bool)
	{
		if input.origin == nil { return }
		
		let command = input.origin.host as! SCNCommand
		
		if load.type != eventTypes.item {
			return
		}
		
		if command.event.size > 0 {
			command.event.size -= 1
			command.update()
		}
		
		if command.event.size < 1 {
			command.update(SCNCommand(text: "--", details: "", color: grey, event: command.event))
			command.output.disconnect()
			self.load = nil
			cargo.bang(true)
		}
		update()
		
	}
	
	override func update()
	{
		if input.origin == nil {
			load = nil
		}
		
		if load != nil && load.type != eventTypes.item {
			nameLabel.update("hatch")
			quantityLabel.updateWithColor("error", color: red)
			outline1.color(red)
			outline2.color(red)
			outline3.color(red)
			outline4.color(red)
			return
		}
		else if load != nil {
			nameLabel.update("fire")
			quantityLabel.update(String(Int(self.load.size)))
			outline1.color(cyan)
			outline2.color(cyan)
			outline3.color(cyan)
			outline4.color(cyan)
		}
		else{
			nameLabel.update("hatch")
			quantityLabel.update("")
			outline1.color(grey)
			outline2.color(grey)
			outline3.color(grey)
			outline4.color(grey)
		}
	}
	
	override func listen(event:Event)
	{
		self.load = event
		self.update()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}