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

class PanelQuest : Panel
{
	var content:SCNNode!

	var linesRoot:SCNNode!
	
	var quest1:SCNLabel!
	var quest1Port:SCNPort!
	var quest2:SCNLabel!
	var quest2Port:SCNPort!
	var quest3:SCNLabel!
	var quest3Port:SCNPort!
	var quest4:SCNLabel!
	var quest4Port:SCNPort!
	var quest5:SCNLabel!
	var quest5Port:SCNPort!
	var quest6:SCNLabel!
	var quest6Port:SCNPort!
	
	// Ports
	
	var panelHead:SCNNode!
	var inputLabel:SCNLabel!
	var input:SCNPort!
	
	override func setup()
	{
		name = "log"
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		panelHead = SCNNode()
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		inputLabel = SCNLabel(text: name!, scale: 0.1, align: alignment.center)
		inputLabel.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		panelHead.addChildNode(input)
		panelHead.addChildNode(inputLabel)
		addChildNode(panelHead)
		panelHead.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		content = SCNNode()
		interface.addChildNode(content)
		
		let spacing:Float = -0.35
		
		linesRoot = SCNNode()
		linesRoot.position = SCNVector3(0,templates.topMargin + spacing - 0.2,0)
		
		quest1 = SCNLabel()
		quest1.position = SCNVector3(x: templates.leftMargin, y: (spacing * 0), z: 0)
		linesRoot.addChildNode(quest1)
		
		quest1Port = SCNPort(host: self, polarity: true)
		quest1Port.addEvent((quests.loiqe.first?.event)!)
		quest1Port.position = SCNVector3(x: templates.rightMargin - 0.15, y: (spacing * 0), z: 0)
		linesRoot.addChildNode(quest1Port)
		
		quest2 = SCNLabel()
		quest2.position = SCNVector3(x: templates.leftMargin, y: (spacing * 1), z: 0)
		linesRoot.addChildNode(quest2)
		
		quest2Port = SCNPort(host: self, polarity: true)
		quest2Port.addEvent((quests.falvet.first?.event)!)
		quest2Port.position = SCNVector3(x: templates.rightMargin - 0.15, y: (spacing * 1), z: 0)
		linesRoot.addChildNode(quest2Port)
		
		quest3 = SCNLabel()
		quest3.position = SCNVector3(x: templates.leftMargin, y: (spacing * 2), z: 0)
		linesRoot.addChildNode(quest3)
		
		quest4 = SCNLabel()
		quest4.position = SCNVector3(x: templates.leftMargin, y: (spacing * 3), z: 0)
		linesRoot.addChildNode(quest4)
		
		quest5 = SCNLabel()
		quest5.position = SCNVector3(x: templates.leftMargin, y: (spacing * 4), z: 0)
		linesRoot.addChildNode(quest5)
		
		quest6 = SCNLabel()
		quest6.position = SCNVector3(x: templates.leftMargin, y: (spacing * 5), z: 0)
		linesRoot.addChildNode(quest6)
		
		interface.addChildNode(linesRoot)
		
		update()
		
	}
	
	func addQuest(newQuest:Quest)
	{
		update()
	}
	
	override func bang()
	{
		if quest1Port.connection != nil {
			quest1Port.connection.host.listen((quests.loiqe.first?.event)!)
		}
	}
	
	override func update()
	{
		quest1.update((quests.loiqe.first?.name)!)
		quest2.updateWithColor(((quests.falvet.first?.name)!), color: grey)
		quest3.update("--")
		quest4.update("--")
		quest5.update("--")
		quest6.update("--")
	}
	
	func dock(location:Location)
	{
		content.addChildNode(location.interface)
		linesRoot.opacity = 1
	}
	
	func undock()
	{
		content.empty()
		linesRoot.opacity = 1
	}
	
	override func listen(event:Event)
	{
		
	}
}