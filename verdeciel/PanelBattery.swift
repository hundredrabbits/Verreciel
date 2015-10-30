//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelBattery : Panel
{
	var oxygenPort:SCNPort!
	var shieldPort:SCNPort!
	var cloakPort:SCNPort!
	var thrusterPort:SCNPort!
	var radioLabel:SCNLabel!
	var radioPort:SCNPort!
	
	var cell1Label:SCNLabel!
	var cell1:SCNPort!
	var cell2Label:SCNLabel!
	var cell2:SCNPort!
	var cell3Label:SCNLabel!
	var cell3:SCNPort!
	
	override func setup()
	{
		name = "battery"
		
		// Decals
		
		decals.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
		// Cells
		
		let distance:Float = 0.4
		
		cell1 = SCNPort(host: self)
		cell1.position = SCNVector3(x: -distance, y: templates.lineSpacing, z: 0)
		cell1.addEvent(items.cell)
		cell1Label = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cell1Label.position = SCNVector3(x: -0.2, y:0, z: 0)
		cell1.addChildNode(cell1Label)
		interface.addChildNode(cell1)
		
		cell2 = SCNPort(host: self)
		cell2.position = SCNVector3(x: -distance, y: 0, z: 0)
		cell2Label = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cell2Label.position = SCNVector3(x: -0.2, y: 0, z: 0)
		cell2.addChildNode(cell2Label)
		interface.addChildNode(cell2)
		
		cell3 = SCNPort(host: self)
		cell3.position = SCNVector3(x: -distance, y: -templates.lineSpacing, z: 0)
		cell3Label = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cell3Label.position = SCNVector3(x: -0.2, y: 0, z: 0)
		cell3.addChildNode(cell3Label)
		interface.addChildNode(cell3)
		
		// Systems
		
		thrusterPort = SCNPort(host: self, input:eventTypes.item)
		thrusterPort.position = SCNVector3(x: distance, y: templates.lineSpacing, z: 0)
		let thrusterLabel = SCNLabel(text: "thruster", scale: 0.1, align: alignment.left)
		thrusterLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		thrusterPort.addChildNode(thrusterLabel)
		interface.addChildNode(thrusterPort)
		
		radioPort = SCNPort(host: self, input:eventTypes.battery)
		radioPort.position = SCNVector3(x: distance, y: 0, z: 0)
		radioLabel = SCNLabel(text: "radio", scale: 0.1, align: alignment.left)
		radioLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		radioPort.addChildNode(radioLabel)
		interface.addChildNode(radioPort)
		
		oxygenPort = SCNPort(host: self, input:eventTypes.battery)
		oxygenPort.position = SCNVector3(x: distance, y: 2 * -templates.lineSpacing, z: 0)
		let oxygenLabel = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		oxygenLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		oxygenPort.addChildNode(oxygenLabel)
		interface.addChildNode(oxygenPort)
		
		shieldPort = SCNPort(host: self, input:eventTypes.battery)
		shieldPort.position = SCNVector3(x: distance, y: 2 * templates.lineSpacing, z: 0)
		let shieldLabel = SCNLabel(text: "shield", scale: 0.1, align: alignment.left)
		shieldLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		shieldPort.addChildNode(shieldLabel)
		interface.addChildNode(shieldPort)
		
		cloakPort = SCNPort(host: self, input:eventTypes.battery)
		cloakPort.position = SCNVector3(x: distance, y: -templates.lineSpacing, z: 0)
		let cloakLabel = SCNLabel(text: "cloak", scale: 0.1, align: alignment.left)
		cloakLabel.position = SCNVector3(x: 0.2, y: 0, z: 0)
		cloakPort.addChildNode(cloakLabel)
		interface.addChildNode(cloakPort)
		
		cloakLabel.update("--", color: grey)
		shieldLabel.update("--", color: grey)
		radioLabel.update("--", color: grey)
		oxygenLabel.update("--", color: grey)
		
		port.input = eventTypes.item
		port.output = eventTypes.unknown
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(0,0,-1)))
	}
	
	override func start()
	{
		thrusterPort.enable()
		cell1.addEvent(items.cell)
	}
	
	override func update()
	{
		if cell1.event != nil {
			cell1Label.update(cell1.event.name!, color: white)
			cell1.enable()
		}
		else{
			cell1Label.update("--", color: grey)
			cell1.disable()
		}
		
		if cell2.event != nil {
			cell2Label.update(cell2.event.name!, color: white)
			cell2.enable()
		}
		else{
			cell2Label.update("--", color: grey)
			cell2.disable()
		}
		
		if cell3.event != nil {
			cell3Label.update(cell3.event.name!, color: white)
			cell3.enable()
		}
		else{
			cell3Label.update("--", color: grey)
			cell3.disable()
		}
	}
	
	override func installedFixedUpdate()
	{
		if isUploading == true {
			uploadProcess()
		}
		else if isInstalled == true {
			update()
		}
	}
	
	// MARK: I/O
	
	override func listen(event:Event)
	{
		if event.details != itemTypes.battery { return }
		
		if port.origin != nil && port.origin.event != nil && isUploading == false {
			uploadItem(event)
		}
	}
	
	override func bang()
	{
		if cell1.event != nil && cell1.connection != nil { cell1.connection.host.listen(cell1.event) }
		if cell2.event != nil && cell2.connection != nil { cell2.connection.host.listen(cell2.event) }
		if cell3.event != nil && cell3.connection != nil { cell3.connection.host.listen(cell3.event) }
	}
	
	// MARK: Uploading -
	
	var isUploading:Bool = false
	var uploadProgress:CGFloat = 0
	
	func uploadItem(item:Event)
	{
		isUploading = true
	}
	
	func uploadProcess()
	{
		uploadProgress += CGFloat(arc4random_uniform(100))/50
		
		if cell1.event == nil { cell1Label.update("\(Int(uploadProgress))%", color: grey) }
		else if cell2.event == nil { cell2Label.update("\(Int(uploadProgress))%", color: grey) }
		else if cell3.event == nil { cell3Label.update("\(Int(uploadProgress))%", color: grey) }
		
		if uploadProgress >= 100 {
			uploadCompleted()
		}
	}
	
	func uploadCompleted()
	{
		if cell1.event == nil { cell1.addEvent(port.syphon()) }
		else if cell2.event == nil { cell2.addEvent(port.syphon()) }
		else if cell3.event == nil { cell3.addEvent(port.syphon()) }
		else{ print("No available slots") }
		
		uploadProgress = 0
		isUploading = false
		cargo.bang()
	}
	
	// MARK: Flags -
	
	func isRadioPowered() -> Bool
	{
		if radioPort.origin != nil && radioPort.origin.event != nil && radioPort.origin.event.details == itemTypes.battery { return true }
		return false
	}
	
	func isThrusterPowered() -> Bool
	{
		if thrusterPort.origin != nil && thrusterPort.origin.event != nil && thrusterPort.origin.event.details == itemTypes.battery { return true }
		return false
	}
}