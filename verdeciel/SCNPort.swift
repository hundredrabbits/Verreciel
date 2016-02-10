//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPort : SCNNode
{
	var input:Event.Type!
	var output:Event.Type!
	
	var isActive:Bool = false
	var isEnabled:Bool = true
	
	let radius:Float = 0.125
	
	var event:Event!
	var requirement:Event!
	var connection:SCNPort!
	var wire:SCNWire!
	
	var origin:SCNPort!
	
	var host = SCNNode!()
	var trigger = SCNTrigger!()
	
	var sprite_output = SCNNode()
	var sprite_input = SCNNode()
	
	init(host:SCNNode = SCNNode(), input:Event.Type = Event.self, output:Event.Type = Event.self)
	{
		super.init()
		
		self.input = input
		self.output = output
	
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
		wire = SCNWire(nodeA: SCNVector3(0, 0, 0), nodeB: SCNVector3(0, 0, 0))
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
		
		// Compatibility
		wire.isCompatible = false
		if connection != nil {
			if output == Event.self { wire.isCompatible = true }
			else if input == Event.self { wire.isCompatible = true }
			else if output == connection.input { wire.isCompatible = true }
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
		
		connection = port
		connection.origin = self
		
		wire.update(SCNVector3(0, 0, 0), nodeB: convertPosition(SCNVector3(0, 0, 0), fromNode: port))
		
		host.bang()
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
	
	func hasEvent(target:Event) -> Bool
	{
		if event == nil { return false }
		return false
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
	
	func isReceiving(event:Event!) -> Bool
	{
		if origin != nil && origin.event != nil && origin.event == event { return true }
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
	
	func isReceivingLocationOfType(type:LocationTypes) -> Bool
	{
		if origin == nil { return false }
		if origin.event == nil { return false }
		if (origin.event is Location) == false { return false }
		
		let source = origin.event as! Location
		
		if source.type == type { return true }
		
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
	
	override func bang()
	{
		print("Warning! Bang on SCNPort")
	}
	
	override func onConnect()
	{
		print("connected")
	}
	
	override func onDisconnect()
	{
		print("disconnected")
		host.onDisconnect()
	}
	
	func IO(direction:Event.Type) -> String
	{
		if input is Item.Type { return "item" }
		if input is Location.Type { return "location" }
		return "generic"
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}