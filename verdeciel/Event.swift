//  Created by Devine Lu Linvega on 2015-06-26.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Event : SCNNode
{
	var targetNode:SCNNode!
	
	var at = CGPoint()
	var note = String()
	var content:Array<Item>!
	var color = grey
	
	var isQuest:Bool = false
	
	init(name:String = "",at:CGPoint = CGPoint(), note:String = "", color:UIColor = grey, isQuest:Bool = false)
	{
		self.content = []
		self.isQuest = isQuest

		super.init()
		
		self.name = name
		self.note = note
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
	}
	
	func remove()
	{
		self.removeFromParentNode()
	}
	
	func clean()
	{
	}
	
	func panel() -> SCNNode!
	{
		return Panel()
	}
	
	// MARK: Debug -
	
	func duplicate() -> Event
	{
		let newEvent = Event()
		
		newEvent.content = content
		newEvent.isQuest = isQuest
	
		newEvent.name = name
		newEvent.note = note
		newEvent.at = at
		newEvent.color = color
		
		return newEvent
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}