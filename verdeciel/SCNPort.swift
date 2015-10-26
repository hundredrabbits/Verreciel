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
	var connection:SCNPort!
	var wire:SCNWire!
	
	var origin:SCNPort!
	
	var host = SCNNode!()
	var trigger = SCNTrigger!()
	
	var sprite_output = SCNNode()
	var sprite_input = SCNNode()
	
	init(host:SCNNode = SCNNode(), position:SCNVector3 = SCNVector3())
	{
		super.init()
	
		self.geometry = SCNPlane(width: 0.3, height: 0.3)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
		
		self.host = host
		
		setup()
		
		update()
		
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
		
		if isEnabled == false {
			sprite_input.updateChildrenColors(clear)
			sprite_output.updateChildrenColors(grey)
			return
		}
		
		if player.port != nil && player.port == self {
			sprite_output.updateChildrenColors(cyan)
			sprite_output.blink()
			return
		}
		
		// Empty cargo node
		if event != nil && event.type == eventTypes.cargo && event.content.count == 0 {
			sprite_input.updateChildrenColors(clear)
			sprite_output.updateChildrenColors(grey)
			return
		}
		
		if event == nil && connection != nil {
			sprite_output.updateChildrenColors(white)
			wire.isActive = false
			return
		}
		
		if origin != nil {
			sprite_input.updateChildrenColors(red)
		}
		else {
			sprite_input.updateChildrenColors(grey)
		}
		
		if event != nil {
			sprite_output.updateChildrenColors(cyan)
		}
		else {
			sprite_output.updateChildrenColors(grey)
		}
		
		wire.isActive = true
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
		update()
	}
	
	func removeEvent()
	{
		self.event = nil
		update()
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
		
		update()
		connection.update()
	}
	
	override func disconnect()
	{
		if self.connection == nil { return }
	
		let targetOrigin = self.connection.host
		
		self.connection.origin = nil
		connection.update()
		self.connection = nil
		
		update()
		
		targetOrigin.disconnect()
		targetOrigin.update()
		
		wire.disable()
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