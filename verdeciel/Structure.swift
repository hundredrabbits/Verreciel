//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Structure : SCNNode
{
	let root = SCNNode()
	var host:Location! = nil
	
	init(host:Location)
	{
		super.init()
		
		self.host = host
		
		addChildNode(root)
	}
	
	override func whenRenderer()
	{
		let distance = (host is LocationConstellation) ? host.distance/settings.approach * 100 : pow(host.distance/settings.approach, 5) * 1000.0
		
		self.position = SCNVector3(0,distance,0)
		
		if capsule.isDockedAtLocation(host){
			self.eulerAngles.z = (degToRad(0))
		}
		else if capsule.lastLocation == host {
			self.eulerAngles.z = (degToRad(0))
			self.position = SCNVector3(0,distance * -1,0)
		}
		else{
			self.eulerAngles.z = (degToRad(host.align))
		}
		
		self.eulerAngles.y = (degToRad(capsule.direction))
		
		if host.distance > settings.approach {
			leaveInstance()
		}
	}
	
	func leaveInstance()
	{
		print("> INSTANCE | Leaving \(host.name!)")
		self.removeFromParentNode()
	}
	
	var morphTime:Int = 0
	var morphTimer:NSTimer!
	
	func onDock()
	{
		morph()
	}
	
	func onSight()
	{
		
	}
	
	func onUndock()
	{
		
	}
	
	func onComplete()
	{
	
	}
	
	func dockUpdate()
	{
	
	}
	
	func sightUpdate()
	{
	
	}
	
	func morph()
	{
		morphTime += 1
		if capsule.isDocked == true {
			delay(2, block: { self.morph() })
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}