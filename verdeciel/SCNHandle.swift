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

class SCNHandle : Panel
{
	var destination:SCNVector3!
	var selectionLine1:SCNLine!
	var selectionLine2:SCNLine!
	var selectionLine3:SCNLine!
	var trigger:SCNTrigger!
	
	init(destination:SCNVector3 = SCNVector3())
	{
		self.destination = destination
		
		super.init()
	}
	
	override func installation()
	{
		
	}
	
	override func setup()
	{
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		selectionLine1 = SCNLine(nodeA: SCNVector3(x: -0.3, y: 0.1, z: 0),nodeB: SCNVector3(x: 0.3, y: 0.1, z: 0),color:cyan)
		selectionLine2 = SCNLine(nodeA: SCNVector3(x: -0.3, y: 0, z: 0),nodeB: SCNVector3(x: 0.3, y: 0, z: 0),color:cyan)
		selectionLine3 = SCNLine(nodeA: SCNVector3(x: -0.3, y: -0.1, z: 0),nodeB: SCNVector3(x: 0.3, y: -0.1, z: 0),color:cyan)
		interface.addChildNode(selectionLine1)
		interface.addChildNode(selectionLine2)
		interface.addChildNode(selectionLine3)
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.5), operation: 0)
		trigger.updateChildrenColors(red)
		interface.addChildNode(trigger)
	}
	
	override func enable()
	{
		isEnabled = true
		selectionLine1.updateColor(cyan)
		selectionLine2.updateColor(cyan)
		selectionLine3.updateColor(cyan)
	}
	
	override func disable()
	{
		isEnabled = false
		selectionLine1.updateColor(grey)
		selectionLine2.updateColor(grey)
		selectionLine3.updateColor(grey)
	}
	
	override func touch(id:Int = 0)
	{
		if player.handle != nil { player.handle.enable() }
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		player.position = destination
		ui.position = destination
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		player.handle = self
		player.handle.disable()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}