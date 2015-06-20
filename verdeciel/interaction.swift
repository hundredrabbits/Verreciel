//
//  interactionGenerate.swift
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
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
	{
		for touch: AnyObject in touches {
			touchOrigin = touch.locationInView(self.view)
		}
	}
	
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
	{
		var touchPosition = CGPoint()
		for touch: AnyObject in touches {
			touchPosition = touch.locationInView(self.view)
		}
		
		println(touchPosition)
		
		var dragX = Float(touchPosition.x - touchOrigin.x)
		var dragY = Float(touchPosition.y - touchOrigin.y)
		
		touchOrigin = touchPosition
		
		let xAngle = SCNMatrix4MakeRotation(degToRad(dragY/4), 1, 0, 0)
		let yAngle = SCNMatrix4MakeRotation(degToRad(dragX/5), 0, 1, 0)
		let zAngle = SCNMatrix4MakeRotation(degToRad(0), 0, 0, 1)
		
		var rotationMatrix = SCNMatrix4Mult(SCNMatrix4Mult(xAngle, yAngle), zAngle)
		var cameraNode = scene.rootNode.childNodeWithName("cameraNode", recursively: true)!
		cameraNode.transform = SCNMatrix4Mult(rotationMatrix, cameraNode.transform )
	}
	
	func handleTap(gestureRecognize: UIGestureRecognizer) {
		// retrieve the SCNView
		let scnView = self.view as! SCNView
		
		// check what nodes are tapped
		let p = gestureRecognize.locationInView(scnView)
		if let hitResults = scnView.hitTest(p, options: nil) {
			// check that we clicked on at least one object
			if hitResults.count > 0 {
				// retrieved the first clicked object
				let result: AnyObject! = hitResults[0]
				
				if( result.node.name!.rangeOfString(".") == nil ){
					NSLog("SYSTEM | Trigger: not action")
					return
				}
				
				let prefix = result.node.name!.componentsSeparatedByString(".")[0]
				let sufix  = result.node.name!.componentsSeparatedByString(".")[1]
				
				if( prefix == "trigger" )
				{
					triggerRouter(sufix,object: result)
				}
			}
		}
	}
	
	func triggerRouter( trigger: NSString, object: AnyObject)
	{
		NSLog("ACTION | Trigger : %@",trigger)
		NSLog("       | Object  : %@",object.node.name!)
		NSLog("       | Location: %f %f %f",object.node.position.x,object.node.position.y,object.node.position.z)
		
		if( trigger == "move")			{ move(object) }
		if( trigger == "window" )		{ moveWindow(object)}
		
		if( trigger == "door-vertical" ){ doorOpen(object) }
		if( trigger == "airlock" )		{ doorAirlock(object) }
		
		if( trigger == "power" )		{ powerToggle()	}
		if( trigger == "speed" )		{ speedToggle()	}
	}
	
	// MARK: Fog
	
	func fogEvent()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		scene.fogStartDistance = 0
		scene.fogEndDistance = 5000
		scene.fogDensityExponent = 4
		scene.fogColor = UIColor.redColor()
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	func fogCapsule()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		scene.fogStartDistance = 0
		scene.fogEndDistance = 17
		scene.fogDensityExponent = 4
		scene.fogColor = UIColor.blackColor()
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	// MARK: Controls
	
	func speedToggle()
	{
		user["speed"] = user["speed"]as! Int + 1
		if( user["speed"] as! Int > 3 ){
			user["speed"] = 1
		}
		NSLog("USER   | Speed: %@",user["airlock"] as! NSObject)
	}
	
	func powerToggle()
	{
		if( user["power"] as! NSObject == 0){
			user["power"] = 1
			scene.rootNode.childNodeWithName("power.handle", recursively: true)!.runAction(SCNAction.rotateToX(0, y: -1.35, z: 0, duration: 1))
		}
		else{
			user["power"] = 0
			scene.rootNode.childNodeWithName("power.handle", recursively: true)!.runAction(SCNAction.rotateToX(0, y: 0, z: 0, duration: 1))
		}
		scene.rootNode.childNodeWithName("mainCapsule", recursively: true)!.geometry?.firstMaterial?.emission.contents = UIColor.redColor()
		NSLog("%@",user["power"] as! NSObject)
	}
	
	// MARK: Move
	
	func move(object: AnyObject)
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = object.node.position
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		fogCapsule()
	}
	func moveWindow(object: AnyObject)
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = SCNVector3(x: object.worldCoordinates.x, y: object.worldCoordinates.y, z: object.worldCoordinates.z)
		SCNTransaction.setCompletionBlock({ self.doorClose() })
		SCNTransaction.commit()
		fogEvent()
	}
	
	// MARK: Doors
	
	func doorAirlock(object: AnyObject)
	{
		if( user["airlock"] as! Int > 2 ){
			object.node.runAction(SCNAction.moveByX(0, y: 300, z: 0, duration: 4))
			object.node.runAction(SCNAction.rotateByX(0, y: 2, z: 3, duration: 4))
		}
		else{
			user["airlock"] = user["airlock"] as! Int + 1
			object.node.runAction(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1))
		}
		NSLog("USER   | Airlock: %@",user["airlock"] as! NSObject)
	}
	
	func doorOpen(object: AnyObject)
	{
		if( user["power"] as! Int == 0 ){
			return
		}
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		object.node.position = SCNVector3(x: 0, y: 400, z: 0)
		SCNTransaction.commit()
	}
	
	func doorClose()
	{
		if( user["power"] as! Int == 0 ){
			return
		}
		
		NSLog("INTERA | Door Close")
		
		// Look in Capsules
		for capsuleNode in scene.rootNode.childNodes {
			let capsuleNode = capsuleNode as! SCNNode
			
			if( capsuleNode.name == nil ){ continue }
			
			NSLog("SCAN   | Capsule: %@",capsuleNode.name!)
			
			// Look in Elements
			for elementNode in capsuleNode.childNodes {
				let elementNode = elementNode as! SCNNode
				
				if( elementNode.name == nil ){ continue }
				if( elementNode.name != "door.gate" ){ continue }
				
				NSLog("SCAN   | - Element: %@",elementNode.name!)
				
				for triggerNode in elementNode.childNodes {
					let triggerNode = triggerNode as! SCNNode
					
					NSLog("%f",triggerNode.position.y)
					
					SCNTransaction.begin()
					SCNTransaction.setAnimationDuration(2)
					triggerNode.position = SCNVector3(x: 0, y: 0, z: 0)
					SCNTransaction.commit()
				}
			}
		}
	}
}