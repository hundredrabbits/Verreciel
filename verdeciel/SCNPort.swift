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
		let radius:Float = 0.1
		
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:white))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:white))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:white))
		sprite.addChildNode(SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:white))
		
		wire = SCNWire(nodeA: SCNVector3(0, 0, 0), nodeB: SCNVector3(0, 0, 0))
		
		self.addChildNode(wire)
		self.addChildNode(sprite)
	}
	
	override func touch()
	{
		player.activatePort(self)
		update()
	}
	
	override func update()
	{
		if isEnabled == false {
			sprite.updateChildrenColors(black)
		}
		else if( isActive == true ){
			sprite.updateChildrenColors(grey)
		}
		else if( polarity == true ){
			sprite.updateChildrenColors(cyan)
			if event == nil { wire.color(grey) }
			else{ wire.color(white) }
		}
		else if( polarity == false ){
			sprite.updateChildrenColors(red)
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
	}
	
	override func disconnect()
	{
		if self.connection == nil { return }
	
		let targetOrigin = self.connection.host
		
		self.connection.origin = nil
		self.connection = nil
		
		targetOrigin.disconnect()
		targetOrigin.update()
		
		wire.reset()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}