//
//  interfaces.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension GameViewController
{
	// MARK: Interfaces
	
	func toggle(name:String,position:SCNVector3) -> SCNNode
	{
		// Draw interaction plane
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
		
		let lineTest7 = redLine(SCNVector3(x: 0.5, y: 0, z: 0),SCNVector3(x: -0.5, y: 0, z: 0))
		lineTest7.name = "\(name).handle.cross3"
		optionPanel.addChildNode(lineTest7)
		
		let text2 = SCNText(string: name, extrusionDepth: 0.0)
		text2.font = UIFont(name: "CourierNewPSMT", size: 14)
		let node3 = SCNNode(geometry: text2)
		node3.position = SCNVector3(x: -0.5, y: -1, z: 0)
		node3.scale = SCNVector3(x:0.02,y:0.02,z:0.02)
		optionPanel.addChildNode(node3)
		
		let text3 = SCNText(string: "0.5", extrusionDepth: 0.0)
		text3.font = UIFont(name: "CourierNewPSMT", size: 14)
		let node4 = SCNNode(geometry: text3)
		node4.position = SCNVector3(x: -0.5, y: -1.25, z: 0)
		node4.scale = SCNVector3(x:0.02,y:0.02,z:0.02)
		optionPanel.addChildNode(node4)
		
		return optionPanel
	}
	
	func knob(name:String,position:SCNVector3) -> SCNNode
	{
		var knob = SCNNode(geometry: SCNPlane(width: 1, height: 1))
		knob.geometry?.firstMaterial?.diffuse.contents = clear
		knob.position = position
		knob.name = "trigger.\(name)"
		
		var knobMesh = SCNNode()
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
		
		// Top
		knob.position = position
		
		knob.addChildNode(label("label", text: "-", position: SCNVector3(x: 0.1, y: -0.75, z: 0), color: grey))
		
		var testLabel = SCNLabel(text: name, scale: 0.05)
		testLabel.position = SCNVector3(x: 0.1, y: 0.65, z: 0)
		
		knob.addChildNode(testLabel)
		
		return knob
	}
	
	func label(name:String,text:String, position:SCNVector3,color:UIColor) -> SCNNode
	{
		var labelNode = SCNNode()
	
		let interfaceLabelMesh = SCNText(string: text.uppercaseString, extrusionDepth: 0.0)
		interfaceLabelMesh.font = UIFont(name: "CourierNewPSMT", size: 12)
		
		labelNode = SCNNode(geometry: interfaceLabelMesh)
		labelNode.name = name
		labelNode.scale = SCNVector3(x:0.015,y:0.015,z:0.015)
		labelNode.position = position
		labelNode.geometry!.firstMaterial?.diffuse.contents = color
		
		return labelNode
	}
	
}