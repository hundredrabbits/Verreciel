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
	func triggerRouter( trigger: String, object: AnyObject)
	{
		NSLog("ACTION | Trigger : %@",trigger)
		NSLog("       | Object  : %@",object.node.name!)
		NSLog("       | Location: %f %f %f",object.node.position.x,object.node.position.y,object.node.position.z)
		
		if( trigger == "move")			{ move(object.node as! SCNLink) }
		if( trigger == "window" )		{ moveWindow(object) }
		if( trigger == "electric" )		{ touchToggle("electric") }
		if( trigger == "thruster" )		{ thruster.touch() }
		if( trigger == "turnRight" )	{ navigation.touch(true) }
		if( trigger == "turnLeft" )		{ navigation.touch(false) }
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
	
	
	func move(object: SCNLink)
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = object.destination
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	// MARK: draws
	
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
	
}