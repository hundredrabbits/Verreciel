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
	var electricToggleNode:SCNToggle!
	var oxygenToggleNode:SCNToggle!
	
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
		
		let titleLabel = SCNLabel(text: "breaker", scale: 0.1, align: alignment.left)
		titleLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale, z: 0)
		titleLabel.name = "radar.label"
		self.addChildNode(titleLabel)
		
		electricToggleNode = SCNToggle(newName: "electric")
		electricToggleNode.position = SCNVector3(x: (lowNode[7].x * scale) + 0.5, y: -0.8, z: 0)
		self.addChildNode(electricToggleNode)
		
		oxygenToggleNode = SCNToggle(newName: "oxygen")
		oxygenToggleNode.position = SCNVector3(x: (lowNode[7].x * scale) + 0.5, y: 0.4, z: 0)
		self.addChildNode(oxygenToggleNode)
	}
	
	func touch(choice:String)
	{
		if choice == "oxygen" { oxygenToggleNode.touch() }
		if choice == "electric" { electricToggleNode.touch() }
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}