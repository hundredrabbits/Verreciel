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
		if( trigger == "oxygen" )		{ breaker.touch(trigger) }
		if( trigger == "electric" )		{ breaker.touch(trigger) }
	}	
	
	func move(object: SCNLink)
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = object.destination
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
}