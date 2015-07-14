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
		// Oxygen
		oxygen += oxygenMod()
		if oxygen < 1 { oxygenLabel.update("empty") }
		else if oxygen > 100 { oxygenLabel.update("full") }
		else { oxygenLabel.update(String(format: "%.1f", oxygen)) }
		
		// Temperature
		
		
		
		/*
		
		if electricity >= 0 { electricity -= 0.1 }
		if shield >= 0 { shield -= 0.1 }
		if temperature >= 0 { temperature -= 0.1 }
		if hull >= 0 { hull -= 0.1 }
		if radiation >= 0 { radiation -= 0.1 }
		
		electricityLabel.update(String(format: "%.1f", electricity))
		shieldLabel.update(String(format: "%.1f", shield))
		temperatureLabel.update(String(format: "%.1f", temperature))
		hullLabel.update(String(format: "%.1f", hull))
		radiationLabel.update(String(format: "%.1f", radiation))

*/
	}
	
	func oxygenMod() -> Float
	{
		var modifier:Float = 0
		
		modifier += -0.02
		if breaker.oxygenToggle.active { modifier += 0.5 }
		
		
		if oxygen > 100 && modifier > 0 { modifier = 0 }
		if oxygen < 0 && modifier < 0 { modifier = 0 }
		
		return modifier
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}