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
	
	var cellLabel1:SCNLabel!
	var cellPort1:SCNPort!
	var cellLabel2:SCNLabel!
	var cellPort2:SCNPort!
	var cellLabel3:SCNLabel!
	var cellPort3:SCNPort!
	
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
		
		cellPort1 = SCNPort(host: self)
		cellPort1.position = SCNVector3(x: -distance, y: templates.lineSpacing, z: 0)
		cellLabel1 = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cellLabel1.position = SCNVector3(x: -0.2, y:0, z: 0)
		cellPort1.addChildNode(cellLabel1)
		interface.addChildNode(cellPort1)
		
		cellPort2 = SCNPort(host: self)
		cellPort2.position = SCNVector3(x: -distance, y: 0, z: 0)
		cellLabel2 = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cellLabel2.position = SCNVector3(x: -0.2, y: 0, z: 0)
		cellPort2.addChildNode(cellLabel2)
		interface.addChildNode(cellPort2)
		
		cellPort3 = SCNPort(host: self)
		cellPort3.position = SCNVector3(x: -distance, y: -templates.lineSpacing, z: 0)
		cellLabel3 = SCNLabel(text: "cell", scale: 0.1, align: alignment.right)
		cellLabel3.position = SCNVector3(x: -0.2, y: 0, z: 0)
		cellPort3.addChildNode(cellLabel3)
		interface.addChildNode(cellPort3)
		
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
		cellPort1.addEvent(items.cell1)
	}
	
	override func update()
	{
		if cellPort1.event != nil {
			cellLabel1.update(cellPort1.event.name!, color: white)
			cellPort1.enable()
		}
		else{
			cellLabel1.update("--", color: grey)
			cellPort1.disable()
		}
		
		if cellPort2.event != nil {
			cellLabel2.update(cellPort2.event.name!, color: white)
			cellPort2.enable()
		}
		else{
			cellLabel2.update("--", color: grey)
			cellPort2.disable()
		}
		
		if cellPort3.event != nil {
			cellLabel3.update(cellPort3.event.name!, color: white)
			cellPort3.enable()
		}
		else{
			cellLabel3.update("--", color: grey)
			cellPort3.disable()
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
		if cellPort1.event != nil && cellPort1.connection != nil { cellPort1.connection.host.listen(cellPort1.event) }
		if cellPort2.event != nil && cellPort2.connection != nil { cellPort2.connection.host.listen(cellPort2.event) }
		if cellPort3.event != nil && cellPort3.connection != nil { cellPort3.connection.host.listen(cellPort3.event) }
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
		
		if cellPort1.event == nil { cellLabel1.update("\(Int(uploadProgress))%", color: grey) }
		else if cellPort2.event == nil { cellLabel2.update("\(Int(uploadProgress))%", color: grey) }
		else if cellPort3.event == nil { cellLabel3.update("\(Int(uploadProgress))%", color: grey) }
		
		if uploadProgress >= 100 {
			uploadCompleted()
		}
	}
	
	func uploadCompleted()
	{
		if cellPort1.event == nil { cellPort1.addEvent(port.syphon()) }
		else if cellPort2.event == nil { cellPort2.addEvent(port.syphon()) }
		else if cellPort3.event == nil { cellPort3.addEvent(port.syphon()) }
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