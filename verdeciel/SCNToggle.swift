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

class SCNToggle : SCNNode
{
	let activeName:String!
	var label:SCNLabel!
	
	init(name:String)
	{
		activeName = name
		super.init()
		addGeometry()
	}
	
	func addGeometry()
	{
		let optionPanel = SCNNode(geometry: SCNPlane(width: 1, height: 1))
		optionPanel.geometry?.firstMaterial?.diffuse.contents = clear
		optionPanel.position = position
		optionPanel.name = "trigger.\(name)"
		
		let lineTest = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: 0.5, y: 0.5, z: 0))
		lineTest.name = "\(name).handle.top"
		optionPanel.addChildNode(lineTest)
		
		let lineTest2 = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: -0.5, y: -0.5, z: 0))
		lineTest2.name = "\(name).handle.left"
		optionPanel.addChildNode(lineTest2)
		
		let lineTest3 = redLine(SCNVector3(x: -0.5, y: -0.5, z: 0),SCNVector3(x: 0.5, y: -0.5, z: 0))
		lineTest3.name = "\(name).handle.bottom"
		optionPanel.addChildNode(lineTest3)
		
		let lineTest4 = redLine(SCNVector3(x: 0.5, y: -0.5, z: 0),SCNVector3(x: 0.5, y: 0.5, z: 0))
		lineTest3.name = "\(name).handle.right"
		optionPanel.addChildNode(lineTest4)
		
		let lineTest5 = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: 0.5, y: -0.5, z: 0))
		lineTest5.name = "\(name).handle.cross1"
		optionPanel.addChildNode(lineTest5)
		
		let lineTest6 = redLine(SCNVector3(x: 0.5, y: 0.5, z: 0),SCNVector3(x: -0.5, y: -0.5, z: 0))
		lineTest6.name = "\(name).handle.cross2"
		optionPanel.addChildNode(lineTest6)
		
		/*
		
		let lineTest7 = redLine(SCNVector3(x: 0.5, y: 0, z: 0),SCNVector3(x: -0.5, y: 0, z: 0))
		lineTest7.name = "\(name).handle.cross3"
		optionPanel.addChildNode(lineTest7)
		*/
		
		self.addChildNode(optionPanel)
		
		label = SCNLabel(text: activeName, scale: 0.1, align: alignment.left)
		label.position = SCNVector3(x: 0.75, y: 0, z: 0)
		
		self.addChildNode(label)
	}
	
	func update()
	{
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}