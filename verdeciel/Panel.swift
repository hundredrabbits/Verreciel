//
//  SCNNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Panel : SCNNode
{
	var isPowered:Bool = false
	var isInstalled:Bool = false
	var isEnabled:Bool = true
	var interface:SCNNode!
	var decals:SCNNode!
	
	init(position:SCNVector3 = SCNVector3(0,0,0))
	{
		super.init()
		
		interface = SCNNode()
		self.addChildNode(interface)
		decals = SCNNode()
		self.addChildNode(decals)
		
		setup()
		start()
	}
	
	func install()
	{
		isInstalled = true
	}
	
	func setPower(power:Bool)
	{
		print("Missing unpowered mode for \(name!).")
	}
	
	func setup()
	{
	}
	
	func updateInterface(interface:Panel)
	{
		// Empty node
		for node in self.childNodes {
			node.removeFromParentNode()
		}
		
		// Add
		for node in interface.childNodes {
			self.addChildNode(node)
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}