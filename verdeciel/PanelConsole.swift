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
	
	var consoleNode:SCNNode!
	
	var refreshTimer:NSTimer!
	
	override func setup()
	{
		name = "console"
		
		// Decals
		
		decals.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
		consoleNode = SCNNode()
		
		consoleNode.position = SCNVector3(0,0,0)
		
		consoleLine1 = SCNCommand()
		consoleLine1.position = SCNVector3(x: templates.leftMargin, y: templates.lineSpacing * 2.5, z: 0)
		consoleNode.addChildNode(consoleLine1)
		
		consoleLine2 = SCNCommand()
		consoleLine2.position = SCNVector3(x: templates.leftMargin, y: templates.lineSpacing * 1.5, z: 0)
		consoleNode.addChildNode(consoleLine2)
		
		consoleLine3 = SCNCommand()
		consoleLine3.position = SCNVector3(x: templates.leftMargin, y: templates.lineSpacing * 0.5, z: 0)
		consoleNode.addChildNode(consoleLine3)
		
		consoleLine4 = SCNCommand()
		consoleLine4.position = SCNVector3(x: templates.leftMargin, y: -templates.lineSpacing * 0.5, z: 0)
		consoleNode.addChildNode(consoleLine4)
		
		consoleLine5 = SCNCommand()
		consoleLine5.position = SCNVector3(x: templates.leftMargin, y: -templates.lineSpacing * 1.5, z: 0)
		consoleNode.addChildNode(consoleLine5)
		
		consoleLine6 = SCNCommand()
		consoleLine6.position = SCNVector3(x: templates.leftMargin, y: -templates.lineSpacing * 2.5, z: 0)
		consoleNode.addChildNode(consoleLine6)
		
		interface.addChildNode(consoleNode)
		
		refreshTimer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("refresh"), userInfo: nil, repeats: true)
		
		port.input = eventTypes.generic
		port.output = eventTypes.unknown
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(-1,0,0)))
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.updateWithColor("--", color: grey)
		
		boot()
	}
	
	override func installedFixedUpdate()
	{
		/*
		for line in consoleNode.childNodes {
			let command = line as! SCNCommand
			if command.port != nil && command.port.event != nil && command.port.event.size == 0 {
				command.update(SCNCommand(text: "--", color: grey))
			}
		}
*/
	}
	
	func addLine(command:SCNCommand! = nil)
	{
		commands.append(command)
	}
	
	override func update()
	{
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
		clearLines()
		addLine(SCNCommand(text: "Run"))
		addLine(SCNCommand(text: " "))
		addLine(SCNCommand(text: "Awaiting input..", head:true))
	}
	
	func clearLines()
	{
		addLine(SCNCommand(text: "--", color: grey))
		addLine(SCNCommand(text: "--", color: grey))
		addLine(SCNCommand(text: "--", color: grey))
		addLine(SCNCommand(text: "--", color: grey))
		addLine(SCNCommand(text: "--", color: grey))
		addLine(SCNCommand(text: "--", color: grey))
		addLine(SCNCommand(text: "--", color: grey))
	}
	
	func refresh()
	{
		if commands.count > 6 { commands.removeAtIndex(0) }
		update()
	}
	
	override func listen(event: Event)
	{
		// Invalidate older lines
		for command in commands {
			command.event = nil
		}
		
		if port.origin.host == cargo {
			print("+ CONSOLE  | Connected")
			addLine(SCNCommand(text: port.origin.host.name!, color: grey, head:true))
			for item in event.content {
				self.addLine(SCNCommand(text: item.name!, details: item.details, color: white, event: item, head:item.isQuest))
			}
		}
	}
}