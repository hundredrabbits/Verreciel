//
//  triggers.swift
//  verdeciel
//
//  Created by Devine Lu Linvega on 2014-09-25.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension GameViewController
{
	func triggerRouter( trigger: NSString, object: AnyObject)
	{
		NSLog("ACTION | Trigger : %@",trigger)
		NSLog("       | Object  : %@",object.node.name!)
		NSLog("       | Location: %f %f %f",object.node.position.x,object.node.position.y,object.node.position.z)
		
		if( trigger == "move")			{ move(object) }
		if( trigger == "window" )		{ moveWindow(object)}
		if( trigger == "electric" )		{ touchToggle("electric")}
		if( trigger == "thruster" )		{ touchToggle("thruster")}
		if( trigger == "speed" )		{ touchIncrement("speed",limit: 3)}
	}
	
	func touchIncrement(task:String,limit:Float)
	{
		var userTask = user.storage[task]
		
		if( user.storage[task] < limit ){
			user.storage[task] = userTask! + 1
		}
		else{
			user.storage[task] = 0
		}
		updateKnobInterface(task,limit:limit)
	}
	
	func touchToggle(task:String)
	{
		if( user.storage[task] == 0){
			user.storage[task] = 1
		}
		else{
			user.storage[task] = 0
		}
		updateToggleInterface(task)
	}
	
	// MARK: draws
	
	func updateKnobInterface(task:String,limit:Float)
	{
		let interfaceNode = scene.rootNode.childNodeWithName("trigger.\(task)", recursively: true)!
		
		let knobMesh = interfaceNode.childNodeWithName("knob.mesh", recursively: false)!
		
		let targetAngle = Double(user.storage[task]!) * -1
		
		knobMesh.runAction(SCNAction.rotateToAxisAngle(SCNVector4Make(0, 0, 1, Float(M_PI/2 * targetAngle)), duration: 0.7))
		
		for node in knobMesh.childNodes
		{
			var node: SCNNode = node as! SCNNode
			if( user.storage[task] == 0){
				node.geometry!.firstMaterial?.diffuse.contents = red
			}
			else{
				node.geometry!.firstMaterial?.diffuse.contents = cyan
			}
		}
		
		// Update label
		
		let labelUnwrap = Int(user.storage[task]!)
		
		let labelString = "\(labelUnwrap)"
		
		let labelNode = interfaceNode.childNodeWithName("label", recursively: false)!
		let labelMesh = SCNText(string: labelString, extrusionDepth: 0.0)
		labelMesh.font = UIFont(name: "CourierNewPSMT", size: 12)
		
		labelNode.geometry = labelMesh
	}
	
	func updateToggleInterface(task:String)
	{
		let commanderNode = scene.rootNode.childNodeWithName("trigger.\(task)", recursively: true)!
		
		for node in commanderNode.childNodes
		{
			var node: SCNNode = node as! SCNNode
			if( user.storage[task] == 0){
				node.geometry!.firstMaterial?.diffuse.contents = red
				if node.name == "\(task).handle.cross3" { node.geometry!.firstMaterial?.diffuse.contents = clear }
			}
			else{
				node.geometry!.firstMaterial?.diffuse.contents = cyan
				if node.name == "\(task).handle.cross2" { node.geometry!.firstMaterial?.diffuse.contents = clear }
				if node.name == "\(task).handle.cross1" { node.geometry!.firstMaterial?.diffuse.contents = clear }
			}
		}
	}
	
	func triggersSetup()
	{
		updateToggleInterface("electric")
		updateToggleInterface("thruster")
		updateKnobInterface("speed",limit:3)
	}
	
}