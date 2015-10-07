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
	var electricityLabel:SCNLabel!
	var shieldLabel:SCNLabel!
	var temperatureLabel:SCNLabel!
	var oxygenLabel:SCNLabel!
	var hullLabel:SCNLabel!
	var radiationLabel:SCNLabel!
	var noiseLabel:SCNLabel!
	var sectorNameLabel:SCNLabel!
	
	var currentSystem = Event(newName: "test", at: CGPoint(x: 999999,y: 999999),type: eventTypes.star)
	
	override init()
	{
		super.init()
		name = "monitor"
		addInterface()
		update()
	}
	
	func addInterface()
	{
		// Draw the frame
		
		let scale:Float = 0.8
		
		// Draw Radar
		
		let northMonitor = SCNNode()
		
		let labelOxygenTitle = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		labelOxygenTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		northMonitor.addChildNode(labelOxygenTitle)
		
		oxygenLabel = SCNLabel(text: "68.5", scale: 0.1, align: alignment.right)
		oxygenLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		northMonitor.addChildNode(oxygenLabel)
		
		let labelShieldTitle = SCNLabel(text: "shield", scale: 0.1, align: alignment.left)
		labelShieldTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		northMonitor.addChildNode(labelShieldTitle)
		
		shieldLabel = SCNLabel(text: "35.7", scale: 0.1, align: alignment.right)
		shieldLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		northMonitor.addChildNode(shieldLabel)
		
		northMonitor.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 1)); // rotate 90 degrees
		
		self.addChildNode(northMonitor)
		
		//
		
		let eastMonitor = SCNNode()
		
		let labelRadiationTitle = SCNLabel(text: "radiation", scale: 0.1, align: alignment.left)
		labelRadiationTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		eastMonitor.addChildNode(labelRadiationTitle)
	
		radiationLabel = SCNLabel(text: "45.3", scale: 0.1, align: alignment.right)
		radiationLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		eastMonitor.addChildNode(radiationLabel)
		
		let labelTemperatureTitle = SCNLabel(text: "temperature", scale: 0.1, align: alignment.left)
		labelTemperatureTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		eastMonitor.addChildNode(labelTemperatureTitle)
		
		temperatureLabel = SCNLabel(text: "34.7", scale: 0.1, align: alignment.right)
		temperatureLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		eastMonitor.addChildNode(temperatureLabel)
		
		eastMonitor.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 2)); // rotate 90 degrees
		
		self.addChildNode(eastMonitor)
		
		//
		
		let southMonitor = SCNNode()
		
		let labelElectricTitle = SCNLabel(text: "electricity", scale: 0.1, align: alignment.left)
		labelElectricTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		
		electricityLabel = SCNLabel(text: "325.5", scale: 0.1, align: alignment.right)
		electricityLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		
		let labelHullTitle = SCNLabel(text: "hull", scale: 0.1, align: alignment.left)
		labelHullTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		
		hullLabel = SCNLabel(text: "355.3", scale: 0.1, align: alignment.right)
		hullLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		
		southMonitor.addChildNode(labelHullTitle)
		southMonitor.addChildNode(labelElectricTitle)
		southMonitor.addChildNode(hullLabel)
		southMonitor.addChildNode(electricityLabel)
		
		self.addChildNode(southMonitor)
		
		//
		
		let westMonitor = SCNNode()
		
		let noiseLabelTitle	= SCNLabel(text: "noise", scale: 0.1, align: alignment.left)
		noiseLabelTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		westMonitor.addChildNode(noiseLabelTitle)
		
		let sectorNameLabelTitle = SCNLabel(text: "Sector", scale: 0.1, align: alignment.left)
		sectorNameLabelTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		westMonitor.addChildNode(sectorNameLabelTitle)
		
		noiseLabel = SCNLabel(text: "null", scale: 0.1, align: alignment.right)
		noiseLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		westMonitor.addChildNode(noiseLabel)
		
		sectorNameLabel = SCNLabel(text: "UNKNOWN", scale: 0.1, align: alignment.right)
		sectorNameLabel.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		westMonitor.addChildNode(sectorNameLabel)
		
		westMonitor.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 3)); // rotate 90 degrees
		
		self.addChildNode(westMonitor)
	}
	
	override func tic()
	{
		updateSystem()
		
		var labelColor = white
		if battery.value < 10 { labelColor = red }
		if capsule.dock != nil && capsule.dock.service == services.electricity { labelColor = cyan }
		electricityLabel.updateWithColor(String(format: "%.1f", battery.value), color: labelColor)
		
		labelColor = white
		if capsule.hull < 10 { labelColor = red }
		if capsule.dock != nil && capsule.dock.service == services.hull { labelColor = cyan }
		hullLabel.updateWithColor(String(format: "%.1f", capsule.hull), color: labelColor)
	}
	
	func updateSystem()
	{
		sectorNameLabel.update(radar.closestEvent(eventTypes.star).name!)
	}
	
	func monitorValue(value:Float) -> String
	{
		var stringValue = ""
		if value < 1 { stringValue = "empty" }
		else if value > 100 { stringValue = "full" }
		else { stringValue = String(format: "%.1f", value) }
		return stringValue
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}