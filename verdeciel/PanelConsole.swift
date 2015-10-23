//
//  PanelConsole.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelConsole : Panel
{
	var consoleLine1:SCNCommand!
	var consoleLine2:SCNCommand!
	var consoleLine3:SCNCommand!
	var consoleLine4:SCNCommand!
	var consoleLine5:SCNCommand!
	var consoleLine6:SCNCommand!
	
	var commands:Array<SCNCommand> = [SCNCommand(),SCNCommand(),SCNCommand(),SCNCommand(),SCNCommand(),SCNCommand()]
	
	var panelHead:SCNNode!
	
	override func setup()
	{
		name = "console"
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		panelHead = SCNNode()
		port = SCNPort(host: self)
		port.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		label = SCNLabel(text: name!, scale: 0.1, align: alignment.center)
		label.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		panelHead.addChildNode(port)
		panelHead.addChildNode(label)
		addChildNode(panelHead)
		panelHead.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		// Decals
		
		decals.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
		
		let linesRoot = SCNNode()
		
		let spacing:Float = -0.35
		
		linesRoot.position = SCNVector3(0,templates.topMargin + spacing - 0.2,0)
		
		consoleLine1 = SCNCommand()
		consoleLine1.position = SCNVector3(x: templates.leftMargin, y: (spacing * 0), z: 0)
		linesRoot.addChildNode(consoleLine1)
		
		consoleLine2 = SCNCommand()
		consoleLine2.position = SCNVector3(x: templates.leftMargin, y: (spacing * 1), z: 0)
		linesRoot.addChildNode(consoleLine2)
		
		consoleLine3 = SCNCommand()
		consoleLine3.position = SCNVector3(x: templates.leftMargin, y: (spacing * 2), z: 0)
		linesRoot.addChildNode(consoleLine3)
		
		consoleLine4 = SCNCommand()
		consoleLine4.position = SCNVector3(x: templates.leftMargin, y: (spacing * 3), z: 0)
		linesRoot.addChildNode(consoleLine4)
		
		consoleLine5 = SCNCommand()
		consoleLine5.position = SCNVector3(x: templates.leftMargin, y: (spacing * 4), z: 0)
		linesRoot.addChildNode(consoleLine5)
		
		consoleLine6 = SCNCommand()
		consoleLine6.position = SCNVector3(x: templates.leftMargin, y: (spacing * 5), z: 0)
		linesRoot.addChildNode(consoleLine6)
		
		interface.addChildNode(linesRoot)
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.updateWithColor("--", color: grey)
	}
	
	func addLine(command:SCNCommand! = nil)
	{
		commands.append(command)
		if commands.count > 6 { commands.removeAtIndex(0) }
		update()
	}
	
	override func update()
	{
		consoleLine1.port.disconnect()
		consoleLine2.port.disconnect()
		consoleLine3.port.disconnect()
		consoleLine4.port.disconnect()
		consoleLine5.port.disconnect()
		consoleLine6.port.disconnect()
		
		consoleLine1.update(commands[0])
		consoleLine2.update(commands[1])
		consoleLine3.update(commands[2])
		consoleLine4.update(commands[3])
		consoleLine5.update(commands[4])
		consoleLine6.update(commands[5])
		
		if port.origin == nil {
			label.update("console")
		}
	}
	
	func boot()
	{
		self.addLine(SCNCommand(text: "> ready", details: eventDetails.unknown, color: red))
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
	}
	
	func clearLines()
	{
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
		self.addLine(SCNCommand(text: "--", color: grey))
	}
	
	override func disconnect()
	{
		boot()
		update()
	}
	
	override func listen(event: Event)
	{
		if event.type == eventTypes.stack {
			self.clearLines()
			for item in event.content {
				self.addLine(SCNCommand(text: item.name!, details: item.details, color: white, event: item, head:item.isQuest))
			}
		}
		else {
			self.clearLines()
			port.origin.disconnect()
		}
	}
}