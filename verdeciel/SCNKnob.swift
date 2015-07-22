//
//  SCNKnob.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNKnob : SCNNode
{
	var knobMesh:SCNNode!
	var panelName:String = ""
	var value:Float = 0
	
	init(newName:String)
	{
		super.init()
		panelName = newName
		addGeometry()
		update()
	}
	
	func addGeometry()
	{
		self.geometry = SCNPlane(width: 1, height: 1)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		self.name = "trigger.\(panelName)"
		
		knobMesh = SCNNode()
		knobMesh.name = "knob.mesh"
		
		// Base
		knobMesh.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.5, z: 0),nodeB: SCNVector3(x: 0.35, y: 0.35, z: 0),color:white))
		knobMesh.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.35, y: 0.35, z: 0),nodeB: SCNVector3(x: 0.5, y: 0, z: 0),color:white))
		knobMesh.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.5, y: 0, z: 0),nodeB: SCNVector3(x: 0.35, y: -0.35, z: 0),color:white))
		knobMesh.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.35, y: -0.35, z: 0),nodeB: SCNVector3(x: 0, y: -0.5, z: 0),color:white))
		knobMesh.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -0.5, z: 0),nodeB: SCNVector3(x: -0.35, y: -0.35, z: 0),color:white))
		knobMesh.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.35, y: -0.35, z: 0),nodeB: SCNVector3(x: -0.5, y: 0, z: 0),color:white))
		knobMesh.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0),nodeB: SCNVector3(x: -0.35, y: 0.35, z: 0),color:white))
		knobMesh.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.35, y: 0.35, z: 0),nodeB: SCNVector3(x: 0, y: 0.5, z: 0),color:white))
		knobMesh.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.15, z: 0),nodeB: SCNVector3(x: 0, y: 0.5, z: 0),color:white))
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.6, z: 0),nodeB: SCNVector3(x: 0, y: 0.7, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -0.6, z: 0),nodeB: SCNVector3(x: 0, y: -0.7, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.6, y: 0, z: 0),nodeB: SCNVector3(x: 0.7, y: 0, z: 0),color:white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.6, y: 0, z: 0),nodeB: SCNVector3(x: -0.7, y: 0, z: 0),color:white))
		
		self.addChildNode(knobMesh)
		self.position = position
	}
	
	func update()
	{
		let targetAngle = Double(value) * -1
		knobMesh.runAction(SCNAction.rotateToAxisAngle(SCNVector4Make(0, 0, 1, Float(M_PI/2 * targetAngle)), duration: 0.7))
		for node in knobMesh.childNodes
		{
			let node: SCNNode = node as! SCNNode
			if( value == 0){
				node.geometry!.firstMaterial?.diffuse.contents = red
			}
			else{
				node.geometry!.firstMaterial?.diffuse.contents = cyan
			}
		}
	}
	
	func touch()
	{
		value = value > 3 ? 0 : value + 1
		update()
		radio.update()
		thruster.update()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}