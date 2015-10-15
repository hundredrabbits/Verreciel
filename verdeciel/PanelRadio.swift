//
//  PanelBeacon.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelRadio : Panel
{
	var inputLabel:SCNLabel!
	var outputLabel:SCNLabel!
	var input:SCNPort!
	var output:SCNPort!
	
	override func setup()
	{
		name = "radio"
		self.position = SCNVector3(x: 0, y: -1 * highNode[7].y * 0.8 - 0.6, z: lowNode[7].z)
		
		input = SCNPort(host: self, polarity: false)
		input.position = SCNVector3(x: templates.leftMargin + 0.1, y: -0.3, z: 0)
		output = SCNPort(host: self, polarity: true)
		output.position = SCNVector3(x: templates.rightMargin - 0.15, y: -0.3, z: 0)
		
		inputLabel = SCNLabel(text: self.name!, scale: 0.1, align: alignment.left)
		inputLabel.position = SCNVector3(x: templates.leftMargin + 0.3, y: -0.3, z: 0)
		inputLabel.updateWithColor(self.name!, color: grey)
		
		outputLabel = SCNLabel(text: "output", scale: 0.1, align: alignment.right)
		outputLabel.position = SCNVector3(x: templates.rightMargin - 0.3, y: -0.3, z: 0)
		outputLabel.updateColor(grey)
		
		self.addChildNode(input)
		self.addChildNode(output)
		self.addChildNode(inputLabel)
		self.addChildNode(outputLabel)
		
	}
}