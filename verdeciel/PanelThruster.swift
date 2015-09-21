//
//  SCNThruster.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelThruster : SCNNode
{
	var nameLabel = SCNNode()
	
	// Ports
	
	var input:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "thruster"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		update()
	}

	
	func addInterface()
	{
		let scale:Float = 0.75
		
		nameLabel = SCNLabel(text: self.name!, scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(nameLabel)
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.7, 0), nodeB: SCNVector3(0.5, 0.5, 0), color: cyan))
		self.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.7, 0), nodeB: SCNVector3(-0.5, 0.5, 0), color: cyan))
		
//		self.addChildNode(SCNLine(nodeA: SCNVector3(0.5, -0.5, 0), nodeB: SCNVector3(0.5, 0.5, 0), color: white))
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(-0.5, 0.3, 0), nodeB: SCNVector3(0.5, 0.3, 0), color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(-0.5, 0.1, 0), nodeB: SCNVector3(0.5, 0.1, 0), color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(-0.5, -0.1, 0), nodeB: SCNVector3(0.5, -0.1, 0), color: white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(-0.5, -0.3, 0), nodeB: SCNVector3(0.5, -0.3, 0), color: white))
		
//		self.addChildNode(SCNLine(nodeA: SCNVector3(-0.5, -0.5, 0), nodeB: SCNVector3(-0.5, 0.5, 0), color: white))
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.7, 0), nodeB: SCNVector3(0.5, -0.5, 0), color: red))
		self.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.7, 0), nodeB: SCNVector3(-0.5, -0.5, 0), color: red))
		
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.7, y: highNode[7].y * scale, z: 0)
		
		self.addChildNode(input)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}