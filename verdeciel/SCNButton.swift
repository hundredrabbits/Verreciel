//
//  SCNButton.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNButton : SCNNode
{
	var outline1:SCNNode!
	var outline2:SCNNode!
	var outline3:SCNNode!
	var outline4:SCNNode!
	
	var panelName:String = ""
	
	init(newName:String)
	{
		super.init()
		panelName = newName
		addGeometry()
		update()
	}
	
	func addGeometry()
	{
		let optionPanel = SCNNode(geometry: SCNPlane(width: 1, height: 1))
		optionPanel.geometry?.firstMaterial?.diffuse.contents = clear
		optionPanel.position = position
		
		optionPanel.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.75, z: 0),nodeB: SCNVector3(x: 0.75, y: 0, z: 0),color:white))
		optionPanel.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.75, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.75, z: 0),color:white))
		optionPanel.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.75, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: 0.75, z: 0),color:white))
		optionPanel.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.75, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.75, z: 0),color:white))
		
		outline1 = SCNLine(nodeA: SCNVector3(x: 0, y: 0.5, z: 0), nodeB:SCNVector3(x: 0.5, y: 0, z: 0),color:red)
		optionPanel.addChildNode(outline1)
		outline2 = SCNLine(nodeA: SCNVector3(x: 0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.5, z: 0),color:red)
		optionPanel.addChildNode(outline2)
		outline3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: 0.5, z: 0),color:red)
		optionPanel.addChildNode(outline3)
		outline4 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0), nodeB:SCNVector3(x: 0, y: -0.5, z: 0),color:red)
		optionPanel.addChildNode(outline4)
		
		self.addChildNode(optionPanel)
		
	}
	
	override func touch()
	{
		update()
	}
	
	func update()
	{
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}