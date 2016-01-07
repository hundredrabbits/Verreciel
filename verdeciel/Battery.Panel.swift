
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelBattery : MainPanel
{
	var oxygenPort:SCNPort!
	
	var shieldPort:SCNPort!
	var shieldLabel:SCNLabel!
	
	var cloakPort:SCNPort!
	var thrusterPort:SCNPort!
	var radioLabel:SCNLabel!
	var radioPort:SCNPort!
	
	var cellPort1:SCNPortSlot!
	var cellPort2:SCNPortSlot!
	var cellPort3:SCNPortSlot!
	
	override init()
	{
		super.init()
		
		name = "battery"
		
		// Decals
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
		// Cells
		
		let distance:Float = 0.4
		
		cellPort1 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align:.right)
		cellPort1.position = SCNVector3(x: -distance, y: templates.lineSpacing, z: 0)
		cellPort1.enable()
		mainNode.addChildNode(cellPort1)
		
		cellPort2 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align:.right)
		cellPort2.position = SCNVector3(x: -distance, y: 0, z: 0)
		cellPort2.enable()
		mainNode.addChildNode(cellPort2)
		
		cellPort3 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align:.right)
		cellPort3.position = SCNVector3(x: -distance, y: -templates.lineSpacing, z: 0)
		cellPort3.enable()
		mainNode.addChildNode(cellPort3)
		
		// Systems
		
		thrusterPort = SCNPort(host: self, input:Item.self)
		thrusterPort.position = SCNVector3(x: distance, y: templates.lineSpacing, z: 0)
		let thrusterLabel = SCNLabel(text: "thruster", scale: 0.1, align: alignment.left)
		thrusterLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		thrusterPort.addChildNode(thrusterLabel)
		mainNode.addChildNode(thrusterPort)
		
		radioPort = SCNPort(host: self, input:Item.self)
		radioPort.position = SCNVector3(x: distance, y: 0, z: 0)
		radioLabel = SCNLabel(text: "radio", scale: 0.1, align: alignment.left)
		radioLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		radioPort.addChildNode(radioLabel)
		mainNode.addChildNode(radioPort)
		
		oxygenPort = SCNPort(host: self, input:Item.self)
		oxygenPort.position = SCNVector3(x: distance, y: 2 * -templates.lineSpacing, z: 0)
		let oxygenLabel = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		oxygenLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		oxygenPort.addChildNode(oxygenLabel)
		mainNode.addChildNode(oxygenPort)
		
		shieldPort = SCNPort(host: self, input:Item.self)
		shieldPort.position = SCNVector3(x: distance, y: -templates.lineSpacing, z: 0)
		shieldLabel = SCNLabel(text: "shield", scale: 0.1, align: alignment.left)
		shieldLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		shieldPort.addChildNode(shieldLabel)
		mainNode.addChildNode(shieldPort)
		
		cloakPort = SCNPort(host: self, input:Item.self)
		cloakPort.position = SCNVector3(x: distance, y:  2 * templates.lineSpacing, z: 0)
		let cloakLabel = SCNLabel(text: "cloak", scale: 0.1, align: alignment.left)
		cloakLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		cloakPort.addChildNode(cloakLabel)
		mainNode.addChildNode(cloakPort)
		
		cloakLabel.update("--", color: grey)
		shieldLabel.update("--", color: grey)
		radioLabel.update("--", color: grey)
		oxygenLabel.update("--", color: grey)
		
		port.input = Item.self
		port.output = Event.self
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(0,0,-1),host:self))
		
		// Start
		thrusterPort.enable()
	}
	
	// MARK: Add Modules -
	
	func installShield()
	{
		shieldPort.enable()
		shieldLabel.update("shield",color:white)
		player.lookAt(deg: 0)
	}
	
	// MARK: Flags -
	
	override func listen(event: Event)
	{
		
	}
	
	override func onConnect()
	{
		if thrusterPort.isReceivingItemOfType(.battery) == true { thruster.refresh() }
	}
	
	override func onDisconnect()
	{
		if thrusterPort.isReceivingItemOfType(.battery) == false { thruster.refresh() }
	}
	
	func isShieldPowered() -> Bool
	{
		return false
	}
	
	func hasCell(target:Event) -> Bool
	{
		if cellPort1.event != nil && cellPort1.event == target { return true }
		if cellPort2.event != nil && cellPort2.event == target { return true }
		if cellPort3.event != nil && cellPort3.event == target { return true }
		return false
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		player.lookAt(deg: 0)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}