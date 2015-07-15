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

class PanelMonitor : SCNNode
{
	var electricity:Float = 100.0
	var electricityLabel:SCNLabel!
	
	var shield:Float = 100.0
	var shieldLabel:SCNLabel!
	
	var temperature:Float = 100.0
	var temperatureLabel:SCNLabel!
	
	var oxygen:Float = 50.0
	var oxygenLabel:SCNLabel!
	
	var hull:Float = 100.0
	var hullLabel:SCNLabel!
	
	var radiation:Float = 100.0
	var radiationLabel:SCNLabel!
	
	override init()
	{
		super.init()
		name = "monitor"
		addInterface()
	}
	
	func addInterface()
	{
		// Draw the frame
		
		let scale:Float = 0.8
		let nodeA = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale, z: highNode[7].z)
		let nodeB = SCNVector3(x: highNode[0].x * scale, y: highNode[0].y * scale, z: highNode[0].z)
		let nodeC = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: lowNode[7].z)
		let nodeD = SCNVector3(x: lowNode[0].x * scale, y: lowNode[0].y * scale, z: lowNode[0].z)
		
		// Draw Radar
		
		var northMonitor = SCNNode()
		
		var labelOxygenTitle = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		labelOxygenTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		northMonitor.addChildNode(labelOxygenTitle)
		
		var labelTemperatureTitle = SCNLabel(text: "temperature", scale: 0.1, align: alignment.left)
		labelTemperatureTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		northMonitor.addChildNode(labelTemperatureTitle)
		
		oxygenLabel = SCNLabel(text: "68.5", scale: 0.1, align: alignment.right)
		oxygenLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		northMonitor.addChildNode(oxygenLabel)
		
		temperatureLabel = SCNLabel(text: "34.7", scale: 0.1, align: alignment.right)
		temperatureLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		northMonitor.addChildNode(temperatureLabel)
		
		northMonitor.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1)); // rotate 90 degrees
		
		self.addChildNode(northMonitor)
		
		//
		
		var eastMonitor = SCNNode()
		
		var labelShieldTitle = SCNLabel(text: "shield", scale: 0.1, align: alignment.left)
		labelShieldTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		eastMonitor.addChildNode(labelShieldTitle)
		
		var labelElectricityTitle = SCNLabel(text: "electricity", scale: 0.1, align: alignment.left)
		labelElectricityTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		eastMonitor.addChildNode(labelElectricityTitle)
		
		shieldLabel = SCNLabel(text: "45.3", scale: 0.1, align: alignment.right)
		shieldLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		eastMonitor.addChildNode(shieldLabel)
		
		electricityLabel = SCNLabel(text: "35.7", scale: 0.1, align: alignment.right)
		electricityLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		eastMonitor.addChildNode(electricityLabel)
		
		eastMonitor.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2)); // rotate 90 degrees
		
		self.addChildNode(eastMonitor)
		
		//
		
		var southMonitor = SCNNode()
		
		var labelRadiationTitle = SCNLabel(text: "radiation", scale: 0.1, align: alignment.left)
		labelRadiationTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		southMonitor.addChildNode(labelRadiationTitle)
		
		var labelHullTitle = SCNLabel(text: "hull", scale: 0.1, align: alignment.left)
		labelHullTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		southMonitor.addChildNode(labelHullTitle)
		
		radiationLabel = SCNLabel(text: "325.5", scale: 0.1, align: alignment.right)
		radiationLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		southMonitor.addChildNode(radiationLabel)
		
		hullLabel = SCNLabel(text: "355.3", scale: 0.1, align: alignment.right)
		hullLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		southMonitor.addChildNode(hullLabel)
		
		self.addChildNode(southMonitor)
	}
	
	func update()
	{
		oxygen += oxygenMod()
		oxygenLabel.update(monitorValue(oxygen))
		shield += shieldMod()
		shieldLabel.update(monitorValue(shield))
		electricity += electricityMod()
		electricityLabel.update(monitorValue(electricity))
		temperature += temperatureMod()
		temperatureLabel.update(monitorValue(temperature))
	}
	
	func monitorValue(value:Float) -> String
	{
		var stringValue = ""
		if value < 1 { stringValue = "empty" }
		else if value > 100 { stringValue = "full" }
		else { stringValue = String(format: "%.1f", value) }
		return stringValue
	}
	
	func oxygenMod() -> Float
	{
		var modifier:Float = -0.02
		
		if breaker.oxygenToggle.active { modifier += 0.5 }
		
		if oxygen > 100 && modifier > 0 { modifier = 0 }
		if oxygen < 0 && modifier < 0 { modifier = 0 }
		
		return modifier
	}
	
	func shieldMod() -> Float
	{
		var modifier:Float = -0.02
		
		if breaker.shieldToggle.active { modifier += 0.5 }
		
		return modifier
	}
	
	func temperatureMod() -> Float
	{
		var modifier:Float = -0.1
		
		if breaker.oxygenToggle.active { modifier += 0.02 }
		if thruster.speed > 0 { modifier += thruster.speed / 10 }
		
		if radio.frequencyA > 0 { modifier += 0.01 }
		if radio.frequencyB > 0 { modifier += 0.01 }
		if radio.frequencyC > 0 { modifier += 0.01 }
		
		return modifier
	}
	
	func electricityMod() -> Float
	{
		var modifier:Float = 0
		
		if breaker.oxygenToggle.active { modifier -= 0.05 }
		if thruster.speed > 0 { modifier -= thruster.speed / 20 }
		if radio.frequencyA > 0 { modifier -= 0.01 }
		if radio.frequencyB > 0 { modifier -= 0.01 }
		if radio.frequencyC > 0 { modifier -= 0.01 }
		
		return modifier
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}