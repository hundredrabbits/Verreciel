//
//  SCNRadarEvent.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-26.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Event : SCNNode
{
	var targetNode:SCNNode!
	
	var at = CGPoint()
	var size:Float = 1
	var type:eventTypes!
	var details:eventDetails
	var note = String()
	var content:Array<Event>!
	var color = grey
	
	var trigger = SCNNode()
	var wire:SCNLine!
	var connection:Event!
	
	var isQuest:Bool = false
	
	init(newName:String = "",at:CGPoint = CGPoint(),size:Float = 1,type:eventTypes = eventTypes.unknown,details:eventDetails = eventDetails.unknown, note:String = "", color:UIColor = grey, isQuest:Bool = false)
	{
		self.content = []
		self.details = details
		self.isQuest = isQuest

		super.init()
		
		self.name = newName
		self.type = type
		self.size = size
		self.note = note
		self.at = at
		self.color = color
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = red
		
		wire = SCNLine()
		wire.position = SCNVector3(0,0,-0.01)
		wire.opacity = 0
		self.addChildNode(wire)
	}
	
	// MARK: Basic -
	
	override func start()
	{
		print("@ EVENT    | \(self.name!)\(self.at)")
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		let trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
	}

	// MARK: Radar -
	
	func connect(event:Event)
	{
		connection = event
		self.wire.draw(SCNVector3(0,0,0), nodeB: SCNVector3( (connection.at.x - self.at.x),(connection.at.y - self.at.y),0), color: grey)
	}
	
	func remove()
	{
		self.removeFromParentNode()
	}
	
	func clean()
	{
		if self.size == 0 {
			self.removeFromParentNode()
		}
	}
	
	func panel() -> SCNNode
	{
		return Panel()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}