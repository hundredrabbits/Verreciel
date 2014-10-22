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
	
	func triggerRouter( method: NSString, object: AnyObject)
	{
		NSLog("ACTION | Trigger: %@",method)
		
		if(method == "move"){
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(3)
			scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = object.node.position
			SCNTransaction.setCompletionBlock({
				self.doorClose()
			})
			SCNTransaction.commit()
		}
		if( method == "door-vertical" )
		{
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(2)
			object.node.position = SCNVector3(x: 0, y: 0, z: -350)
			SCNTransaction.commit()
		}
		if( method == "window" )
		{
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(2)
			scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = SCNVector3(x: object.worldCoordinates.x, y: object.worldCoordinates.y, z: object.worldCoordinates.z)
			SCNTransaction.commit()
		}
		if( method == "capsule.radar.mesh" )
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
	
	func doorClose()
	{
		NSLog("INTERA | Door Close")
		
		for capsule in scene.rootNode.childNodes {
			let capsuleParent = capsule as SCNNode
			
				
			for element in capsuleParent.childNodes {
				let elementNode = element as SCNNode
				
				if(( elementNode.name ) != nil){
					NSLog("%@",elementNode.name!)
				}
			}
			
		}
	
	}
	
}