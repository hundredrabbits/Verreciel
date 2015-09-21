//
//  File.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-08-28.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelCargo : SCNNode
{
	var nameLabel = SCNNode()
	
	// Ports

	var input:SCNPort!
	var output:SCNPort!
	
	override init()
	{
		super.init()
		name = "cargo"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		update()
	}
	
	func addInterface()
	{
		let scale:Float = 0.75
		
		nameLabel = SCNLabel(text: "cargo", scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(nameLabel)
		
		// Quantity
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.5, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.3, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.1, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.1, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.1, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.3, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.3, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.5, z: 0),color:grey))
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.75, y: highNode[7].y * scale, z: 0)
		output = SCNPort(host: self,polarity: true)
		output.position = SCNVector3(x: lowNode[0].x * scale - 0.75, y: highNode[7].y * scale, z: 0)
		
		self.addChildNode(input)
		self.addChildNode(output)
	}
	
	override func touch()
	{
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}