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

class PanelHandle : SCNNode
{
	var destination:SCNVector3!
	
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
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 1, y: 0.5, z: 0),nodeB: SCNVector3(x: 1.1, y: 0, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.75, y: 0.5, z: 0),nodeB: SCNVector3(x: 1, y: 0.5, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.75, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.75, y: 0.5, z: 0),color:cyan))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.75, y: 0.5, z: 0),nodeB: SCNVector3(x: -1, y: 0.5, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -1, y: 0.5, z: 0),nodeB: SCNVector3(x: -1.1, y: 0, z: 0),color:grey))
	}
	
	override func touch()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		cameraNode.position = destination
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}