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
		
		var labelOxygenValue = SCNLabel(text: "68.5", scale: 0.1, align: alignment.right)
		labelOxygenValue.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		northMonitor.addChildNode(labelOxygenValue)
		
		var labelTemperatureValue = SCNLabel(text: "34.7", scale: 0.1, align: alignment.right)
		labelTemperatureValue.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		northMonitor.addChildNode(labelTemperatureValue)
		
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
		
		var labelShieldValue = SCNLabel(text: "145.3", scale: 0.1, align: alignment.right)
		labelShieldValue.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		eastMonitor.addChildNode(labelShieldValue)
		
		var labelElectricityValue = SCNLabel(text: "35.7", scale: 0.1, align: alignment.right)
		labelElectricityValue.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		eastMonitor.addChildNode(labelElectricityValue)
		
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
		
		var labelRadiationValue = SCNLabel(text: "325.5", scale: 0.1, align: alignment.right)
		labelRadiationValue.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: lowNode[7].z)
		southMonitor.addChildNode(labelRadiationValue)
		
		var labelHullValue = SCNLabel(text: "355.3", scale: 0.1, align: alignment.right)
		labelHullValue.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: lowNode[7].z)
		southMonitor.addChildNode(labelHullValue)
		
		self.addChildNode(southMonitor)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}