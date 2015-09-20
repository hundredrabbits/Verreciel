//
//  SCNToggle.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPort : SCNNode
{
	var outline1:SCNNode!
	var outline2:SCNNode!
	var outline3:SCNNode!
	var outline4:SCNNode!

	var polarity:Bool = false
	
	init(polarity:Bool)
	{
		self.polarity = polarity
		super.init()
		
		addGeometry()
		update()
	}
	
	func addGeometry()
	{
		self.geometry = SCNPlane(width: 1, height: 1)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		outline1 = SCNLine(nodeA: SCNVector3(x: 0, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: 0, z: 0),color:white)
		outline2 = SCNLine(nodeA: SCNVector3(x: 0.5, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -0.5, z: 0),color:white)
		outline3 = SCNLine(nodeA: SCNVector3(x: 0, y: -0.5, z: 0),nodeB: SCNVector3(x: -0.5, y: 0, z: 0),color:white)
		outline4 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: 0.5, z: 0),color:white)
	}
	
	func touch()
	{
	}
	
	func update()
	{
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}