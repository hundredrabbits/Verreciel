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
		print("added")
		super.init(newName:"ship1", type:eventTypes.npc)
		
		self.location = location
		self.size = size
		self.details = details
		self.note = note
		
		createSprite()
		addTrigger()
	}
	
	override func createSprite()
	{
		let displaySize = self.size/10
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:displaySize,z:0),nodeB: SCNVector3(x:displaySize,y:0,z:0),color: white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:-displaySize,y:0,z:0),nodeB: SCNVector3(x:0,y:-displaySize,z:0),color: white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:displaySize,z:0),nodeB: SCNVector3(x:-displaySize,y:0,z:0),color: white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:displaySize,y:0,z:0),nodeB: SCNVector3(x:0,y:-displaySize,z:0),color: white))
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:displaySize,y:0,z:0),nodeB: SCNVector3(x:-displaySize,y:0,z:0),color: white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:displaySize,z:0),nodeB: SCNVector3(x:0,y:-displaySize,z:0),color: white))
	}
	
	override func addTrigger()
	{
		let displaySize:CGFloat = CGFloat(self.size/2.5)
		
		self.geometry = SCNPlane(width: displaySize, height: displaySize)
		self.geometry?.firstMaterial?.diffuse.contents = clear
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