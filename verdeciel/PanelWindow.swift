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

class PanelWindow : SCNNode
{
	override init()
	{
		super.init()
		addInterface()
	}
	
	func addInterface()
	{
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.25, y: ceilingNode[0].y + 2, z: 0.25),nodeB: SCNVector3(x: -0.25, y: ceilingNode[0].y + 2, z: -0.25),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.25, y: ceilingNode[0].y + 2, z: -0.25),nodeB: SCNVector3(x: -0.25, y: ceilingNode[0].y + 2, z: 0.25),color:white))
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[0].x, y: ceilingNode[0].y + 2, z: ceilingNode[0].z),nodeB: SCNVector3(x: ceilingNode[1].x, y: ceilingNode[1].y + 2, z: ceilingNode[1].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[1].x, y: ceilingNode[1].y + 2, z: ceilingNode[1].z),nodeB: SCNVector3(x: ceilingNode[2].x, y: ceilingNode[2].y + 2, z: ceilingNode[2].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[2].x, y: ceilingNode[2].y + 2, z: ceilingNode[2].z),nodeB: SCNVector3(x: ceilingNode[3].x, y: ceilingNode[3].y + 2, z: ceilingNode[3].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[3].x, y: ceilingNode[3].y + 2, z: ceilingNode[3].z),nodeB: SCNVector3(x: ceilingNode[4].x, y: ceilingNode[4].y + 2, z: ceilingNode[4].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[4].x, y: ceilingNode[4].y + 2, z: ceilingNode[4].z),nodeB: SCNVector3(x: ceilingNode[5].x, y: ceilingNode[5].y + 2, z: ceilingNode[5].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[5].x, y: ceilingNode[5].y + 2, z: ceilingNode[5].z),nodeB: SCNVector3(x: ceilingNode[6].x, y: ceilingNode[6].y + 2, z: ceilingNode[6].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[6].x, y: ceilingNode[6].y + 2, z: ceilingNode[6].z),nodeB: SCNVector3(x: ceilingNode[7].x, y: ceilingNode[7].y + 2, z: ceilingNode[7].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[7].x, y: ceilingNode[7].y + 2, z: ceilingNode[7].z),nodeB: SCNVector3(x: ceilingNode[0].x, y: ceilingNode[0].y + 2, z: ceilingNode[0].z),color:white))
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: ceilingNode[0].y + 2, z: ceilingNode[0].z),nodeB: SCNVector3(x: 0, y: ceilingNode[0].y, z: ceilingNode[0].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: ceilingNode[4].y + 2, z: ceilingNode[4].z),nodeB: SCNVector3(x: 0, y: ceilingNode[4].y, z: ceilingNode[4].z),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[2].x, y: ceilingNode[0].y + 2, z: 0),nodeB: SCNVector3(x: ceilingNode[2].x, y: ceilingNode[0].y, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: ceilingNode[6].x, y: ceilingNode[4].y + 2, z: 0),nodeB: SCNVector3(x: ceilingNode[6].x, y: ceilingNode[4].y, z: 0),color:white))
	}
	
	override func touch()
	{
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}