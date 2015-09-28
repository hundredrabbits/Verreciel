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

class SCNEventNPC : SCNEvent
{
	init(newName: String, location: CGPoint, size: Float, details: String, note: String)
	{
		super.init(newName:"ship1", type:eventTypes.npc)
		
		self.location = location
		self.size = size
		self.details = details
		self.note = note
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		
		start()
	}
	
	override func update()
	{
		if capsule == nil { return }
		
//		location.x += 0.003
		location.y += 0.005
		
		self.position = SCNVector3(location.x,location.y,0)
		
		if distanceBetweenTwoPoints(capsule.location, point2: self.location) > 1.3 {
			self.opacity = 0
		}
		else {
			self.opacity = 1
		}
	}
	
	override func touch()
	{
		radar.addTarget(self)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}