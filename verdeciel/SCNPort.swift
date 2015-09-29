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
	var outline1:SCNLine!
	var outline2:SCNLine!
	var outline3:SCNLine!
	var outline4:SCNLine!
	
	var polarity:Bool = false
	var isRouted:Bool = false
	var isActive:Bool = false
	
	var event:SCNEvent!
	var connection:SCNPort!
	var wire:SCNLine!
	
	var origin:SCNPort!
	
	var host = SCNNode!()
	var trigger = SCNTrigger!()
	
	init(host:SCNNode,polarity:Bool)
	{
		self.polarity = polarity
		
		super.init()
	
		self.geometry = SCNPlane(width: 0.3, height: 0.3)
		self.geometry?.firstMaterial?.diffuse.contents = red
		
		let trigger = SCNTrigger(host: self, size: 1)
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
		
		self.host = host
		
		addGeometry()
		update()
	}
	
	func addGeometry()
	{
		
		let radius:Float = 0.1
		
		outline1 = SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:white)
		outline2 = SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:white)
		outline3 = SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:white)
		outline4 = SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:white)
		
		self.addChildNode(outline1)
		self.addChildNode(outline2)
		self.addChildNode(outline3)
		self.addChildNode(outline4)
		
		wire = SCNLine(nodeA: SCNVector3(0, 0, 0), nodeB: SCNVector3(0, 0, 0), color: white)
		self.addChildNode(wire)
	}
	
	override func touch()
	{
		player.activatePort(self)
		update()
	}
	
	override func update()
	{
		if( isActive == true ){
			outline1.color(grey)
			outline2.color(grey)
			outline3.color(grey)
			outline4.color(grey)
		}
		else if( polarity == true ){
			outline1.color(cyan)
			outline2.color(cyan)
			outline3.color(cyan)
			outline4.color(cyan)
		}
		else if( polarity == false ){
			outline1.color(red)
			outline2.color(red)
			outline3.color(red)
			outline4.color(red)
		}
		else{
			outline1.color(white)
			outline2.color(white)
			outline3.color(white)
			outline4.color(white)
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
	
	func addEvent(event:SCNEvent)
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
		wire.geometry = SCNLine(nodeA: SCNVector3(0, 0, 0), nodeB: convertPosition(SCNVector3(0, 0, 0), fromNode: port), color: white).geometry
		
		host.bang(true)
	}
	
	func disconnect()
	{
		if self.connection == nil { return }
		
		let targetOrigin = self.connection.host
		
		self.connection.origin = nil
		self.connection = nil
		
		targetOrigin.update()
		
		wire.geometry = SCNLine(nodeA: SCNVector3(0, 0, 0), nodeB: SCNVector3(0, 0, 0), color: white).geometry
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}