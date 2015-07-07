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

class SCNMonitor : SCNNode
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
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		var labelOxygenTitle = SCNLabel(text: "oxygen", scale: 0.1, align: alignment.left)
		labelOxygenTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.6, z: 0)
		labelOxygenTitle.name = "monitor.label"
		self.addChildNode(labelOxygenTitle)
		
		var labelTemperatureTitle = SCNLabel(text: "temperature", scale: 0.1, align: alignment.left)
		labelTemperatureTitle.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale + 0.9, z: 0)
		labelTemperatureTitle.name = "monitor.label"
		self.addChildNode(labelTemperatureTitle)
		
		
		var labelOxygenValue = SCNLabel(text: "68.5", scale: 0.1, align: alignment.right)
		labelOxygenValue.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.6, z: 0)
		labelOxygenValue.name = "monitor.label"
		self.addChildNode(labelOxygenValue)
		
		var labelTemperatureValue = SCNLabel(text: "34.7", scale: 0.1, align: alignment.right)
		labelTemperatureValue.position = SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale + 0.9, z: 0)
		labelTemperatureValue.name = "monitor.label"
		self.addChildNode(labelTemperatureValue)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}