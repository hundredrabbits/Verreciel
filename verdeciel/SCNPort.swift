//
//  SCNToggle.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

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
	
	init(host:SCNNode)
	{
		super.init()
	
		self.geometry = SCNPlane(width: 0.3, height: 0.3)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		let trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
		
		self.host = host
		
		setup()
		
		update()
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
	
	override func update()
	{
		if( origin != nil ){
			sprite_input.updateChildrenColors(red)
		}
		else{
			sprite_input.updateChildrenColors(grey)
		}
		
		if( connection != nil ){
			sprite_output.updateChildrenColors(cyan)
		}
		else{
			sprite_output.updateChildrenColors(grey)
		}
	}
	
	func activate()
	{
		isActive = true
		sprite_output.updateChildrenColors(cyan)
		print("cyan")
	}
	
	func desactivate()
	{
		isActive = false
		sprite_output.updateChildrenColors(grey)
		print("grey")
	}
	
	func enable()
	{
		isEnabled = true
		update()
	}
	
	func disable()
	{
		isEnabled = false
		update()
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
		self.connection = port
		self.connection.origin = self
		
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
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}