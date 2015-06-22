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
	}
	
	func touchToggle(task:String)
	{
		if( user[task] as! NSObject == 0){
			user[task] = 1
		}
		else{
			user[task] = 0
		}
		updateToggleInterface(task)
		NSLog(" POWER | %@",user["electric"] as! NSObject)
	}
	
	// MARK: draws
	
	func updateToggleInterface(task:String)
	{
		let commanderNode = scene.rootNode.childNodeWithName("trigger.\(task)", recursively: true)!
		
		for node in commanderNode.childNodes
		{
			var node: SCNNode = node as! SCNNode
			if( user[task] as! NSObject == 0){
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
	}
	
}