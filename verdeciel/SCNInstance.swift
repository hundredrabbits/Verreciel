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
	var depth:Float = 0
	
	init(event:SCNEvent)
	{
		super.init()
		self.event = event
		
		depth = 9
		
		self.position = SCNVector3(0,10,0)
		
		self.geometry = SCNSphere(radius: 0.5)
		self.geometry?.firstMaterial?.doubleSided = true
		self.geometry?.firstMaterial?.diffuse.contents = red
		
		print("Begin instance : \(event.name!)")
	}
	
	override func update()
	{
		depth -= thruster.actualSpeed * 0.1
		self.position = SCNVector3(0,depth,0)
		
		if position.y < -9 { leaveInstance() }
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