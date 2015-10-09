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

class PanelWindow : Panel
{
	override init()
	{
		super.init()
		addInterface()
	}
	
	func addInterface()
	{
		let depth:Float = 0
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.25, y: ceilingNode[0].y + depth, z: 0.25),nodeB: SCNVector3(x: -0.25, y: ceilingNode[0].y + depth, z: -0.25),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.25, y: ceilingNode[0].y + depth, z: -0.25),nodeB: SCNVector3(x: -0.25, y: ceilingNode[0].y + depth, z: 0.25),color:white))
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: ceilingNode[0].y + depth, z: ceilingNode[0].z),nodeB: SCNVector3(x: ceilingNode[2].x, y: ceilingNode[0].y + depth, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: ceilingNode[0].y + depth, z: ceilingNode[0].z),nodeB: SCNVector3(x: ceilingNode[6].x, y: ceilingNode[4].y + depth, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: ceilingNode[0].y + depth, z: -ceilingNode[0].z),nodeB: SCNVector3(x: ceilingNode[2].x, y: ceilingNode[0].y + depth, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: ceilingNode[0].y + depth, z: -ceilingNode[0].z),nodeB: SCNVector3(x: ceilingNode[6].x, y: ceilingNode[4].y + depth, z: 0),color:white))
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: ceilingNode[0].y + depth, z: ceilingNode[0].z),nodeB: SCNVector3(x: 0, y: ceilingNode[0].y, z: ceilingNode[0].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: ceilingNode[4].y + depth, z: ceilingNode[4].z),nodeB: SCNVector3(x: 0, y: ceilingNode[4].y, z: ceilingNode[4].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[2].x, y: ceilingNode[0].y + depth, z: 0),nodeB: SCNVector3(x: ceilingNode[2].x, y: ceilingNode[0].y, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[6].x, y: ceilingNode[4].y + depth, z: 0),nodeB: SCNVector3(x: ceilingNode[6].x, y: ceilingNode[4].y, z: 0),color:white))
	}
	
	override func touch()
	{
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}