//
//  PanelBeacon.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelHatch : Panel
{
	var load:Event!

	var outline1:SCNLine!
	var outline2:SCNLine!
	var outline3:SCNLine!
	var outline4:SCNLine!
	
	override func setup()
	{
		name = "hatch"
		
		interface.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.7, z: 0),nodeB: SCNVector3(x: 0.7, y: 0, z: 0),color:grey))
		interface.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.7, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.7, z: 0),color:grey))
		interface.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.7, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: 0.7, z: 0),color:grey))
		interface.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.7, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.7, z: 0),color:grey))
		
		outline1 = SCNLine(nodeA: SCNVector3(x: 0, y: 0.5, z: 0), nodeB:SCNVector3(x: 0.5, y: 0, z: 0),color:red)
		interface.addChildNode(outline1)
		outline2 = SCNLine(nodeA: SCNVector3(x: 0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.5, z: 0),color:red)
		interface.addChildNode(outline2)
		outline3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: 0.5, z: 0),color:red)
		interface.addChildNode(outline3)
		outline4 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.5, z: 0),color:red)
		interface.addChildNode(outline4)
		
		// Trigger
		
		interface.addChildNode(SCNTrigger(host: self, size: CGSize(width: 2, height: 2)))
		
		port.input = eventTypes.item
		port.output = eventTypes.unknown
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.update("--", color: grey)
	}

	override func touch(id:Int = 0)
	{
		bang()
	}
	
	override func bang()
	{
		if port.origin == nil { return }
		
		let command = port.origin.host as! SCNCommand
		
		if load.type != eventTypes.item {
			return
		}
		
		if command.port.event.size > 0 {
			command.port.event.size -= 1
			command.update()
		}
		
		if command.port.event.size < 1 {
			command.inject(SCNCommand(text: "--", details: itemTypes.unknown, color: grey, event: command.port.event))
			command.port.disconnect()
			self.load = nil
			cargo.bang()
		}
		
		update()
	}
	
	override func update()
	{
		if port.origin == nil {
			load = nil
		}
		
		if load != nil && load.type != eventTypes.item {
			label.update("hatch")
			details.update("error", color: red)
			outline1.color(red)
			outline2.color(red)
			outline3.color(red)
			outline4.color(red)
			return
		}
		else if load != nil {
			label.update("fire")
			details.update(String(Int(self.load.size)), color: white)
			outline1.color(cyan)
			outline2.color(cyan)
			outline3.color(cyan)
			outline4.color(cyan)
		}
		else{
			label.update("hatch")
			details.update("")
			outline1.color(grey)
			outline2.color(grey)
			outline3.color(grey)
			outline4.color(grey)
		}
	}
	
	override func listen(event:Event)
	{
		if event.isQuest == true {
			details.update("error", color: red)
		}
		else{
			self.load = event
			self.update()
		}
	}
	
	override func onInstallationBegin()
	{
		ui.addWarning("Installing", duration: 3)
		player.lookAt(deg: -315)
	}
}