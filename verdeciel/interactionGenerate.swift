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
				
				var meshName = ""
				
				if(( result.node.name ) != nil){
					NSLog("%@",result.node.name!)
					meshName = result.node.name!
				}
				else{
					NSLog("unnamed")
				}
				
				if( meshName == "link" )
				{
					// highlight it
					SCNTransaction.begin()
					SCNTransaction.setAnimationDuration(3)
					scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = result.node.position
					SCNTransaction.commit()
				}
				
				// get its material
				let material = result.node!.geometry!.firstMaterial!
				
				// highlight it
				SCNTransaction.begin()
				SCNTransaction.setAnimationDuration(0.5)
				
				// on completion - unhighlight
				SCNTransaction.setCompletionBlock {
					SCNTransaction.begin()
					SCNTransaction.setAnimationDuration(0.5)
					
					material.emission.contents = UIColor.blackColor()
					
					SCNTransaction.commit()
				}
				
				material.emission.contents = UIColor.whiteColor()
				
				SCNTransaction.commit()
			}
		}
	}
	
	
}