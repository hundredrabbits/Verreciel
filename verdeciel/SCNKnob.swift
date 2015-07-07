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
	
	init(newName:String,position:SCNVector3)
	{
		super.init()
		name = newName
		addGeometry()
	}
	
	func addGeometry()
	{
		var knob = SCNNode(geometry: SCNPlane(width: 1, height: 1))
		knob.geometry?.firstMaterial?.diffuse.contents = clear
		knob.position = position
		knob.name = "trigger.thruster"
		
		knobMesh = SCNNode()
		knobMesh.name = "knob.mesh"
		
		// Base
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0, y: 0.5, z: 0),SCNVector3(x: 0.35, y: 0.35, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0.35, y: 0.35, z: 0),SCNVector3(x: 0.5, y: 0, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0.5, y: 0, z: 0),SCNVector3(x: 0.35, y: -0.35, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0.35, y: -0.35, z: 0),SCNVector3(x: 0, y: -0.5, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0, y: -0.5, z: 0),SCNVector3(x: -0.35, y: -0.35, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: -0.35, y: -0.35, z: 0),SCNVector3(x: -0.5, y: 0, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: -0.5, y: 0, z: 0),SCNVector3(x: -0.35, y: 0.35, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: -0.35, y: 0.35, z: 0),SCNVector3(x: 0, y: 0.5, z: 0)))
		knobMesh.addChildNode(cyanLine(SCNVector3(x: 0, y: 0.15, z: 0),SCNVector3(x: 0, y: 0.5, z: 0)))
		
		knob.addChildNode(line(SCNVector3(x: 0, y: 0.6, z: 0),SCNVector3(x: 0, y: 0.7, z: 0)))
		knob.addChildNode(line(SCNVector3(x: 0, y: -0.6, z: 0),SCNVector3(x: 0, y: -0.7, z: 0)))
		knob.addChildNode(line(SCNVector3(x: 0.6, y: 0, z: 0),SCNVector3(x: 0.7, y: 0, z: 0)))
		knob.addChildNode(line(SCNVector3(x: -0.6, y: 0, z: 0),SCNVector3(x: -0.7, y: 0, z: 0)))
		
		knob.addChildNode(knobMesh)
		knob.position = position
		
		self.addChildNode(knob)
	}
	
	func update()
	{
		let targetAngle = Double(user.speed) * -1
		knobMesh.runAction(SCNAction.rotateToAxisAngle(SCNVector4Make(0, 0, 1, Float(M_PI/2 * targetAngle)), duration: 0.7))
		for node in knobMesh.childNodes
		{
			var node: SCNNode = node as! SCNNode
			if( user.speed == 0){
				node.geometry!.firstMaterial?.diffuse.contents = red
			}
			else{
				node.geometry!.firstMaterial?.diffuse.contents = cyan
			}
		}
		//		let labelNode = panelNode.childNodeWithName("label.speed", recursively: true)! as! SCNLabel
		//		labelNode.update(String(Int(user.speed)))
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}