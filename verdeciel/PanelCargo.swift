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

class PanelCargo : SCNNode
{
	var nameLabel = SCNNode()
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

	var input:SCNPort!
	var output:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "cargo"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z - 0.2)
		
		// Tutorial Item
		
		self.addEvent(itemLibrary.loiqeLicense)
		
		
	
		/*
		// Goes in Hatch
		
//		let disk = Event(newName: "disk", size: 1, type: eventTypes.item, details: "code",note:"crack something")
//		self.addEvent(disk)
		
		// Goes in Battery
		let battery = Event(newName: "small battery", size: 25, type: eventTypes.battery, details: "cell",note:"crack something")
		self.addEvent(battery)
		
		// Goes in Radar
		let starMap = Event(newName: "helio's path", location: CGPoint(x: 4, y: 4), size: 1, type: eventTypes.map, details: "map",note:"go somewhere")
		starMap.content.append(Event(newName: "star1", location: CGPoint(x: -3,y: 2), size: 1, type: eventTypes.location))
		starMap.content.append(Event(newName: "star2", location: CGPoint(x: -1,y: 0.7), size: 1, type: eventTypes.location))
		starMap.content.append(Event(newName: "star3", location: CGPoint(x: 0.6,y: -0.3), size: 1, type: eventTypes.location))
		self.addEvent(starMap)
		
		// For pilot
		let coordinate = Event(newName: "helio system", location: CGPoint(x: -3, y: -4), size: 1, type: eventTypes.location, details: "pilot",note:"go somewhere")
		self.addEvent(coordinate)
		
		// For thruster
		let warpGate = Event(newName: "warpgate", location: CGPoint(x: 0, y: 1), size: 1, type: eventTypes.warp, details: "warp",note:"warp to world 1")
		self.addEvent(warpGate)

*/
		
		update()
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		nameLabel = SCNLabel(text: self.name!, scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(nameLabel)
		
		attractorLabel = SCNLabel(text: "", scale: 0.1, align: alignment.center)
		attractorLabel.position = SCNVector3(x: 0, y: lowNode[7].y * scale, z: 0)
		self.addChildNode(attractorLabel)
		
		// Quantity
		
		line1 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.5, z: 0),color:white)
		line2 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.3, z: 0),color:white)
		line3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.1, z: 0),color:white)
		line4 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.1, z: 0),color:grey)
		line5 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.3, z: 0),color:grey)
		line6 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.5, z: 0),color:grey)
			
		self.addChildNode(line1)
		self.addChildNode(line2)
		self.addChildNode(line3)
		self.addChildNode(line4)
		self.addChildNode(line5)
		self.addChildNode(line6)
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.7, y: highNode[7].y * scale, z: 0)
		output = SCNPort(host: self,polarity: true)
		output.position = SCNVector3(x: lowNode[0].x * scale - 0.7, y: highNode[7].y * scale, z: 0)
		
		self.addChildNode(input)
		self.addChildNode(output)
		
		// Trigger
		
		self.addChildNode(SCNTrigger(host: self, size: 2, operation: true))
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
		if event.type == eventTypes.cargo {
			pickup(event)
		}
		else{
			attractorLabel.updateWithColor("error", color: red)
		}
	}

	func pickup(event:Event)
	{
		if event.distance > 0.5 {
			attractorLabel.updateWithColor("waiting", color: red)
			return
		}
		
		if loadTime < 100 {
			loadTime += Int(arc4random_uniform(4))
			if loadTime > 100 { loadTime = 100}
			attractorLabel.updateWithColor("\(loadTime)%", color: cyan)
		}
		else{
			attractorLabel.updateWithColor("", color: cyan)
			loadTime = 0
			input.origin.disconnect()
			
			if event.type == eventTypes.cargo {
				self.addEvents(event.content)
			}
			else{
				self.addEvent(event)
			}
			
			event.removeFromParentNode()
			radar.removeTarget()
			
			update()
			bang()
		}
	}
	
	override func bang(param:Bool = true)
	{
		self.update()
		if output.connection != nil {
			output.connection.host.listen(cargohold)
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}