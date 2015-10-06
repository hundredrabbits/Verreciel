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
	
	var location = CGPoint()
	var size:Float = 1
	var type:eventTypes!
	var details:String
	var note = String()
	var content:Array<Event>!
	var color = grey
	
	var angle:CGFloat!
	var align:CGFloat!
	var distance:CGFloat!
	
	var inCollision:Bool = false
	var inApproach:Bool = false
	var inDiscovery:Bool = false
	var inSight:Bool = false
	
	var isVisible:Bool = false
	var isKnown:Bool = false
	var isTargetted:Bool = false
	
	var sprite = SCNNode()
	var trigger = SCNNode()
	var connection = SCNNode()
	
	var targetter = SCNNode()
	
	init(newName:String = "",location:CGPoint = CGPoint(),size:Float = 1,type:eventTypes,details:String = "", note:String = "", color:UIColor = grey)
	{
		self.content = []
		self.details = details

		super.init()
		
		self.name = newName
		self.type = type
		self.size = size
		self.note = note
		self.location = location
		self.color = color
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = red
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		self.addChildNode(connection)
		
		connection.position = SCNVector3(0,0,-0.01)
		connection.opacity = 0
		
		targetter = SCNLine(nodeA: SCNVector3(-0.1,-0.25,0), nodeB: SCNVector3(0.1,-0.25,0), color: red)
		targetter.opacity = 0
		self.addChildNode(targetter)
		
		start()
	}
	
	// MARK: Basic -
	
	func start()
	{
		print("@ EVENT    | \(self.name!)\(self.location)")
		
		self.sprite  = createSprite()
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		let trigger = SCNTrigger(host: self, size: 1)
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
	}
	
	override func update()
	{
		if capsule == nil { return }
		
		self.position = SCNVector3(location.x,location.y,0)
		self.distance = distanceBetweenTwoPoints(capsule.location, point2: self.location)
		self.angle = calculateAngle()
		self.align = calculateAlignment()
		
		// Sighted
		if self.distance < 2 {
			if self.inSight == false {
				self.inSight = true
				self.isKnown = true
				sight()
			}
		}
		else{
			inSight = false
		}
		
		// Approach
		if self.distance <= 0.6 {
			if self.inApproach == false {
				approach()
				self.inApproach = true
			}
		}
		else{
			inApproach = false
		}
		
		// Collide
		if self.distance < 0.1 {
			if self.inCollision == false {
				collide()
				self.inCollision = true
			}
		}
		else{
			inCollision = false
		}
		
		radarCulling()
		clean()
	}
	
	func updateSprite()
	{
		// Empty node
		for node in self.sprite.childNodes {
			node.removeFromParentNode()
		}
		
		// Add
		for node in createSprite().childNodes {
			self.addChildNode(node)
		}
	}
	
	// MARK: Events -
	
	func sight()
	{
		print("* EVENT    | Sighted \(self.name!)")
	}
	
	func approach()
	{
		print("* EVENT    | Approached \(self.name!)")
		capsule.instance = self
		space.startInstance(self)
		player.activateEvent(self)
	}
	
	func collide()
	{
		print("* EVENT    | Collided \(self.name!)")
	}

	// MARK: Radar -
	
	func connect(event:Event)
	{
		if event.connection == self { return }
		self.connection.geometry = SCNLine(nodeA: SCNVector3(0,0,0), nodeB: SCNVector3( (event.location.x - self.location.x),(event.location.y - self.location.y),0), color: grey).geometry
	}
	
	// MARK: Misc -
	
	func createSprite() -> SCNNode
	{
		var size = self.size/10
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
		}
		else{
			size = 0.05
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
		}
		
		return spriteNode
	}
	
	func radarCulling()
	{
		if self.distance < 1.3 || player.inRadar == true {
			self.opacity = 1
		}
		else {
			self.opacity = 0
		}
	}
	
	func clean()
	{
		if self.size == 0 {
			print("Removed event \(self.name!) -> \(self.size)")
			self.removeFromParentNode()
		}
	}
	
	func updateColor(targetColor:UIColor)
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
	
	func calculateAlignment(direction:CGFloat = capsule.direction) -> CGFloat
	{
		var diff = max(direction, self.angle) - min(direction, self.angle)
		if (diff > 180){ diff = 360 - diff }
		
		return diff
	}
	
	func mesh() -> SCNNode
	{
		return SCNNode()
	}
	
	override func touch()
	{
		print("touched: \(self.name!)")
		radar.addTarget(self)
	}
	
	func selection()
	{
		updateColor(self.color)
		targetter.opacity = 1
	}
	
	func deselection()
	{
		updateColor(self.color)
		targetter.opacity = 0
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}