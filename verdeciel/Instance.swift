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
		let distance = (event is LocationConstellation) ? event.distance/settings.approach * 100 : pow(event.distance/settings.approach, 5) * 1000.0
	
		structure.position = SCNVector3(0,distance,0)
		
		if capsule.isDockedAtLocation(event){
			self.eulerAngles.z = (degToRad(0))
		}
		else if capsule.lastLocation == event {
			self.eulerAngles.z = (degToRad(0))
			structure.position = SCNVector3(0,distance * -1,0)
		}
		else{
			self.eulerAngles.z = (degToRad(event.align))
		}
		
		self.eulerAngles.y = (degToRad(capsule.direction))
		
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