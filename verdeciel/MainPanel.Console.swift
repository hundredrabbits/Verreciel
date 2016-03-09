
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelConsole : MainPanel
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
	var radioPort:SCNPortSlot!
	
	override init()
	{
		super.init()
		
		name = "console"
		info = "[missing text]"
	
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
		
		mainNode.addChildNode(consoleNode)
		
		refreshTimer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("refresh"), userInfo: nil, repeats: true)
		
		port.input = Event.self
		port.output = Event.self
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(-1,0,0),host:self))
	}

	func addLine(command:SCNCommand! = nil)
	{
		commands.append(command)
	}
	
	override func refresh()
	{
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
		addLine(SCNCommand(text: "Awaiting input",color:grey))
		addLine(SCNCommand(text: "--",color:grey))
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
			addLine(SCNCommand(text: "\(port.origin.host.name!)", color: grey, head:true))
			for item in event.content {
				self.addLine(SCNCommand(text: item.name!, details: "\(item.type)", color: white, event: item, head:false))
			}
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
	
	override func onConnect()
	{
		super.onConnect()
		
		if port.origin.event != nil {
			addLine(SCNCommand(text: port.origin.event.name!, color: grey, details: "", head:true))
			addLine(SCNCommand(text: "\(port.origin.event.note)", color: white))
		}
		else if port.origin.host is Panel {
			let origin = port.origin.host as! Panel
			addLine(SCNCommand(text: origin.name!, color: grey, details: "", head:true))
			addLine(SCNCommand(text: "\(origin.info)", color: white))
		}
	}
	
	override func onDisconnect()
	{
		addLine(SCNCommand(text: "Disconnected", color: grey, head:true))
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		if debug.isActive == false { player.lookAt(deg: -270) }
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		
		boot()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}