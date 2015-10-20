//
//  PanelConsole.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelBattery : Panel
{
	var value:Float = 0
	
	var inOxygen:SCNPort!
	var inShield:SCNPort!
	var inCloak:SCNPort!
	var inThruster:SCNPort!
	var inRadio:SCNPort!
	
	var outCell1:SCNPort!
	var outCell2:SCNPort!
	var outCell3:SCNPort!
	
	var panelHead:SCNNode!
	
	override func setup()
	{
		name = "battery"
	
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		panelHead = SCNNode()
		port = SCNPort(host: self)
		port.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		label = SCNLabel(text: "battery", scale: 0.1, align: alignment.center)
		label.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		panelHead.addChildNode(port)
		panelHead.addChildNode(label)
		addChildNode(panelHead)
		panelHead.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		// Decals
		
		decals.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
		// Cells
		
		let distance:Float = 0.4
		let verticalOffset:Float = 0.4
		
		outCell1 = SCNPort(host: self)
		outCell1.position = SCNVector3(x: -distance, y: verticalOffset, z: 0)
		outCell1.addEvent(Event(type:eventTypes.cell))
		let cell1Label = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cell1Label.position = SCNVector3(x: -distance - 0.2, y:0, z: 0)
		outCell1.addChildNode(cell1Label)
		interface.addChildNode(outCell1)
		
		outCell2 = SCNPort(host: self)
		outCell2.position = SCNVector3(x: -distance, y: 0, z: 0)
		outCell2.addEvent(Event(type:eventTypes.cell))
		let cell2Label = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cell2Label.position = SCNVector3(x: -distance - 0.2, y: 0, z: 0)
		outCell2.addChildNode(cell2Label)
		interface.addChildNode(outCell2)
		
		outCell3 = SCNPort(host: self)
		outCell3.position = SCNVector3(x: -distance, y: -verticalOffset, z: 0)
		outCell3.addEvent(Event(type:eventTypes.cell))
		let cell3Label = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cell3Label.position = SCNVector3(x: -distance - 0.2, y: 0, z: 0)
		outCell3.addChildNode(cell3Label)
		interface.addChildNode(outCell3)
		
		// Systems
		
		inThruster = SCNPort(host: self)
		inThruster.position = SCNVector3(x: distance, y: 0, z: 0)
		let thrusterLabel = SCNLabel(text: "thruster", scale: 0.1, align: alignment.left)
		thrusterLabel.position = SCNVector3(x: distance + 0.2, y: 0, z: 0)
		interface.addChildNode(thrusterLabel)
		interface.addChildNode(inThruster)
		
		inOxygen = SCNPort(host: self)
		inOxygen.position = SCNVector3(x: distance, y: verticalOffset, z: 0)
		let oxygenLabel = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		oxygenLabel.position = SCNVector3(x: distance + 0.2, y: verticalOffset, z: 0)
		interface.addChildNode(oxygenLabel)
		interface.addChildNode(inOxygen)
		
		inShield = SCNPort(host: self)
		inShield.position = SCNVector3(x: distance, y: 2 * verticalOffset, z: 0)
		let shieldLabel = SCNLabel(text: "shield", scale: 0.1, align: alignment.left)
		shieldLabel.position = SCNVector3(x: distance + 0.2, y: 2 * verticalOffset, z: 0)
		interface.addChildNode(shieldLabel)
		interface.addChildNode(inShield)
		
		inCloak = SCNPort(host: self)
		inCloak.position = SCNVector3(x: distance, y: -verticalOffset, z: 0)
		let cloakLabel = SCNLabel(text: "cloak", scale: 0.1, align: alignment.left)
		cloakLabel.position = SCNVector3(x: distance + 0.2, y: -verticalOffset, z: 0)
		interface.addChildNode(cloakLabel)
		interface.addChildNode(inCloak)
		
		inRadio = SCNPort(host: self)
		inRadio.position = SCNVector3(x: distance, y: 2 * -verticalOffset, z: 0)
		let radioLabel = SCNLabel(text: "radio", scale: 0.1, align: alignment.left)
		radioLabel.position = SCNVector3(x: distance + 0.2, y: 2 * -verticalOffset, z: 0)
		interface.addChildNode(radioLabel)
		interface.addChildNode(inRadio)
		
		cell3Label.updateWithColor("--", color: grey)
		outCell3.disable()
		
		cloakLabel.updateWithColor("--", color: grey)
		shieldLabel.updateWithColor("--", color: grey)
		radioLabel.updateWithColor("--", color: grey)
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.updateWithColor(name!, color: grey)
	}
	
	override func listen(event:Event)
	{
		if event.details != eventDetails.battery { return }
		
		let command = port.origin.host as! SCNCommand
		
		if command.event.size > 0 {
			self.value += command.event.size
			command.event.size = 0
			command.update()
			cargo.bang()
		}
	}
	
	override func fixedUpdate()
	{
		if value == 0 { return }
		
		// Pulse at system
		
		if value < 0 { value = 0}
		if value > 100 { value = 100}
	}
	
	override func bang()
	{
		thruster.update()
	}
	
	func recharge()
	{
		value += 0.5
	}
}