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
	var sprite = SCNNode()
	
	var polarity:Bool = false
	var isRouted:Bool = false
	var isActive:Bool = false
	var isEnabled:Bool = true
	
	let radius:Float = 0.125
	
	var event:Event!
	var connection:SCNPort!
	var wire:SCNWire!
	
	var origin:SCNPort!
	
	var host = SCNNode!()
	var trigger = SCNTrigger!()
	
	init(host:SCNNode,polarity:Bool)
	{
		self.polarity = polarity
		
		super.init()
	
		self.geometry = SCNPlane(width: 0.3, height: 0.3)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		let trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
		
		self.host = host
		
		addGeometry()
		update()
	}
	
	func addGeometry()
	{
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:white))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:white))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:white))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:white))
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius/2, z: 0),nodeB: SCNVector3(x: radius/2, y: 0, z: 0),color:white))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius/2, z: 0),color:white))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius/2, z: 0),nodeB: SCNVector3(x: -radius/2, y: 0, z: 0),color:white))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius/2, z: 0),color:white))
		
		if polarity == true {
			wire = SCNWire(nodeA: SCNVector3(0, 0, 0), nodeB: SCNVector3(0, 0, 0))
			self.addChildNode(wire)
		}
		
		self.addChildNode(sprite)
	}
	
	override func touch(id:Int = 0)
	{
		player.activatePort(self)
		update()
	}
	
	override func update()
	{
		if isEnabled == false {
			sprite.empty()
			sprite.add(sprite_disabled())
		}
		else if( isActive == true ){
			sprite.empty()
			sprite.add(sprite_selected())
		}
		else if( polarity == true ){
			sprite.empty()
			if connection != nil {
				sprite.add(sprite_output_connected())
			}
			else{
				sprite.add(sprite_output())
			}
		}
		else if( polarity == false ){
			sprite.empty()
			if origin != nil {
				sprite.add(sprite_input_connected())
			}
			else{
				sprite.add(sprite_input())
			}
		}
		else{
			sprite.updateChildrenColors(white)
		}
	}
	
	func activate()
	{
		isActive = true
		update()
	}
	
	func desactivate()
	{
		isActive = false
		update()
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
		
		host.bang(true)
		wire.enable()
		
		update()
		connection.update()
	}
	
	func sprite_disabled() -> SCNNode
	{
		let sprite = SCNNode()
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:grey))
		
		return sprite
	}
	
	func sprite_input() -> SCNNode
	{
		let sprite = SCNNode()
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius/2, z: 0),nodeB: SCNVector3(x: radius/2, y: 0, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius/2, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius/2, z: 0),nodeB: SCNVector3(x: -radius/2, y: 0, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius/2, z: 0),color:grey))
		
		return sprite
	}
	
	func sprite_input_connected() -> SCNNode
	{
		let sprite = SCNNode()
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius/2, z: 0),nodeB: SCNVector3(x: radius/2, y: 0, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius/2, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius/2, z: 0),nodeB: SCNVector3(x: -radius/2, y: 0, z: 0),color:red))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius/2, z: 0),color:red))
		
		return sprite
	}
	
	func sprite_output() -> SCNNode
	{
		let sprite = SCNNode()
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:cyan))
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius/2, z: 0),nodeB: SCNVector3(x: radius/2, y: 0, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius/2, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius/2, z: 0),nodeB: SCNVector3(x: -radius/2, y: 0, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius/2, z: 0),color:grey))
		
		return sprite
	}
	
	func sprite_output_connected() -> SCNNode
	{
		let sprite = SCNNode()
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:cyan))
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius/2, z: 0),nodeB: SCNVector3(x: radius/2, y: 0, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius/2, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius/2, z: 0),nodeB: SCNVector3(x: -radius/2, y: 0, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius/2, z: 0),color:cyan))
		
		return sprite
	}
	
	func sprite_selected() -> SCNNode
	{
		let sprite = SCNNode()
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:grey))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:grey))
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius/2, z: 0),nodeB: SCNVector3(x: radius/2, y: 0, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius/2, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius/2, z: 0),nodeB: SCNVector3(x: -radius/2, y: 0, z: 0),color:cyan))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius/2, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius/2, z: 0),color:cyan))
		
		return sprite
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