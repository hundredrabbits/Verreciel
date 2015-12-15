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
		
		consoleLine1 = SCNCommand(host:self)
		consoleLine1.position = SCNVector3(x: templates.leftMargin, y: templates.lineSpacing * 2.5, z: 0)
		consoleNode.addChildNode(consoleLine1)
		
		consoleLine2 = SCNCommand(host:self)
		consoleLine2.position = SCNVector3(x: templates.leftMargin, y: templates.lineSpacing * 1.5, z: 0)
		consoleNode.addChildNode(consoleLine2)
		
		consoleLine3 = SCNCommand(host:self)
		consoleLine3.position = SCNVector3(x: templates.leftMargin, y: templates.lineSpacing * 0.5, z: 0)
		consoleNode.addChildNode(consoleLine3)
		
		consoleLine4 = SCNCommand(host:self)
		consoleLine4.position = SCNVector3(x: templates.leftMargin, y: -templates.lineSpacing * 0.5, z: 0)
		consoleNode.addChildNode(consoleLine4)
		
		consoleLine5 = SCNCommand(host:self)
		consoleLine5.position = SCNVector3(x: templates.leftMargin, y: -templates.lineSpacing * 1.5, z: 0)
		consoleNode.addChildNode(consoleLine5)
		
		consoleLine6 = SCNCommand(host:self)
		consoleLine6.position = SCNVector3(x: templates.leftMargin, y: -templates.lineSpacing * 2.5, z: 0)
		consoleNode.addChildNode(consoleLine6)
		
		interface.addChildNode(consoleNode)
		
		refreshTimer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("refresh"), userInfo: nil, repeats: true)
		
		port.input = eventTypes.generic
		port.output = eventTypes.unknown
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(-1,0,0),host:self))
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.update("--", color: grey)
	}

	func addLine(command:SCNCommand! = nil)
	{
		commands.append(command)
	}
	
	func refresh()
	{
		if isInstalled == false { return }
		if commands.count > 6 { commands.removeAtIndex(0) ; update() }
	}
	
	override func update()
	{
		if port.origin != nil {
			port.origin.host.update()
		}
		
		consoleLine1.inject(commands[0])
		consoleLine2.inject(commands[1])
		consoleLine3.inject(commands[2])
		consoleLine4.inject(commands[3])
		consoleLine5.inject(commands[4])
		consoleLine6.inject(commands[5])
		
		if port.origin == nil {
			label.update("console")
		}
	}
	
	func boot()
	{
		clearLines()
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
	
	override func listen(event: Event)
	{
		for command in commands {
			command.port.event = nil
		}
		
		if port.origin.host == cargo {
			addLine(SCNCommand(text: port.origin.host.name!, color: grey, head:true))
			for item in event.content {
				self.addLine(SCNCommand(text: item.name!, details: item.details, color: white, event: item, head:item.isQuest))
			}
		}
		else if port.origin.event != nil {
			addLine(SCNCommand(text: port.origin.event.name!, color: grey, details: port.origin.event.details, head:true))
			self.addLine(SCNCommand(text: "\(port.origin.event.note)", color: white))
		}
	}
	
	override func bang()
	{
		if consoleLine1.port.connection != nil { consoleLine1.port.connection.host.listen(consoleLine1.port.event) }
		if consoleLine2.port.connection != nil { consoleLine2.port.connection.host.listen(consoleLine2.port.event) }
		if consoleLine3.port.connection != nil { consoleLine3.port.connection.host.listen(consoleLine3.port.event) }
		if consoleLine4.port.connection != nil { consoleLine4.port.connection.host.listen(consoleLine4.port.event) }
		if consoleLine5.port.connection != nil { consoleLine5.port.connection.host.listen(consoleLine5.port.event) }
		if consoleLine6.port.connection != nil { consoleLine6.port.connection.host.listen(consoleLine6.port.event) }
	}
	
	override func onInstallationBegin()
	{
		ui.addWarning("Installing", duration: 3)
		player.lookAt(deg: -270)
	}
	
	override func onInstallationComplete()
	{
		boot()
	}
}