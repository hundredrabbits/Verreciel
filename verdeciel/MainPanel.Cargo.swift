
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
	
	var cargohold = CargoHold()
	
	override init()
	{
		super.init()
		
		name = "cargo"
		details = "stores items"
		port.event = cargohold
		
		mainNode.position = SCNVector3(x: 0, y: 0, z: templates.radius)

		// Quantity
		
		line1 = SCNLine(vertices: [SCNVector3(x: -0.5, y: -0.5, z: 0),  SCNVector3(x: 0.5, y: -0.5, z: 0)],color:grey)
		line2 = SCNLine(vertices: [SCNVector3(x: -0.5, y: -0.3, z: 0),  SCNVector3(x: 0.5, y: -0.3, z: 0)],color:grey)
		line3 = SCNLine(vertices: [SCNVector3(x: -0.5, y: -0.1, z: 0),  SCNVector3(x: 0.5, y: -0.1, z: 0)],color:grey)
		line4 = SCNLine(vertices: [SCNVector3(x: -0.5, y: 0.1, z: 0),  SCNVector3(x: 0.5, y: 0.1, z: 0)],color:grey)
		line5 = SCNLine(vertices: [SCNVector3(x: -0.5, y: 0.3, z: 0),  SCNVector3(x: 0.5, y: 0.3, z: 0)],color:grey)
		line6 = SCNLine(vertices: [SCNVector3(x: -0.5, y: 0.5, z: 0),  SCNVector3(x: 0.5, y: 0.5, z: 0)],color:grey)
		
		mainNode.addChildNode(line1)
		mainNode.addChildNode(line2)
		mainNode.addChildNode(line3)
		mainNode.addChildNode(line4)
		mainNode.addChildNode(line5)
		mainNode.addChildNode(line6)
		
		// Trigger
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 2), operation: 1)
		mainNode.addChildNode(trigger)
		
		decals.empty()
		
		detailsLabel.update("Empty", color: grey)
	}
	
	func contains(event:Event) -> Bool
	{
		for item in cargohold.content {
			if item == event { return true }
		}
		return false
	}
	
	func containsLike(target:Item) -> Bool
	{
		for item in cargohold.content {
			if item.name == target.name && item.type == target.type { return true }
		}
		return false
	}
	
	func containsCount(count:Int,target:Item) -> Bool
	{
		var count_actual = 0
		for item in cargohold.content {
			if item.name == target.name && item.type == target.type { count_actual += 1 }
		}
		if count == count_actual { return true }
		return false
	}
	
	// MARK: Add - 
	
	func addItems(items:Array<Item>)
	{
		for item in items {
			addItem(item)
		}
		refresh()
	}
	
	func addItem(item:Item)
	{
		self.cargohold.content.append(item)
		self.refresh()
	}

	func removeItem(target:Item)
	{
		if cargohold.content.count == 1 { line1.position.x = 0.25 }
		if cargohold.content.count == 2 { line2.position.x = 0.25 }
		if cargohold.content.count == 3 { line3.position.x = 0.25 }
		if cargohold.content.count == 4 { line4.position.x = 0.25 }
		if cargohold.content.count == 5 { line5.position.x = 0.25 }
		if cargohold.content.count == 6 { line6.position.x = 0.25 }
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		if cargohold.content.count == 1 { line1.position.x = 0 }
		if cargohold.content.count == 2 { line2.position.x = 0 }
		if cargohold.content.count == 3 { line3.position.x = 0 }
		if cargohold.content.count == 4 { line4.position.x = 0 }
		if cargohold.content.count == 5 { line5.position.x = 0 }
		if cargohold.content.count == 6 { line6.position.x = 0 }
		
		SCNTransaction.setCompletionBlock({ self.removeTransfer(target) })
		SCNTransaction.commit()
	}
	
	func removeTransfer(target:Item)
	{
		let history = cargohold.content
		cargohold.content = []
		for event in history {
			if event == target { continue }
			cargohold.content.append(event)
		}
		
		refresh()
	}
	
	override func touch(id:Int = 0)
	{
		refresh()
		
		if port.isConnectedToPanel(console) == true { console.onConnect() }
		
		audio.playSound("click4")
	}
	
	override func refresh()
	{
		let newCargohold = CargoHold()
		for item in cargohold.content {
			newCargohold.content.append(item)
		}
		port.event = newCargohold
		
		// Animate
		
		line1.color(grey)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
		line5.color(grey)
		line6.color(grey)
		
		if cargohold.content.count > 0 { line1.color( cargohold.content[0].isQuest == true ? cyan : white ) }
		if cargohold.content.count > 1 { line2.color( cargohold.content[1].isQuest == true ? cyan : white ) }
		if cargohold.content.count > 2 { line3.color( cargohold.content[2].isQuest == true ? cyan : white ) }
		if cargohold.content.count > 3 { line4.color( cargohold.content[3].isQuest == true ? cyan : white ) }
		if cargohold.content.count > 4 { line5.color( cargohold.content[4].isQuest == true ? cyan : white ) }
		if cargohold.content.count > 5 { line6.color( cargohold.content[5].isQuest == true ? cyan : white ) }
		
		if cargohold.content.count == 0 {
			detailsLabel.update("Empty", color: grey)
		}
		else if cargohold.content.count == 6 {
			detailsLabel.update("FULL", color: red)
		}
		else{
			detailsLabel.update("\(cargohold.content.count)/6", color:white)
		}
	}
	
	override func onUploadComplete()
	{
		refresh()
		
		if port.isConnectedToPanel(console) == true { console.onConnect() }
		
		audio.playSound("click3")
	}
	
	override func onConnect()
	{
		if port.isReceivingEventOfTypeItem() == false { print("ERROR") ; return }
		
		upload(port.event)
	}
	
	// MARK: Upload -
	
	var upload:Event!
	var uploadTimer:NSTimer!
	var uploadPercentage:Float = 0
	
	func upload(item:Event)
	{
		upload = item
		uploadTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(self.uploadProgress), userInfo: nil, repeats: true)
	}
	
	func uploadProgress()
	{
		if port.origin == nil { uploadCancel() ; return }
		
		uploadPercentage += Float(arc4random_uniform(60))/10
		if uploadPercentage > 100 {
			uploadComplete()
		}
		else{
			detailsLabel.update("\(Int(uploadPercentage))%", color:grey)
		}
	}
	
	func uploadComplete()
	{
		if cargohold.content.count == 0 { line1.position.x = -0.25 }
		if cargohold.content.count == 1 { line2.position.x = -0.25 }
		if cargohold.content.count == 2 { line3.position.x = -0.25 }
		if cargohold.content.count == 3 { line4.position.x = -0.25 }
		if cargohold.content.count == 4 { line5.position.x = -0.25 }
		if cargohold.content.count == 5 { line6.position.x = -0.25 }
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		if cargohold.content.count == 0 { line1.position.x = 0 }
		if cargohold.content.count == 1 { line2.position.x = 0 }
		if cargohold.content.count == 2 { line3.position.x = 0 }
		if cargohold.content.count == 3 { line4.position.x = 0 }
		if cargohold.content.count == 4 { line5.position.x = 0 }
		if cargohold.content.count == 5 { line6.position.x = 0 }
		
		SCNTransaction.setCompletionBlock({ self.uploadTransfer() })
		SCNTransaction.commit()
	}
	
	func uploadTransfer()
	{
		if (self.port.origin != nil) {
			let origin = self.port.origin.host
			self.cargohold.content.append(self.port.syphon())
			origin.onUploadComplete()
			self.onUploadComplete()
		}
		self.uploadTimer.invalidate()
		self.uploadPercentage = 0
		self.refresh()
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

class CargoHold : Item
{
	var content:Array<Item> = []
	
	init()
	{
		super.init(code:"cargo")
		
		name = "cargo"
		type = .cargo
		details = "[missing]"
	}
	
	override func payload() -> ConsolePayload
	{
		var data:Array<ConsoleData> = []
		
		for item in content {
			data.append(ConsoleData(text: item.name!, details: "\(item.type)", event: item))
		}
		
		var i = 0
		while i < 6 - content.count {
			data.append(ConsoleData(text: "--", color:grey))
			i += 1
		}
		
		return ConsolePayload(data: data)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}