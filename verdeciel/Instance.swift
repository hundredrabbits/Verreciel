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
	}
	
	override func update()
	{
		let distance = (event.distance/2) * 100.0
		
		mesh.position = SCNVector3(0,distance,0)
		
		if capsule.isDockedAtLocation(event){
			self.eulerAngles.z = Float(degToRad(0))
		}
		else{
			self.eulerAngles.z = Float(degToRad(event.align))
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