//
//  CameraNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//
import UIKit
import QuartzCore
import SceneKit
import Foundation

class CameraNode : SCNNode
{
	var displayHealth:SCNLabel!
	var displayMisc:SCNLabel!
	
	override init()
	{
		super.init()
	
		// Camera
		self.camera = SCNCamera()
		self.camera?.xFov = 75
		self.name = "cameraNode"
		self.position = SCNVector3(x: 0, y: 0, z: 0)
		self.camera?.aperture = 100
		self.camera?.automaticallyAdjustsZRange = true
		
		addInterface()
		addHelmet()
	}
	
	func addHelmet()
	{
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: -0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: 0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: 0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: -0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
		
		
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: -0.25, y: 0.95, z: -1.01), nodeB: SCNVector3(x: 0.25, y: 0.95, z: -1.01), color: grey) )
	}
	
	func addInterface()
	{
		displayHealth = SCNLabel(text: "99hp", scale: 0.05, align: alignment.left)
		displayHealth.position = SCNVector3(x: -0.7, y: -1, z: -1.01)
		displayHealth.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(displayHealth)
		
		displayMisc = SCNLabel(text: "34mp", scale: 0.05, align: alignment.right)
		displayMisc.position = SCNVector3(x: 0.7, y: -1, z: -1.01)
		displayMisc.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(displayMisc)
	}
	
	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
}