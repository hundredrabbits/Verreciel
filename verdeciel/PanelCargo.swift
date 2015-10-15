//
//  File.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelCargo : Panel
{
	var attractorLabel = SCNLabel(text: "")
	
	var loadTime:Int = 0
	
	var cargohold = Event(newName: "cargohold", type: eventTypes.stack)
	
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	var line5:SCNLine!
	var line6:SCNLine!
	
	// Ports
	
	var panelHead:SCNNode!
	var label:SCNLabel!
	var input:SCNPort!
	var output:SCNPort!
	
	override func setup()
	{
		name = "cargo"
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		panelHead = SCNNode()
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: -0.75, y: 0, z: templates.radius)
		output = SCNPort(host: self,polarity: true)
		output.position = SCNVector3(x: 0.75, y: 0, z: templates.radius)
		label = SCNLabel(text: "cargo", scale: 0.1, align: alignment.center)
		label.position = SCNVector3(x: 0.05, y: 0, z: templates.radius)
		panelHead.addChildNode(input)
		panelHead.addChildNode(output)
		panelHead.addChildNode(label)
		addChildNode(panelHead)
		panelHead.eulerAngles.x += Float(degToRad(templates.titlesAngle))

		// Tutorial Item
		
		addEvent(items.loiqeLicense)
		addEvent(items.mediumBattery)
		
		attractorLabel = SCNLabel(text: "", scale: 0.1, align: alignment.center)
		attractorLabel.position = SCNVector3(x: 0, y: templates.topMargin, z: 0)
		interface.addChildNode(attractorLabel)
		
		// Quantity
		
		line1 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.5, z: 0),color:white)
		line2 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.3, z: 0),color:white)
		line3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.1, z: 0),color:white)
		line4 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.1, z: 0),color:grey)
		line5 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.3, z: 0),color:grey)
		line6 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.5, z: 0),color:grey)
		
		interface.addChildNode(line1)
		interface.addChildNode(line2)
		interface.addChildNode(line3)
		interface.addChildNode(line4)
		interface.addChildNode(line5)
		interface.addChildNode(line6)
		
		// Trigger
		
		interface.addChildNode(SCNTrigger(host: self, size: CGSize(width: 2, height: 2), operation: true))
	}
	
	func addEvent(event:Event)
	{
		cargohold.content.append(event)
	}
	
	func addEvents(events:Array<Event>)
	{
		for event in events {
			cargohold.content.append(event)
		}
	}
	
	override func update()
	{
		let newCargohold = Event(newName: "cargohold", type: eventTypes.stack)
		for item in cargohold.content {
			if item.size > 0 {
				newCargohold.content.append(item)
			}
		}
		cargohold = newCargohold
		
		line1.color(grey)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
		line5.color(grey)
		line6.color(grey)
		
		if cargohold.content.count > 0 { line1.color(white) }
		if cargohold.content.count > 1 { line2.color(white) }
		if cargohold.content.count > 2 { line3.color(white) }
		if cargohold.content.count > 3 { line4.color(white) }
		if cargohold.content.count > 4 { line5.color(white) }
		if cargohold.content.count > 5 { line6.color(white) }
	}
	
	override func touch()
	{
		self.bang()
	}
	
	override func listen(event:Event)
	{
		if event.type == eventTypes.item {
			pickup(event)
		}
		else{
			attractorLabel.updateWithColor("error", color: red)
		}
	}

	func pickup(event:Event)
	{
		if event.type == eventTypes.cargo {
			self.addEvents(event.content)
		}
		else{
			self.addEvent(event)
		}
		
		update()
		bang()
	}
	
	override func bang(param:Bool = true)
	{
		self.update()
		if output.connection != nil {
			output.connection.host.listen(cargohold)
		}
	}
}