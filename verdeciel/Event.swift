//  Created by Devine Lu Linvega on 2015-06-26.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Event : Empty
{
	var targetNode:Empty!
	
	var at = CGPoint()
	var details = String()
	var color = grey
	
	var isQuest:Bool = false
	
	init(name:String = "",at:CGPoint = CGPoint(), note:String = "", color:UIColor = grey, isQuest:Bool = false)
	{
		self.isQuest = isQuest

		super.init()
		
		self.name = name
		self.details = note
		self.at = at
		self.color = color
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = red
	}
	
	// MARK: Basic -
	
	override func whenStart()
	{
		super.whenStart()
		
		print("@ EVENT    | \(self.name!)\(self.at)")
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		let trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
	}

	// MARK: Radar -
	
	override func update()
	{
		super.update()
	}
	
	func remove()
	{
		self.removeFromParentNode()
	}
	
	func clean()
	{
	}
	
	func panel() -> Empty!
	{
		return Panel()
	}
	
	// MARK: Debug -
	
	func duplicate() -> Event
	{
		let newEvent = Event()

		newEvent.isQuest = isQuest
	
		newEvent.name = name
		newEvent.details = details
		newEvent.at = at
		newEvent.color = color
		
		return newEvent
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}