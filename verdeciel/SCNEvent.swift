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

class SCNEvent : SCNNode
{
	var isKnown:Bool = false
	var isTargetted:Bool = false
	
	var targetNode:SCNNode!
	
	var location = CGPoint()
	var size:Float = 1
	var type:eventTypes!
	var details:String
	var note = String()
	var content:Array<SCNEvent>!
	
	var angleWithCapsule:CGFloat!
	var alignmentWithCapsule:CGFloat!
	var distanceFromCapsule:CGFloat!
	var isVisible:Bool = false
	
	var sprite = SCNNode()
	var trigger = SCNNode()
	
	init(newName:String = "",location:CGPoint = CGPoint(),size:Float = 1,type:eventTypes,details:String = "", note:String = "")
	{
		self.content = []
		self.details = details

		super.init()
		
		self.name = newName
		self.type = type
		self.size = size
		self.note = note
		self.location = location
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		
		start()
	}
	
	func start()
	{
		print("+ EVENT(\(self.name!) @\(self.location))")
		
		self.sprite  = createSprite()
		self.trigger = createTrigger()
		
//		update()
	}
	
	override func update()
	{
		if capsule == nil { return }
		
		position = SCNVector3(location.x,location.y,0)
		distanceFromCapsule = distanceBetweenTwoPoints(capsule.location, point2: self.location)
		
		angleWithCapsule = calculateAngle()
		alignmentWithCapsule = calculateAlignment()
		
		// Discover
		if self.isKnown == false && distanceFromCapsule < 0.3 {
			discover()
		}
		
		// Collide
		if distanceFromCapsule < 0.1 {
			collide()
		}
//		print("Distance: \(distanceFromCapsule) - \(capsule.location) / \(self.location)")
		
		// Approach
		if distanceFromCapsule < 0.75 && capsule.instance == nil {
			approach()
		}
		
		radarCulling()
		
		clean()
	}
	
	func createSprite() -> SCNNode
	{
		let size = self.size/10
		
		let spriteNode = SCNNode()
		
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: grey))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: grey))
		spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
		
		return spriteNode
	}
	
	func createTrigger() -> SCNNode
	{
		let size = CGFloat(self.size/2.5)
		
		let triggerNode = SCNNode()
		
		self.geometry = SCNPlane(width: size, height: size)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		return triggerNode
	}
	
	func discover()
	{
		isKnown = true
		self.color(white)
	}
	
	func collide()
	{
		
	}
	
	func approach()
	{
//		capsule.instance = self
//		space.startInstance(self)
	}
	
	func radarCulling()
	{
		if distanceFromCapsule < 1.3 {
			self.opacity = 1
		}
		else {
			self.opacity = 0
		}
	}
	
	func clean()
	{
		if self.size < 1 {
			print("Removed event \(self.name!) -> \(self.size)")
			self.removeFromParentNode()
		}
	}
	
	func color(targetColor:UIColor)
	{
		for node in sprite.childNodes
		{
			let line = node as! SCNLine
			line.color(targetColor)
		}
	}
	
	func calculateAngle() -> CGFloat
	{
		let p1 = capsule.location
		let p2 = self.location
		let center = capsule.location
		
		let v1 = CGVector(dx: p1.x - center.x, dy: p1.y - center.y)
		let v2 = CGVector(dx: p2.x - center.x, dy: p2.y - center.y)
		
		let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
		
		return (360 - (radToDeg(angle) - 90)) % 360
	}
	
	func calculateAlignment() -> CGFloat
	{
		var diff = max(capsule.direction, self.angleWithCapsule) - min(capsule.direction, self.angleWithCapsule)
		if (diff > 180){ diff = 360 - diff }
		
		return diff
	}
	
	func mesh() -> SCNNode
	{
		return SCNNode()
	}
	
	override func touch()
	{
		radar.addTarget(self)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}