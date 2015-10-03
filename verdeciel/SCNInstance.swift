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
	var event:Event!
	
	init(event:Event)
	{
		super.init()
		self.event = event
		
		self.addChildNode(event.mesh())
		print("> INSTANCE | Begin \(event.name!)")

		self.update()
	}
	
	override func update()
	{
		let distance = event.distance * 15.0
		
		let newAngle = degToRad(abs(event.align))
		
		let flattenedDistance = CGFloat(cos(newAngle)) * distance // important
		
		if event.align >= 90 {
			self.position = SCNVector3(0,abs(flattenedDistance) * -1,0)
		}
		else{
			self.position = SCNVector3(0,abs(flattenedDistance),0)
		}
		
		if event.distance > 0.75 {
			leaveInstance()
		}
	}
	
	func leaveInstance()
	{
		print("> INSTANCE | Leaving \(event.name!)")
		capsule.instance = nil
		self.removeFromParentNode()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}