//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelCargo : MainPanel
{
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	var line5:SCNLine!
	var line6:SCNLine!
	
	var trigger:SCNTrigger!
	
	override init()
	{
		super.init()
		
		name = "cargo"
		mainNode.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		port.event = items.playerCargo

		// Quantity
		
		line1 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.5, z: 0),color:grey)
		line2 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.3, z: 0),color:grey)
		line3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.1, z: 0),color:grey)
		line4 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.1, z: 0),color:grey)
		line5 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.3, z: 0),color:grey)
		line6 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.5, z: 0),color:grey)
		
		mainNode.addChildNode(line1)
		mainNode.addChildNode(line2)
		mainNode.addChildNode(line3)
		mainNode.addChildNode(line4)
		mainNode.addChildNode(line5)
		mainNode.addChildNode(line6)
		
		// Trigger
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 2), operation: 1)
		mainNode.addChildNode(trigger)
		
		port.input = Item.self
		port.output = Item.self
	}
	
	override func start()
	{
		decalsNode.opacity = 0
		mainNode.opacity = 0
		label.update("--", color: grey)
		update()
	}
	
//	override func installedFixedUpdate()
//	{
//		if isUploading == true { uploadProcess() }
//		else{
//			details.update("\(port.event.content.count)/6")
//		}
//	}
	
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
	
	func removeEvent(target:Event)
	{
		let history = port.event.content
		port.event.content = []
		for event in history {
			if event == target { continue }
			port.event.content.append(event)
		}
	}
	
	override func touch(id:Int = 0)
	{
		bang()
	}
	
	override func update()
	{
		print("+ PANEL    | Cargo: \(port.event.content.count) items")
		
		// Update cargohold
//		let newCargohold = Event(name: "cargohold", type: eventTypes.cargo)
//		for item in port.event.content {
//			newCargohold.content.append(item)
//		}
//		port.event = newCargohold
		
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
	
	// MARK: I/O -
	
	override func listen(event:Event)
	{
		print("* CARGO    | Signal: \(event.name!)")
		if event is Item { uploadItem(event) }
	}
	
	override func bang()
	{
		update()
		if port.connection == nil { return }
		port.connection.host.listen(port.event)
	}
	
	// MARK: Upload -
	
	var isUploading:Bool = false
	var uploadProgress:CGFloat = 0
	
	func uploadItem(item:Event)
	{
		isUploading = true
	}
	
	func uploadProcess()
	{
		if port.origin == nil { details.update("error", color: grey) ; uploadProgress = 0 ; return }
		uploadProgress += CGFloat(arc4random_uniform(100))/50
		details.update("Upload \(Int(uploadProgress))%", color: grey)
		if uploadProgress >= 100 {
			uploadCompleted()
		}
	}
	
	func uploadCompleted()
	{
		let event = port.syphon()
		port.event.content.append(event)
		
		uploadProgress = 0
		isUploading = false
		bang()
	}
	
	// MARK: Installation -
	
	override func onInstallationBegin()
	{
		ui.addWarning("Installing", duration: 3)
		player.lookAt(deg: -225)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}