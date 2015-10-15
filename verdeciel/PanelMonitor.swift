//
//  SCNMonitor.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelMonitor : Panel
{	
	var electricityLabel:SCNLabel!
	var shieldLabel:SCNLabel!
	var temperatureLabel:SCNLabel!
	var oxygenLabel:SCNLabel!
	var hullLabel:SCNLabel!
	var radiationLabel:SCNLabel!
	
	var currentSystem = Event(newName: "test", at: CGPoint(x: 999999,y: 999999),type: eventTypes.star)
	
	override func setup()
	{
		let northMonitor = SCNNode()
		
		let labelOxygenTitle = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		labelOxygenTitle.position = SCNVector3(x: templates.leftMargin, y: 0, z: templates.radius)
		northMonitor.addChildNode(labelOxygenTitle)
		
		oxygenLabel = SCNLabel(text: "68.5", scale: 0.1, align: alignment.right)
		oxygenLabel.position = SCNVector3(x: templates.rightMargin, y: 0, z: templates.radius)
		northMonitor.addChildNode(oxygenLabel)
		
		let labelShieldTitle = SCNLabel(text: "shield", scale: 0.1, align: alignment.left)
		labelShieldTitle.position = SCNVector3(x: templates.leftMargin, y: 0.3, z: templates.radius)
		northMonitor.addChildNode(labelShieldTitle)
		
		shieldLabel = SCNLabel(text: "35.7", scale: 0.1, align: alignment.right)
		shieldLabel.position = SCNVector3(x: templates.rightMargin, y: 0.3, z: templates.radius)
		northMonitor.addChildNode(shieldLabel)
		
		northMonitor.eulerAngles.y += Float(degToRad(90))
		northMonitor.eulerAngles.x += Float(degToRad(templates.monitorsAngle))
		
		self.addChildNode(northMonitor)
		
		//
		
		let eastMonitor = SCNNode()
		
		let labelRadiationTitle = SCNLabel(text: "radiation", scale: 0.1, align: alignment.left)
		labelRadiationTitle.position = SCNVector3(x: templates.leftMargin, y: 0, z: templates.radius)
		eastMonitor.addChildNode(labelRadiationTitle)
		
		radiationLabel = SCNLabel(text: "45.3", scale: 0.1, align: alignment.right)
		radiationLabel.position = SCNVector3(x: templates.rightMargin, y: 0, z: templates.radius)
		eastMonitor.addChildNode(radiationLabel)
		
		let labelTemperatureTitle = SCNLabel(text: "temperature", scale: 0.1, align: alignment.left)
		labelTemperatureTitle.position = SCNVector3(x: templates.leftMargin, y: 0.3, z: templates.radius)
		eastMonitor.addChildNode(labelTemperatureTitle)
		
		temperatureLabel = SCNLabel(text: "34.7", scale: 0.1, align: alignment.right)
		temperatureLabel.position = SCNVector3(x: templates.rightMargin, y: 0.3, z: templates.radius)
		eastMonitor.addChildNode(temperatureLabel)
		
		eastMonitor.eulerAngles.y += Float(degToRad(180))
		eastMonitor.eulerAngles.x += Float(degToRad(templates.monitorsAngle))
		
		self.addChildNode(eastMonitor)
		
		//
		
		let southMonitor = SCNNode()
		
		let labelElectricTitle = SCNLabel(text: "electricity", scale: 0.1, align: alignment.left)
		labelElectricTitle.position = SCNVector3(x: templates.leftMargin, y: 0, z: templates.radius)
		
		electricityLabel = SCNLabel(text: "325.5", scale: 0.1, align: alignment.right)
		electricityLabel.position = SCNVector3(x: templates.rightMargin, y: 0, z: templates.radius)
		
		let labelHullTitle = SCNLabel(text: "hull", scale: 0.1, align: alignment.left)
		labelHullTitle.position = SCNVector3(x: templates.leftMargin, y: 0.3, z: templates.radius)
		
		hullLabel = SCNLabel(text: "355.3", scale: 0.1, align: alignment.right)
		hullLabel.position = SCNVector3(x: templates.rightMargin, y: 0.3, z: templates.radius)
		
		southMonitor.addChildNode(labelHullTitle)
		southMonitor.addChildNode(labelElectricTitle)
		southMonitor.addChildNode(hullLabel)
		southMonitor.addChildNode(electricityLabel)
		
		southMonitor.eulerAngles.y += Float(degToRad(0))
		southMonitor.eulerAngles.x += Float(degToRad(templates.monitorsAngle))
		
		self.addChildNode(southMonitor)
		
		update()
	}
	
	override func fixedUpdate()
	{		
		var labelColor = white
		if battery.value < 10 { labelColor = red }
		if capsule.dock != nil && capsule.dock.service == services.electricity { labelColor = cyan }
		electricityLabel.updateWithColor(String(format: "%.1f", battery.value), color: labelColor)
		
		labelColor = white
		if capsule.hull < 10 { labelColor = red }
		if capsule.dock != nil && capsule.dock.service == services.hull { labelColor = cyan }
		hullLabel.updateWithColor(String(format: "%.1f", capsule.hull), color: labelColor)
		
		labelColor = white
		if capsule.shield < 10 { labelColor = red }
		if battery.inShield.origin != nil {	if battery.inShield.origin.event.type == eventTypes.cell && capsule.shield < 100 { labelColor = cyan } }
		shieldLabel.updateWithColor(String(format: "%.1f", capsule.shield), color: labelColor)
		
		labelColor = white
		if capsule.oxygen < 10 { labelColor = red }
		if battery.inOxygen.origin != nil {	if battery.inOxygen.origin.event.type == eventTypes.cell && capsule.oxygen < 100 { labelColor = cyan } }
		oxygenLabel.updateWithColor(String(format: "%.1f", capsule.oxygen), color: labelColor)
	}
	
	func monitorValue(value:Float) -> String
	{
		var stringValue = ""
		if value < 1 { stringValue = "empty" }
		else if value > 100 { stringValue = "full" }
		else { stringValue = String(format: "%.1f", value) }
		return stringValue
	}
}