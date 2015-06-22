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
	
	// MARK: Move
	
	func move(object: AnyObject)
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = object.node.position
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
//		fogCapsule()
	}
	func moveWindow(object: AnyObject)
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = SCNVector3(x: object.worldCoordinates.x, y: object.worldCoordinates.y, z: object.worldCoordinates.z)
//		SCNTransaction.setCompletionBlock({ self.doorClose() })
		SCNTransaction.commit()
//		fogEvent()
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
	
}