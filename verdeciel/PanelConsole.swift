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

class PanelConsole : SCNNode
{
	var consoleLine1:SCNCommand!
	var consoleLine2:SCNCommand!
	var consoleLine3:SCNCommand!
	var consoleLine4:SCNCommand!
	var consoleLine5:SCNCommand!
	var consoleLine6:SCNCommand!
	var consoleLine7:SCNCommand!
	var consoleLine8:SCNCommand!
	
	var commands:Array<SCNCommand> = [SCNCommand(),SCNCommand(),SCNCommand(),SCNCommand(),SCNCommand(),SCNCommand(),SCNCommand(),SCNCommand()]
	
	// Ports
	
	var inputLabel:SCNLabel!
	var input:SCNPort!
	
	override init()
	{
		super.init()
		name = "console"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale - 0.25, z: 0),nodeB: SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale - 0.25, z: 0),color:white))
		
		consoleLine1 = SCNCommand()
		consoleLine1.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 0.5, z: 0)
		self.addChildNode(consoleLine1)
		
		consoleLine2 = SCNCommand()
		consoleLine2.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 0.75, z: 0)
		self.addChildNode(consoleLine2)
		
		consoleLine3 = SCNCommand()
		consoleLine3.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 1, z: 0)
		self.addChildNode(consoleLine3)
		
		consoleLine4 = SCNCommand()
		consoleLine4.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 1.25, z: 0)
		self.addChildNode(consoleLine4)
		
		consoleLine5 = SCNCommand()
		consoleLine5.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 1.5, z: 0)
		self.addChildNode(consoleLine5)
		
		consoleLine6 = SCNCommand()
		consoleLine6.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 1.75, z: 0)
		self.addChildNode(consoleLine6)
		
		consoleLine7 = SCNCommand()
		consoleLine7.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 2, z: 0)
		self.addChildNode(consoleLine7)
		
		consoleLine8 = SCNCommand()
		consoleLine8.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 2.25, z: 0)
		self.addChildNode(consoleLine8)
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.1, y: highNode[7].y * scale, z: 0)
		
		inputLabel = SCNLabel(text: "console", scale: 0.1, align: alignment.left)
		inputLabel.position = SCNVector3(x: lowNode[7].x * scale + 0.3, y: highNode[7].y * scale, z: 0)
		inputLabel.updateWithColor("console", color: grey)
		
		self.addChildNode(input)
		self.addChildNode(inputLabel)
	}
	
	func touch(knobId:String)
	{
		
	}
	
	func addLine(command:SCNCommand! = nil)
	{
		commands.append(command)
		if commands.count > 8 { commands.removeAtIndex(0) }
		update()
	}
	
	override func update()
	{
		consoleLine1.update(commands[0])
		consoleLine2.update(commands[1])
		consoleLine3.update(commands[2])
		consoleLine4.update(commands[3])
		consoleLine5.update(commands[4])
		consoleLine6.update(commands[5])
		consoleLine7.update(commands[6])
		consoleLine8.update(commands[7])
	}
	
	override func listen(event: SCNEvent)
	{
		if event.type == eventTypes.stack {
			self.addLine(SCNCommand())
			self.addLine(SCNCommand(text:event.name!, color: grey, head:true))
			self.addLine(SCNCommand())
			for item in event.content {
				self.addLine(SCNCommand(text: item.name!, details: item.details, color: white, event: item))
			}
		}
		if event.type == eventTypes.location || event.type == eventTypes.item {
			self.addLine(SCNCommand())
			self.addLine(SCNCommand(text:event.name!, head:true,details:event.details,color:grey))
			self.addLine(SCNCommand(text:event.note,color:grey))
			self.input.origin.disconnect()
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}