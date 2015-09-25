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

class SCNStructure : SCNNode
{
	var event:SCNEvent!
	
	init(event:SCNEvent)
	{
		super.init()
		self.event = event
		
		self.geometry = SCNSphere(radius: 0.5)
		self.geometry?.firstMaterial?.doubleSided = true
		self.geometry?.firstMaterial?.diffuse.contents = red
	}
	
	override func update()
	{
		if event.name == nil { return }
		if event.angleFromCapsule >= 180 {
			self.position = SCNVector3(event.angleFromCapsule * 0.001,event.distanceFromCapsule * -20,0)
		}
		else{
			self.position = SCNVector3(0,event.distanceFromCapsule * 20,0)
		}
		
		print("Approaching \(event.name!) at \(event.angleFromCapsule)")
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}