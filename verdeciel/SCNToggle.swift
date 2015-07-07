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
	var label:SCNLabel!
	
	var cross1:SCNNode!
	var cross2:SCNNode!
	var cross3:SCNNode!
	
	var outline1:SCNNode!
	var outline2:SCNNode!
	var outline3:SCNNode!
	var outline4:SCNNode!
	
	var panelName:String = ""
	
	init(newName:String)
	{
		panelName = newName
		super.init()
		name = newName
		addGeometry()
		update()
	}
	
	func addGeometry()
	{
		let optionPanel = SCNNode(geometry: SCNPlane(width: 1, height: 1))
		optionPanel.geometry?.firstMaterial?.diffuse.contents = clear
		optionPanel.position = position
		optionPanel.name = "trigger.\(panelName)"
		
		outline1 = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: 0.5, y: 0.5, z: 0))
		outline1.name = "\(panelName).handle.top"
		optionPanel.addChildNode(outline1)
		
		outline2 = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: -0.5, y: -0.5, z: 0))
		outline2.name = "\(panelName).handle.left"
		optionPanel.addChildNode(outline2)
		
		outline3 = redLine(SCNVector3(x: -0.5, y: -0.5, z: 0),SCNVector3(x: 0.5, y: -0.5, z: 0))
		outline3.name = "\(panelName).handle.bottom"
		optionPanel.addChildNode(outline3)
		
		outline4 = redLine(SCNVector3(x: 0.5, y: -0.5, z: 0),SCNVector3(x: 0.5, y: 0.5, z: 0))
		outline4.name = "\(panelName).handle.right"
		optionPanel.addChildNode(outline4)
		
		cross1 = redLine(SCNVector3(x: -0.5, y: 0.5, z: 0),SCNVector3(x: 0.5, y: -0.5, z: 0))
		cross1.name = "\(panelName).handle.cross1"
		optionPanel.addChildNode(cross1)
		
		cross2 = redLine(SCNVector3(x: 0.5, y: 0.5, z: 0),SCNVector3(x: -0.5, y: -0.5, z: 0))
		cross2.name = "\(panelName).handle.cross2"
		optionPanel.addChildNode(cross2)
		
		cross3 = redLine(SCNVector3(x: 0.5, y: 0, z: 0),SCNVector3(x: -0.5, y: 0, z: 0))
		cross3.name = "\(panelName).handle.cross3"
		optionPanel.addChildNode(cross3)
		
		self.addChildNode(optionPanel)
		
		label = SCNLabel(text: name!, scale: 0.1, align: alignment.left)
		label.position = SCNVector3(x: 0.75, y: 0, z: 0)
		
		self.addChildNode(label)
	}
	
	func touch()
	{
		println("yay")
		if( user.storage[panelName] == 0){
			user.storage[panelName] = 1
		}
		else{
			user.storage[panelName] = 0
		}
		update()
	}
	
	func update()
	{
		if( user.storage[panelName] == 0){
			
			outline1.geometry!.firstMaterial?.diffuse.contents = red
			outline2.geometry!.firstMaterial?.diffuse.contents = red
			outline3.geometry!.firstMaterial?.diffuse.contents = red
			outline4.geometry!.firstMaterial?.diffuse.contents = red
			
			cross1.geometry!.firstMaterial?.diffuse.contents = red
			cross2.geometry!.firstMaterial?.diffuse.contents = red
			cross3.geometry!.firstMaterial?.diffuse.contents = clear
		}
		else{
			
			outline1.geometry!.firstMaterial?.diffuse.contents = cyan
			outline2.geometry!.firstMaterial?.diffuse.contents = cyan
			outline3.geometry!.firstMaterial?.diffuse.contents = cyan
			outline4.geometry!.firstMaterial?.diffuse.contents = cyan
			
			cross1.geometry!.firstMaterial?.diffuse.contents = clear
			cross2.geometry!.firstMaterial?.diffuse.contents = clear
			cross3.geometry!.firstMaterial?.diffuse.contents = cyan
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}