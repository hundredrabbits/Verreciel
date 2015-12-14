
//  Created by Devine Lu Linvega on 2015-12-14.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPortSlot : SCNPort
{
	let label = SCNLabel(text:"hey",scale:0.1,color:white)
	
	override init(host:SCNNode = SCNNode(), position:SCNVector3 = SCNVector3(), input:eventTypes = eventTypes.unknown, output:eventTypes = eventTypes.unknown)
	{
		super.init()
		
		self.input = input
		self.output = output
		
		self.geometry = SCNPlane(width: 0.3, height: 0.3)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
		
		label.position = SCNVector3(0.3,0,0)
		self.addChildNode(label)
		
		self.host = host
		
		setup()
		disable()
	}
	
	override func update()
	{
		
	}
	
	override func onConnect()
	{
		if (origin != nil) { addEvent(syphon()) ; label.update(event.name!) }
	}
	
	override func bang()
	{
		print("Warning! Bang on SCNPortSlot")
	}

	required init(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}
