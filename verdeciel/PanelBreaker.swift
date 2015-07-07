//
//  PanelSwitch.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelBreaker : SCNNode
{
	override init()
	{
		super.init()
		name = "breaker"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		let titleLabel = SCNLabel(text: "switchboard", scale: 0.1, align: alignment.left)
		titleLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale, z: 0)
		titleLabel.name = "radar.label"
		self.addChildNode(titleLabel)
		
		let electricToggleNode = SCNToggle(name: "electric")
		electricToggleNode.position = SCNVector3(x: (lowNode[7].x * scale) + 0.5, y: -0.8, z: 0)
		self.addChildNode(electricToggleNode)
		
		let oxygenToggleNode = SCNToggle(name: "oxygen")
		oxygenToggleNode.position = SCNVector3(x: (lowNode[7].x * scale) + 0.5, y: 0.4, z: 0)
		self.addChildNode(oxygenToggleNode)
	}
	
	func touch()
	{
		update()
	}
	
	func update()
	{
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}