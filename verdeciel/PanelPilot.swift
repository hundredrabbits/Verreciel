//
//  SCNNavigation.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelPilot : SCNNode
{
	var nameLabel = SCNNode()
	
	// Ports
	
	var input:SCNPort!
	var output:SCNPort!
	
	override init()
	{
		super.init()
		name = "pilot"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: -3, z: lowNode[7].z)
	}
	
	func addInterface()
	{
		let scale:Float = 0.75
		
		nameLabel = SCNLabel(text: self.name!, scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(nameLabel)
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.7, y: highNode[7].y * scale, z: 0)
		output = SCNPort(host: self,polarity: true)
		output.position = SCNVector3(x: lowNode[0].x * scale - 0.7, y: highNode[7].y * scale, z: 0)
		
		self.addChildNode(input)
		self.addChildNode(output)
	}
	
	override func update()
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}