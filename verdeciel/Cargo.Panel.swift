
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
	
	override func refresh()
	{
		print("+ PANEL    | Cargo: \(port.event.content.count) items")
		
		// Update cargohold
		let newCargohold = Event(name: "cargohold")
		for item in port.event.content {
			newCargohold.content.append(item)
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
		
		details.update("\(port.event.content.count)/6")
	}
	
	// MARK: I/O -
	
	override func listen(event:Event)
	{
		print("* CARGO    | Signal: \(event.name!)")
		if event is Item { upload(event) }
	}
	
	override func bang()
	{
		update()
		if port.connection == nil { return }
		port.connection.host.listen(port.event)
	}
	
	override func onUploadComplete()
	{
		refresh()
		bang()
	}
	
	// MARK: Upload -
	
	var upload:Event!
	var uploadTimer:NSTimer!
	var uploadPercentage:Float = 0
	
	func upload(item:Event)
	{
		upload = item
		uploadTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("uploadProgress"), userInfo: nil, repeats: true)
	}
	
	func uploadProgress()
	{
		if port.origin == nil { uploadCancel() ; return }
		
		uploadPercentage += Float(arc4random_uniform(60))/10
		if uploadPercentage > 100 {
			uploadComplete()
		}
		else{
			details.update("\(Int(uploadPercentage))%", color:grey)
		}
	}
	
	func uploadComplete()
	{
		if (port.origin != nil) {
			let origin = port.origin.host
			port.event.content.append(port.syphon())
			origin.onUploadComplete()
			self.onUploadComplete()
		}
		uploadTimer.invalidate()
		uploadPercentage = 0
		refresh()
	}
	
	func uploadCancel()
	{
		uploadTimer.invalidate()
		uploadPercentage = 0
		refresh()
	}
	
	// MARK: Installation -
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		player.lookAt(deg: -225)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}