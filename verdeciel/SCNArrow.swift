//
//  SCNArrow.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNArrow : SCNNode
{
	let cardinal:cardinals!
	
	init(direction:cardinals)
	{
		cardinal = direction
		super.init()
		
		addInterface()
	}
	
	func addInterface()
	{
		if cardinal == cardinals.w {
			self.geometry = SCNPlane(width: 0.5, height: 0.5)
			self.geometry?.firstMaterial?.diffuse.contents = clear
			self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.25, z: 0), nodeB: SCNVector3(x: 0.25, y: 0, z: 0),color:white))
			self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.25, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: -0.25, z: 0),color:white))
			self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.25, z: 0), nodeB: SCNVector3(x: 0, y: -0.25, z: 0),color:white))
			self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: -0.25, y: 0, z: 0),color:white))
		}
		else{
			self.geometry = SCNPlane(width: 0.5, height: 0.5)
			self.geometry?.firstMaterial?.diffuse.contents = clear
			self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.25, z: 0), nodeB: SCNVector3(x: -0.25, y: 0, z: 0),color:white))
			self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.25, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: -0.25, z: 0),color:white))
			self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.25, z: 0), nodeB: SCNVector3(x: 0, y: -0.25, z: 0),color:white))
			self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: 0.25, y: 0, z: 0),color:white))
		}
	}
	
	func touch()
	{
		if cardinal == cardinals.e {
			navigation.turn(true)
		}
		else{
			navigation.turn(false)
		}
	}
	
	func update()
	{
	
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}