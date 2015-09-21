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
	
	var active:Bool = false
	
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
		self.geometry = SCNPlane(width: 1, height: 1)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		outline1 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.5, z: 0),color:white)
		outline1.name = "\(panelName).handle.top"
		self.addChildNode(outline1)
		
		outline2 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: -0.5, y: -0.5, z: 0),color:white)
		outline2.name = "\(panelName).handle.left"
		self.addChildNode(outline2)
		
		outline3 = SCNLine(nodeA: SCNVector3(x: -0.5, y: -0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.5, z: 0),color:white)
		outline3.name = "\(panelName).handle.bottom"
		self.addChildNode(outline3)
		
		outline4 = SCNLine(nodeA: SCNVector3(x: 0.5, y: -0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: 0.5, z: 0),color:white)
		outline4.name = "\(panelName).handle.right"
		self.addChildNode(outline4)
		
		cross1 = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.5, y: -0.5, z: 0),color:white)
		cross1.name = "\(panelName).handle.cross1"
		self.addChildNode(cross1)
		
		cross2 = SCNLine(nodeA: SCNVector3(x: 0.5, y: 0.5, z: 0),nodeB: SCNVector3(x: -0.5, y: -0.5, z: 0),color:white)
		cross2.name = "\(panelName).handle.cross2"
		self.addChildNode(cross2)
		
		cross3 = SCNLine(nodeA: SCNVector3(x: 0.5, y: 0, z: 0),nodeB: SCNVector3(x: -0.5, y: 0, z: 0),color:white)
		cross3.name = "\(panelName).handle.cross3"
		self.addChildNode(cross3)
		
		label = SCNLabel(text: name!, scale: 0.1, align: alignment.left)
		label.position = SCNVector3(x: 0.75, y: 0, z: 0)
		
		self.addChildNode(label)
	}
	
	override func touch()
	{
		active = !active
		update()
	}
	
	func update()
	{
		if( !active ){
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
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}