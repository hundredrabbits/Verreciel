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

class PanelBattery : SCNNode
{
	var value:Float = 0
	
	// Ports
	
	var inputLabel:SCNLabel!
	var input:SCNPort!
	
	var inOxygen:SCNPort!
	var inShield:SCNPort!
	var inCloak:SCNPort!
	var inThruster:SCNPort!
	var inRadio:SCNPort!
	
	var outCell1:SCNPort!
	var outCell2:SCNPort!
	var outCell3:SCNPort!
	
	override init()
	{
		super.init()
		name = "battery"
		addInterface()
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		// Draw Radar
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		// Cells
		
		let distance:Float = 0.4
		let verticalOffset:Float = 0.4
		
		outCell1 = SCNPort(host: self, polarity: true)
		outCell1.position = SCNVector3(x: -distance, y: 0, z: 0)
		outCell1.addEvent(Event(type:eventTypes.cell))
		let cell1Label = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cell1Label.position = SCNVector3(x: -distance - 0.2, y:0, z: 0)
		self.addChildNode(cell1Label)
		self.addChildNode(outCell1)
		
		outCell2 = SCNPort(host: self, polarity: true)
		outCell2.position = SCNVector3(x: -distance, y: 0 - verticalOffset, z: 0)
		outCell2.addEvent(Event(type:eventTypes.cell))
		let cell2Label = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cell2Label.position = SCNVector3(x: -distance - 0.2, y: -verticalOffset, z: 0)
		self.addChildNode(cell2Label)
		self.addChildNode(outCell2)
		
		outCell3 = SCNPort(host: self, polarity: true)
		outCell3.position = SCNVector3(x: -distance, y: verticalOffset, z: 0)
		outCell3.addEvent(Event(type:eventTypes.cell))
		let cell3Label = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cell3Label.position = SCNVector3(x: -distance - 0.2, y: verticalOffset, z: 0)
		self.addChildNode(cell3Label)
		self.addChildNode(outCell3)
		
		// Systems
		
		inThruster = SCNPort(host: self, polarity: false)
		inThruster.position = SCNVector3(x: distance, y: 0, z: 0)
		let test1Label = SCNLabel(text: "thruster", scale: 0.1, align: alignment.left)
		test1Label.position = SCNVector3(x: distance + 0.2, y: 0, z: 0)
		self.addChildNode(test1Label)
		self.addChildNode(inThruster)
		
		inOxygen = SCNPort(host: self, polarity: false)
		inOxygen.position = SCNVector3(x: distance, y: verticalOffset, z: 0)
		let oxygenLabel = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		oxygenLabel.position = SCNVector3(x: distance + 0.2, y: verticalOffset, z: 0)
		self.addChildNode(oxygenLabel)
		self.addChildNode(inOxygen)
		
		inShield = SCNPort(host: self, polarity: false)
		inShield.position = SCNVector3(x: distance, y: 2 * verticalOffset, z: 0)
		let shieldLabel = SCNLabel(text: "shield", scale: 0.1, align: alignment.left)
		shieldLabel.position = SCNVector3(x: distance + 0.2, y: 2 * verticalOffset, z: 0)
		self.addChildNode(shieldLabel)
		self.addChildNode(inShield)
		
		inCloak = SCNPort(host: self, polarity: false)
		inCloak.position = SCNVector3(x: distance, y: -verticalOffset, z: 0)
		let cloakLabel = SCNLabel(text: "cloak", scale: 0.1, align: alignment.left)
		cloakLabel.position = SCNVector3(x: distance + 0.2, y: -verticalOffset, z: 0)
		self.addChildNode(cloakLabel)
		self.addChildNode(inCloak)
		
		inRadio = SCNPort(host: self, polarity: false)
		inRadio.position = SCNVector3(x: distance, y: 2 * -verticalOffset, z: 0)
		let radioLabel = SCNLabel(text: "radio", scale: 0.1, align: alignment.left)
		radioLabel.position = SCNVector3(x: distance + 0.2, y: 2 * -verticalOffset, z: 0)
		self.addChildNode(radioLabel)
		self.addChildNode(inRadio)
		
		// Ports
		
		input = SCNPort(host: self, polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.1, y: highNode[7].y * scale, z: 0)
		
		inputLabel = SCNLabel(text: self.name!, scale: 0.1, align: alignment.left)
		inputLabel.position = SCNVector3(x: lowNode[7].x * scale + 0.3, y: highNode[7].y * scale, z: 0)
		inputLabel.updateWithColor(self.name!, color: grey)
		
		self.addChildNode(input)
		self.addChildNode(inputLabel)
	}
	
	override func listen(event:Event)
	{
		if event.type != eventTypes.battery { return }		
		update()
	}
	
	override func tic()
	{
		if value == 0 { return }
		
		// Pulse at system
		
		if value < 0 { value = 0}
		if value > 100 { value = 100}
	}
	
	override func bang(param: Bool)
	{
		thruster.update()
	}
	
	func recharge()
	{
		value += 0.5
	}
	
	func touch(knobId:String)
	{
		
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}