//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelCargo : Panel
{
	var uploadItem:Event!
	var uploadProgress:CGFloat = 0
	
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	var line5:SCNLine!
	var line6:SCNLine!
	
	var panelHead:SCNNode!
	
	var panelFoot:SCNNode!
	
	var trigger:SCNTrigger!
	
	override func setup()
	{
		name = "cargo"
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		panelHead = SCNNode()
		port = SCNPort(host: self)
		port.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		port.event = Event(newName: "cargohold", type: eventTypes.stack)
		label = SCNLabel(text: "cargo", scale: 0.1, align: alignment.center)
		label.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		panelHead.addChildNode(port)
		panelHead.addChildNode(label)
		addChildNode(panelHead)
		panelHead.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		panelFoot = SCNNode()
		details = SCNLabel(text: "0", scale: 0.1, align: alignment.center)
		details.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		panelFoot.addChildNode(details)
		addChildNode(panelFoot)
		panelFoot.eulerAngles.x += Float(degToRad(-templates.titlesAngle))

		// Tutorial Item
		
		port.event.content.append(items.smallBattery)

		// Quantity
		
		line1 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.5, z: 0),color:grey)
		line2 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.3, z: 0),color:grey)
		line3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.1, z: 0),color:grey)
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
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 2), operation: 1)
		interface.addChildNode(trigger)
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.updateWithColor("--", color: grey)
		update()
	}
	
	override func installedFixedUpdate()
	{
		if uploadItem != nil {
			uploadProgress += CGFloat(arc4random_uniform(100))/50
			details.updateWithColor("Upload \(Int(uploadProgress))%", color: grey)
			if uploadProgress >= 100 {
				uploadCompleted()
			}
		}
	}
	
	func contains(event:Event) -> Bool
	{
		for newEvent in port.event.content {
			if newEvent == event { return true }
		}
		return false
	}
	
	func addEvents(events:Array<Event>)
	{
		for event in events {
			port.event.content.append(event)
		}
	}
	
	override func touch(id:Int = 0)
	{
		bang()
	}
	
	override func listen(event:Event)
	{
		print("* CARGO    | Signal: \(event.name!)")
		
		if event.type != eventTypes.item { print("Not item") ; return }
		uploadItem(event)
	}

	func uploadItem(item:Event)
	{
		uploadItem = item
	}
	
	func uploadCompleted()
	{
		let newItem = uploadItem
		port.event.content.append(newItem)
		uploadItem = nil
		
		port.origin.event = nil
		port.origin.host.bang()
		
		details.update("")
		update()
		bang()
	}
	
	override func update()
	{
		// Update cargohold
		let newCargohold = Event(newName: "cargohold", type: eventTypes.stack)
		for item in port.event.content {
			if item.size > 0 {
				newCargohold.content.append(item)
			}
		}
		port.event = newCargohold
		
		line1.color(grey)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
		line5.color(grey)
		line6.color(grey)
		
		if port.event.content.count > 0 { line1.color( port.event.content[0].isQuest == true ? cyan : white ) }
		if port.event.content.count > 1 { line2.color( port.event.content[1].isQuest == true ? cyan : white ) }
		if port.event.content.count > 2 { line3.color( port.event.content[2].isQuest == true ? cyan : white ) }
		if port.event.content.count > 3 { line4.color( port.event.content[3].isQuest == true ? cyan : white ) }
		if port.event.content.count > 4 { line5.color( port.event.content[4].isQuest == true ? cyan : white ) }
		if port.event.content.count > 5 { line6.color( port.event.content[5].isQuest == true ? cyan : white ) }
	}
	
	override func bang()
	{
		update()
		if port.connection == nil { return }
		port.connection.host.listen(port.event)
	}
}