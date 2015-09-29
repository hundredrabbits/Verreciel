//
//  displayNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNLink : SCNNode
{
	var activeLocation:SCNVector3!
	var destination:SCNVector3!
	
	init(location:SCNVector3,newDestination:SCNVector3,scale:CGFloat)
	{
		super.init()
		
		activeLocation = location
		destination = newDestination
		
		self.geometry = SCNNode(geometry: SCNPlane(width: scale, height: scale)).geometry
		
		self.position = activeLocation
		self.geometry?.firstMaterial?.diffuse.contents = clear
	}
	
	override func touch()
	{
		/*
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(1.5)
		scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.orientation = self.orientation
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		scene.rootNode.childNodeWithName("cameraNode", recursively: true)!.position = self.destination
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
*/
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}