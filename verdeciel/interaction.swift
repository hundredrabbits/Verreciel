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

extension GameViewController {
	
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
	{
		let touch = touches.anyObject() as UITouch
		touchOrigin = touch.locationInView(self.view)
	}
	
	override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
	{
		let touch = touches.anyObject() as UITouch
		var touchPosition = touch.locationInView(self.view)
		
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
	
	override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
	{
		
	}
	
	func handleTap(gestureRecognize: UIGestureRecognizer) {
		// retrieve the SCNView
		let scnView = self.view as SCNView
		
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
		
		if(trigger == "move"){
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(3)
			scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = object.node.position
			SCNTransaction.setCompletionBlock({ })
			SCNTransaction.commit()
		}
		if( trigger == "door-vertical" )
		{
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(2)
			object.node.position = SCNVector3(x: 0, y: 400, z: 0)
			SCNTransaction.commit()
		}
		if( trigger == "power" )
		{
			powerToggle()
		}
		if( trigger == "window" )
		{
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(2)
			scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = SCNVector3(x: object.worldCoordinates.x, y: object.worldCoordinates.y, z: object.worldCoordinates.z)
			SCNTransaction.setCompletionBlock({ self.doorClose() })
			SCNTransaction.commit()
		}
		if( trigger == "capsule.radar.mesh" )
		{
//			let cameraNode: AnyObject! = scene.rootNode.childNodeWithName("cameraNode", recursively: true)!
//			
//			// highlight it
//			SCNTransaction.begin()
//			SCNTransaction.setAnimationDuration(2)
//			scene.rootNode.childNodeWithName("interface.navigation", recursively: true)!.rotation = SCNVector4Make(cameraNode.rotation.x, cameraNode.rotation.y, cameraNode.rotation.z, cameraNode.rotation.w)
//			SCNTransaction.commit()
		}
		
	}
	
	func powerToggle()
	{
		if( user["power_active"] as NSObject == 1){
			user["power_active"] = 0
		}
		else{
			user["power_active"] = 1
		}
		
		NSLog("%@",user["power_active"] as NSObject)
	}
	
	func doorClose()
	{
		NSLog("INTERA | Door Close")
		
		// Look in Capsules
		for capsuleNode in scene.rootNode.childNodes {
			let capsuleNode = capsuleNode as SCNNode
			
			if( capsuleNode.name == nil ){ continue }
			
			NSLog("SCAN   | Capsule: %@",capsuleNode.name!)
			
			// Look in Elements
			for elementNode in capsuleNode.childNodes {
				let elementNode = elementNode as SCNNode
				
				if( elementNode.name == nil ){ continue }
				if( elementNode.name != "door.gate" ){ continue }
				
				NSLog("SCAN   | - Element: %@",elementNode.name!)
				
				for triggerNode in elementNode.childNodes {
					let triggerNode = triggerNode as SCNNode
					
					NSLog("%f",triggerNode.position.y)
					
					SCNTransaction.begin()
					SCNTransaction.setAnimationDuration(2)
					triggerNode.position = SCNVector3(x: 0, y: 0, z: 0)
					SCNTransaction.commit()
				}
			}
		}
		
		//
	
	}
	
}