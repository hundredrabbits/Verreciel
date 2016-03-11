//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Instance : SCNNode
{
	var event:Location!
	var structure:SCNNode!
	
	init(event:Location)
	{
		super.init()
		self.event = event
		
		structure = event.structure
		self.addChildNode(structure)
		
		print("> INSTANCE | Begin \(event.name!)")
	}
	
	override func update()
	{
		let distance = pow(event.distance/settings.approach, 3) * 100.0
	
		structure.position = SCNVector3(0,distance,0)
		
		if capsule.isDockedAtLocation(event){
			self.eulerAngles.z = Float(degToRad(0))
		}
		else{
			self.eulerAngles.z = Float(degToRad(event.align))
		}
		
		self.eulerAngles.y = Float(degToRad(capsule.direction))
		
		if event.distance > settings.approach {
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