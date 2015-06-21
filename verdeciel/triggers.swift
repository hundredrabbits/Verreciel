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
		if( trigger == "power" )		{ powerToggle()	}
	}
	
	func powerToggle()
	{
		if( user["power"] as! NSObject == 0){
			user["power"] = 1
		}
		else{
			user["power"] = 0
		}
		drawPowerInterface()
		NSLog(" POWER | %@",user["power"] as! NSObject)
	}
	
	// MARK: draws
	
	func drawPowerInterface()
	{
		let commanderNode = scene.rootNode.childNodeWithName("trigger.power", recursively: true)!
		
		for node in commanderNode.childNodes
		{
			var node: SCNNode = node as! SCNNode
			if( user["power"] as! NSObject == 0){
				node.geometry!.firstMaterial?.diffuse.contents = red
				if node.name == "power.handle.cross3" { node.geometry!.firstMaterial?.diffuse.contents = clear }
			}
			else{
				node.geometry!.firstMaterial?.diffuse.contents = cyan
				if node.name == "power.handle.cross2" { node.geometry!.firstMaterial?.diffuse.contents = clear }
				if node.name == "power.handle.cross1" { node.geometry!.firstMaterial?.diffuse.contents = clear }
			}
		}
	}
	
	func triggersSetup()
	{
		drawPowerInterface()
	}
	
}