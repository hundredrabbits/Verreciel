
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelBattery : MainPanel
{
	var cellPort1:SCNPortSlot!
	var cellPort2:SCNPortSlot!
	var cellPort3:SCNPortSlot!
	
	var enigmaLabel:SCNLabel!
	var thrusterLabel:SCNLabel!
	var radioLabel:SCNLabel!
	var mapLabel:SCNLabel!
	var shieldLabel:SCNLabel!
	
	var enigmaPort:SCNPort!
	var thrusterPort:SCNPort!
	var radioPort:SCNPort!
	var mapPort:SCNPort!
	var shieldPort:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "battery"
		info = "[missing text]"
	
		// Cells
		
		let distance:Float = 0.3
		
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
		
		enigmaPort = SCNPort(host: self, input:Item.self)
		enigmaPort.position = SCNVector3(x: distance, y: 2 * templates.lineSpacing, z: 0)
		enigmaLabel = SCNLabel(text: "shield", scale: 0.1, align: alignment.left)
		enigmaLabel.position = SCNVector3(x: 0.3, y: 0, z: 0)
		enigmaPort.addChildNode(enigmaLabel)
		mainNode.addChildNode(enigmaPort)
		
		thrusterPort = SCNPort(host: self, input:Item.self)
		thrusterPort.position = SCNVector3(x: distance, y: templates.lineSpacing, z: 0)
		thrusterLabel = SCNLabel(text: "thruster", scale: 0.1, align: alignment.left)
		thrusterLabel.position = SCNVector3(x: 0.3, y: 0, z: 0)
		thrusterPort.addChildNode(thrusterLabel)
		mainNode.addChildNode(thrusterPort)
		
		radioPort = SCNPort(host: self, input:Item.self)
		radioPort.position = SCNVector3(x: distance, y: 0, z: 0)
		radioLabel = SCNLabel(text: "radio", scale: 0.1, align: alignment.left)
		radioLabel.position = SCNVector3(x: 0.3, y: 0, z: 0)
		radioPort.addChildNode(radioLabel)
		mainNode.addChildNode(radioPort)
		
		mapPort = SCNPort(host: self, input:Item.self)
		mapPort.position = SCNVector3(x: distance, y:  -templates.lineSpacing, z: 0)
		mapLabel = SCNLabel(text: "cloak", scale: 0.1, align: alignment.left)
		mapLabel.position = SCNVector3(x: 0.3, y: 0, z: 0)
		mapPort.addChildNode(mapLabel)
		mainNode.addChildNode(mapPort)
		
		shieldPort = SCNPort(host: self, input:Item.self)
		shieldPort.position = SCNVector3(x: distance, y: 2 * -templates.lineSpacing, z: 0)
		shieldLabel = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		shieldLabel.position = SCNVector3(x: 0.3, y: 0, z: 0)
		shieldPort.addChildNode(shieldLabel)
		mainNode.addChildNode(shieldPort)
		
		enigmaLabel.update("--", color: grey)
		thrusterLabel.update("--", color: grey)
		radioLabel.update("--", color: grey)
		mapLabel.update("--", color: grey)
		shieldLabel.update("--", color: grey)
		
		port.input = Item.self
		port.output = Event.self
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(0,0,-1),host:self))
		
		installThruster()
	}
	
	func contains(item:Item) -> Bool
	{
		if cellPort1.event != nil && cellPort1.event == item { return true }
		if cellPort2.event != nil && cellPort2.event == item { return true }
		if cellPort3.event != nil && cellPort3.event == item { return true }
		return false
	}

	// MARK: Modules -
	
	func installEnigma()
	{
		enigmaPort.enable()
		enigmaLabel.update("enigma",color:white)
		if player != nil && debug.isActive == false { player.lookAt(deg: 0) }
	}
	
	func installThruster()
	{
		thrusterPort.enable()
		thrusterLabel.update("thruster",color:white)
		if player != nil && debug.isActive == false { player.lookAt(deg: 0) }
	}
	
	func installRadio()
	{
		radioPort.enable()
		radioLabel.update("radio",color:white)
		if player != nil && debug.isActive == false { player.lookAt(deg: 0) }
	}
	
	func installMap()
	{
		mapPort.enable()
		mapLabel.update("map",color:white)
		if player != nil && debug.isActive == false { player.lookAt(deg: 0) }
	}
	
	func installShield()
	{
		shieldPort.enable()
		shieldLabel.update("shield",color:white)
		if player != nil { player.lookAt(deg: 0) }
	}
	
	func isEnigmaPowered() -> Bool
	{
		if enigmaPort.isReceivingItemOfType(ItemTypes.battery) { return true }
		return false
	}
	
	func isThrusterPowered() -> Bool
	{
		if thrusterPort.isReceivingItemOfType(ItemTypes.battery) { return true }
		return false
	}
	
	func isRadioPowered() -> Bool
	{
		if radioPort.isReceivingItemOfType(ItemTypes.battery) { return true }
		return false
	}
	
	func isMapPowered() -> Bool
	{
		if mapPort.isReceivingItemOfType(ItemTypes.battery) { return true }
		return false
	}
	
	func isShieldPowered() -> Bool
	{
		if shieldPort.isReceivingItemOfType(ItemTypes.battery) { return true }
		return false
	}
	
	// MARK: Flags -
	
	override func listen(event: Event)
	{
		
	}
	
	override func onConnect()
	{
		refresh()
	}
	
	override func onDisconnect()
	{
		refresh()
	}
	
	override func refresh()
	{
		if thrusterPort.isReceivingItemOfType(.battery) == true { thruster.onPowered() } else { thruster.onUnpowered() }
		if shieldPort.isReceivingItemOfType(.battery) == true { shield.onUnpowered() } else { shield.onUnpowered() }
		if enigmaPort.isReceivingItemOfType(.battery) == true { enigma.onUnpowered() } else { enigma.onUnpowered() }
		if mapPort.isReceivingItemOfType(.battery) == true { map.onUnpowered() } else { map.onUnpowered() }
		if radioPort.isReceivingItemOfType(.battery) == true { radio.onUnpowered() } else { radio.onUnpowered() }
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
		
		if debug.isActive == false { player.lookAt(deg: 0) }
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}