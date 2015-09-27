//
//  SCNCommand.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNInstance : SCNNode
{
	var event:SCNEvent!
	var mesh:SCNNode!
	
	init(event:SCNEvent)
	{
		super.init()
		self.event = event
		
		// Mesh
		
		mesh = SCNNode()
		addMesh()
		self.addChildNode(mesh)
		
		print("Begin instance : \(event.name!)")
	}
	
	func addMesh()
	{
		var i = 0
		while i < 4 {
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(-3,i,0), nodeB: SCNVector3(0,i,3), color: red))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,i,3), nodeB: SCNVector3(3,i,0), color: red))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(3,i,0), nodeB: SCNVector3(0,i,-3), color: red))
			mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,i,-3), nodeB: SCNVector3(-3,i,0), color: red))
			i += 1
		}
	}
	
	override func update()
	{
		let distance = event.distanceFromCapsule * 15.0
		
		let newAngle = degToRad(abs(event.alignmentWithCapsule))
		
		let flattenedDistance = CGFloat(cos(newAngle)) * distance // important
		
		if event.alignmentWithCapsule >= 90 {
			self.position = SCNVector3(0,abs(flattenedDistance) * -1,0)
		}
		else{
			self.position = SCNVector3(0,abs(flattenedDistance),0)
		}
		
		if event.distanceFromCapsule > 0.75 {
			leaveInstance()
		}
	}
	
	func leaveInstance()
	{
		print("Leaving instance: \(self.event.name!)")
		capsule.instance = nil
		self.removeFromParentNode()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}