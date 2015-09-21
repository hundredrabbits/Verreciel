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
	
	var host = SCNNode()
	
	init(host:SCNNode,polarity:Bool)
	{
		self.polarity = polarity
		self.host = host
		
		super.init()
		
		addGeometry()
		update()
	}
	
	func addGeometry()
	{
		self.geometry = SCNPlane(width: 1, height: 1)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
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
	
	func update()
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
			outline1.color(grey)
			outline2.color(grey)
			outline3.color(grey)
			outline4.color(grey)
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
		self.event = SCNEvent(newName: "what")
		update()
	}
	
	func connect(port:SCNPort)
	{
		self.connection = port
		wire.geometry = SCNLine(nodeA: SCNVector3(0, 0, 0), nodeB: convertPosition(SCNVector3(0, 0, 0), fromNode: port), color: red).geometry
		
		host.bang()
	}
	
	func disconnect()
	{
		self.connection = nil
		wire.geometry = SCNLine(nodeA: SCNVector3(0, 0, 0), nodeB: SCNVector3(0, 0, 0), color: red).geometry
	}
	
	func bang(event:SCNEvent)
	{
		
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}