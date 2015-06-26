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
		if( trigger == "speed" )		{ touchIncrementSpeed()}
		if( trigger == "turnRight" )	{ touchTurn(true)}
		if( trigger == "turnLeft" )		{ touchTurn(false)}
	}
	
	func touchTurn(right:Bool)
	{
		if right {
			user.orientation -= 1
		}
		else{
			user.orientation += 1
		}
		panel_radar_update()
	}
	
	func touchIncrementSpeed()
	{
		if( user.speed < 3 ){
			user.speed += 1
		}
		else{
			user.speed = 0
		}
		panel_thruster_update()
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
		panel_thruster_update()
	}
	
}