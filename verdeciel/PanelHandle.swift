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

class PanelHandle : Panel
{
	var destination:SCNVector3!
	var selectionLine:SCNLine!
	
	init(destination:SCNVector3)
	{
		super.init()
		
		self.destination = destination
		
		self.position = SCNVector3(x: 0, y: highGapNode[4].y, z: lowNode[7].z)
		self.geometry = SCNBox(width: 2, height: 1, length: 1, chamferRadius: 0)
		self.geometry?.materials.first?.diffuse.contents = clear
		addInterface()
	}
	
	func addInterface()
	{
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 1, y: 0.25, z: 0.3),nodeB: SCNVector3(x: 1.1, y: 0, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.75, y: 0.25, z: 0.3),nodeB: SCNVector3(x: 1, y: 0.25, z: 0.3),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.75, y: 0.25, z: 0.3),nodeB: SCNVector3(x: -1, y: 0.25, z: 0.3),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -1, y: 0.25, z: 0.3),nodeB: SCNVector3(x: -1.1, y: 0, z: 0),color:grey))
		
		selectionLine = SCNLine(nodeA: SCNVector3(x: -0.75, y: 0.25, z: 0.3),nodeB: SCNVector3(x: 0.75, y: 0.25, z: 0.3),color:cyan)
		self.addChildNode(selectionLine)
	}
	
	func enable()
	{
		isEnabled = true
		selectionLine.updateColor(cyan)
	}
	
	func disable()
	{
		isEnabled = false
		selectionLine.updateColor(grey)
	}
	
	override func touch()
	{
		if player.handle != nil { player.handle.enable() }
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		cameraNode.position = destination
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		player.handle = self
		player.handle.disable()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}