//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPort : SCNNode
{
	var isActive:Bool = false
	var isEnabled:Bool = true
	
	let radius:Float = 0.125
	
	var event:Event!
	var requirement:Event!
	var connection:SCNPort!
	var wire:SCNWire!
	
	var origin:SCNPort!
	
	var host:SCNNode!
	var trigger:SCNTrigger!
	
	var sprite_output = SCNNode()
	var sprite_input = SCNNode()
	
	init(host:SCNNode = SCNNode())
	{
		super.init()
	
		self.geometry = SCNPlane(width: 0.3, height: 0.3)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
		
		self.host = host
		
		setup()
		disable()
	}
	
	func setup()
	{
		wire = SCNWire(host:self, nodeA: SCNVector3(0, 0, 0), nodeB: SCNVector3(0, 0, 0))
		self.addChildNode(wire)
		
		sprite_input.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius/2, z: 0),nodeB: SCNVector3(x: radius/2, y: 0, z: 0),color:white))
		sprite_input.addChildNode(SCNLine(nodeA: SCNVector3(x: radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius/2, z: 0),color:white))
		sprite_input.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius/2, z: 0),nodeB: SCNVector3(x: -radius/2, y: 0, z: 0),color:white))
		sprite_input.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius/2, z: 0),color:white))
		addChildNode(sprite_input)
		
		sprite_output.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:white))
		sprite_output.addChildNode(SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:white))
		sprite_output.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:white))
		sprite_output.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:white))
		addChildNode(sprite_output)
	}
	
	// MARK: Touch -

	override func touch(id:Int = 0)
	{
		if isEnabled == false { return }
		
		if player.activePort == nil {
			player.holdPort(self)
		}
		else if player.activePort == self {
			player.releasePort()
		}
		else if player.activePort != self {
			player.connectPorts(player.activePort, to:self)
		}		
	}
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		sprite_input.opacity = 1
		sprite_output.opacity = 1
		
		// Input
		if isEnabled == false {
			sprite_input.updateChildrenColors(clear)
		}
		else if origin == nil {
			sprite_input.updateChildrenColors(grey)
		}
		else {
			sprite_input.updateChildrenColors(red)
		}

		// Output
		if event == nil || isEnabled == false {
			sprite_output.updateChildrenColors(grey)
		}
		else {
			sprite_output.updateChildrenColors(cyan)
		}
		
		// Wire
		wire.isActive = false
		if connection != nil {
			if connection != nil && event != nil {
				wire.isActive = true
			}
		}
		
		// Blink
		if player.activePort != nil && player.activePort == self {
			sprite_output.updateChildrenColors(cyan)
			sprite_output.blink()
			return
		}
	}
	
	func activate()
	{
		isActive = true
	}
	
	func desactivate()
	{
		isActive = false
	}
	
	func enable()
	{
		isEnabled = true
		trigger.enable()
	}
	
	func disable()
	{
		isEnabled = false
		disconnect()
		trigger.disable()
	}
	
	func addEvent(event:Event)
	{
		self.event = event
		update()
	}
	
	func addRequirement(event:Event)
	{
		self.requirement = event
	}
	
	func removeEvent()
	{
		self.event = nil
	}
	
	func connect(port:SCNPort)
	{
		if port.isEnabled == false { print("Port is disabled") ; return }
		if port.origin != nil { print("Port already has input: (\(port.origin))") ; return }
		if port.connection != nil && port.connection == self { print("Loop") ; return }
		
		disconnect()
		connection = port
		connection.origin = self
		
		wire.update(SCNVector3(0, 0, 0), nodeB: convertPosition(SCNVector3(0, 0, 0), fromNode: port))
		
		wire.enable()
		
		connection.host.onConnect()
		connection.onConnect()
		
		self.onConnect()
	}
	
	override func disconnect()
	{
		if connection == nil { return }
	
		let targetOrigin = self.connection.host
		
		self.connection.origin = nil
		connection.update()
		connection.onDisconnect()
		self.connection = nil
		
		targetOrigin.disconnect()
		targetOrigin.update()
		
		self.onDisconnect()
		self.host.onDisconnect()
		
		wire.disable()
	}
	
	func strip()
	{
		disconnect()
		if origin != nil { origin.disconnect() }
	}
	
	func syphon() -> Item
	{
		let stored_origin = origin
		let stored_event = origin.event as! Item
		
		stored_origin.removeEvent()
		stored_origin.host.update()
		stored_origin.update()
		stored_origin.disconnect()
		
		print("syphon \(stored_origin.name)'s \(stored_event.name)")
		
		return stored_event
	}
	
	// MARK: Checks -
	
	func hasEvent(target:Event) -> Bool
	{
		if event == nil { return false }
		if event.name == target.name { return true }
		return false
	}
	
	func hasEvent() -> Bool
	{
		if event != nil { return true }
		return false
	}
	
	func hasItem() -> Bool
	{
		if event == nil { return false }
		if (event is Item) == true { return true }
		return false
	}
	
	func hasItemOfType(target:ItemTypes) -> Bool
	{
		if event == nil { return false }
		if (event is Item) == false { return false }
		if (event as! Item).type == target { return true }
		return false
	}
	
	func hasItemLike(target:Item) -> Bool
	{
		if event == nil { return false }
		if (event is Item) == false { return false }
		if (event as! Item).name == target { return true }
		return false
	}
	
	func isReceiving() -> Bool
	{
		if origin != nil && origin.event != nil { return true }
		return false
	}
	
	func isReceivingFromPanel(panel:Panel) -> Bool
	{
		if origin == nil { return false }
		if (origin.host is Panel) == false { return false }
		if origin.host == panel { return true }
		return false
	}
	
	func isReceiving(event:Event!) -> Bool
	{
		if origin != nil && origin.event != nil && origin.event == event { return true }
		return false
	}
	
	func isReceivingItem(item:Item!) -> Bool
	{
		if origin == nil { return false }
		if origin.event == nil { return false }
		if (origin.event is Item) == false { return false }
		if origin.event == item { return true }
		return false
	}
	
	func isReceivingItemLike(target:Item!) -> Bool
	{
		if origin == nil { return false }
		if origin.event == nil { return false }
		if (origin.event is Item) == false { return false }
		if (origin.event as! Item).name == target.name { return true }
		return false
	}
	
	func isReceivingItemOfType(type:ItemTypes) -> Bool
	{
		if origin == nil { return false }
		if origin.event == nil { return false }
		if (origin.event is Item) == false { return false }
		
		let source = origin.event as! Item
		
		if source.type == type { return true }
		
		return false
	}
	
	func isReceivingLocation() -> Bool
	{
		if origin == nil { return false }
		if origin.event == nil { return false }
		
		if origin.event is Location { return true }
		
		return false
	}
	
	func isReceivingLocationOfTypePortal() -> Bool
	{
		if isReceivingLocation() == false { return false }
		if origin.event is LocationPortal { return true }
		return false
	}
	
	func isReceivingEventOfTypeLocation() -> Bool
	{
		if origin == nil { return false }
		if origin.event == nil { return false }
		if (origin.event is Location) == false { return false }
		return true
	}
	
	func isReceivingEventOfTypeItem() -> Bool
	{
		if origin == nil { return false }
		if origin.event == nil { return false }
		if (origin.event is Item) == false { return false }
		return true
	}
	
	// MARK: Etc..
	
	override func onConnect()
	{
		print("* PORT     | \(host.name) is connected")
	}
	
	override func onDisconnect()
	{
		print("* PORT     | \(host.name) is disconnected")
		host.onDisconnect()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}