//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPort : SCNNode
{
	var input:eventTypes!
	var output:eventTypes!
	
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
	
	init(host:SCNNode = SCNNode(), position:SCNVector3 = SCNVector3(), input:eventTypes = eventTypes.unknown, output:eventTypes = eventTypes.unknown)
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

	override func touch(id:Int = 0)
	{
		player.activatePort(self)
	}
	
	override func fixedUpdate()
	{
		sprite_input.opacity = 1
		sprite_output.opacity = 1
		
		// Input
		if isEnabled == false {
			sprite_input.updateChildrenColors(clear)
		}
		else if requirement != nil {
			sprite_input.updateChildrenColors(red)
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
		if connection != nil{
			wire.isActive = true
			
			if connection == nil {
				wire.isEnabled = false
			}
			else if event == nil {
				wire.isActive = false
			}
			else if event.type != connection.input && connection.input != eventTypes.generic {
				wire.isCompatible = false
			}
			else {
				wire.isActive = true
				wire.isCompatible = true
			}
		}
		
		// Blink
		if player.port != nil && player.port == self {
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
		trigger.disable()
	}
	
	func addEvent(event:Event)
	{
		self.event = event
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
		if port.origin != nil { print("Port already has input") ; return }
		
		connection = port
		connection.origin = self
		
		wire.update(SCNVector3(0, 0, 0), nodeB: convertPosition(SCNVector3(0, 0, 0), fromNode: port))
		
		host.bang()
		wire.enable()
	}
	
	func hasEvent(type:eventTypes = eventTypes.none) -> Bool
	{
		if event == nil { return false }
		if event.type == eventTypes.none && event != nil { return true }
		if event.type == type { return true }
		return false
	}
	
	override func disconnect()
	{
		if self.connection == nil { return }
	
		let targetOrigin = self.connection.host
		
		self.connection.origin = nil
		connection.update()
		self.connection = nil
		
		targetOrigin.disconnect()
		targetOrigin.update()
		
		wire.disable()
	}
	
	func syphon() -> Event
	{
		let eventCopy = origin.event

		origin.event.size = 0
		origin.event.fixedUpdate()
		origin.host.update()
		origin.update()
		origin.disconnect()
		
		return eventCopy
	}
	
	override func bang()
	{
		print("Warning! Bang on SCNPort")
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}