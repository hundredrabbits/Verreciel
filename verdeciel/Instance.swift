//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Instance : SCNNode
{
	var event:Location!
	var mesh:SCNNode!
	
	init(event:Location)
	{
		super.init()
		self.event = event
		
		mesh = event.mesh
		self.addChildNode(mesh)
		
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
		
		event.animateMesh(mesh)
		
		if distance > 6 {
			let normalized = distance - 6
			let someVal = (1 - (normalized/1.5))
			self.opacity = someVal
		}
		else{
			self.opacity = 1
		}
		
		if event.distance > 0.75 {
			leaveInstance()
		}
	}
	
	func leaveInstance()
	{
		print("> INSTANCE | Leaving \(event.name!)")
		self.removeFromParentNode()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}