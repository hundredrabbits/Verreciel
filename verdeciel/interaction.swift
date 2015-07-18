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
			
			if hitResults.count < 1 { return }
			
			let result: AnyObject! = hitResults[0]
			
			if result.node.isKindOfClass(SCNKnob) {
				let knob = result.node as! SCNKnob
				knob.touch()
			}
			else if result.node.isKindOfClass(SCNToggle) {
				let toggle = result.node as! SCNToggle
				toggle.touch()
			}
			else if result.node.isKindOfClass(SCNArrow) {
				let arrow = result.node as! SCNArrow
				arrow.touch()
			}
			else{
				println(result)
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
	
	func moveWindow(object: AnyObject)
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = SCNVector3(x: object.worldCoordinates.x, y: object.worldCoordinates.y, z: object.worldCoordinates.z)
		SCNTransaction.commit()
	}	
}