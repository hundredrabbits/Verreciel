//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelBattery : Panel
{
	var isUploading:Bool = false
	var uploadProgress:CGFloat = 0
	
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
		cell1.addEvent(items.smallBattery)
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
		
		thrusterPort = SCNPort(host: self, input:eventTypes.battery)
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
		
		port.input = eventTypes.battery
		port.output = eventTypes.unknown
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(0,0,-1)))
	}
	
	override func start()
	{
		thrusterPort.enable()
		cell1.addEvent(items.smallBattery)
		update()
	}
	
	override func listen(event:Event)
	{
		if event.details != eventDetails.battery { return }
		
		// Find free slot
		if cell2.event == nil {
			uploadItem(event)
		}
		else if cell3.event == nil {
			cell3.addEvent(event)
		}
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
			uploadProgress += CGFloat(arc4random_uniform(100))/50
			cell2Label.update("\(Int(uploadProgress))%", color: grey)
			if uploadProgress >= 100 {
				uploadCompleted()
			}
		}
	}
	
	func uploadItem(item:Event)
	{
		isUploading = true
	}
	
	func uploadCompleted()
	{
		cell2.addEvent(port.syphon())
		isUploading = false
		update()
		cargo.bang()
	}
	
	func isRadioPowered() -> Bool
	{
		if radioPort.origin != nil && radioPort.origin.event != nil && radioPort.origin.event.type == eventTypes.battery { return true }
		return false
	}
	
	func isThrusterPowered() -> Bool
	{
		if thrusterPort.origin != nil && thrusterPort.origin.event != nil && thrusterPort.origin.event.type == eventTypes.battery { return true }
		return false
	}
}