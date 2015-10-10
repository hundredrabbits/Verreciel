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
	
	var angle:CGFloat!
	var align:CGFloat!
	var distance:CGFloat!
	
	var inCollision:Bool = false
	var inApproach:Bool = false
	var inDiscovery:Bool = false
	var inSight:Bool = false
	
	var isVisible:Bool = false
	var isKnown:Bool = false // TODO: set to false for release
	var isTargetted:Bool = false
	
	var sprite = SCNNode()
	var trigger = SCNNode()
	var wire:SCNLine!
	var connection:Event!
	
	var targetter = SCNNode()
	var interface = Panel()
	
	var quest:Bool = false
	
	init(newName:String = "",at:CGPoint = CGPoint(),size:Float = 1,type:eventTypes = eventTypes.unknown,details:eventDetails = eventDetails.unknown, note:String = "", color:UIColor = grey, quest:Bool = false)
	{
		self.content = []
		self.details = details
		self.quest = quest

		super.init()
		
		self.name = newName
		self.type = type
		self.size = size
		self.note = note
		self.at = at
		self.color = color
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = red
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		
		wire = SCNLine()
		wire.position = SCNVector3(0,0,-0.01)
		wire.opacity = 0
		self.addChildNode(wire)
		
		targetter = SCNLine(nodeA: SCNVector3(-0.1,-0.25,0), nodeB: SCNVector3(0.1,-0.25,0), color: red)
		targetter.opacity = 0
		self.addChildNode(targetter)
		
		start()
	}
	
	// MARK: Basic -
	
	override func start()
	{
		print("@ EVENT    | \(self.name!)\(self.at)")
		
		self.sprite  = createSprite()
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		let trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
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

	// MARK: Radar -
	
	func connect(event:Event)
	{
		connection = event
		self.wire.draw(SCNVector3(0,0,0), nodeB: SCNVector3( (connection.at.x - self.at.x),(connection.at.y - self.at.y),0), color: grey)
	}
	
	// MARK: Misc -
	
	func createSprite() -> SCNNode
	{
		var size = self.size/10
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
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
		let verticalDistance = abs(capsule.at.y - at.y)
		let horizontalDistance = abs(capsule.at.x - at.x)
		
		if player.inRadar == true {
			self.opacity = 1
		}
		else if Float(verticalDistance) > highNode[0].y {
			self.opacity = 0
		}
		else if Float(horizontalDistance) > highNode[0].x {
			self.opacity = 0
		}
		else {
			self.opacity = 1
		}
		
		if connection != nil {
			if connection.opacity == 1 {
				wire.opacity = 1
			}
			else{
				wire.opacity = 0
			}
		}
		
	}
	
	func clean()
	{
		if self.size == 0 {
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
		let p1 = capsule.at
		let p2 = self.at
		let center = capsule.at
		
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
	
	func panel() -> SCNNode
	{
		return SCNNode()
	}
	
	override func touch()
	{
		if isKnown == true {
			print("touched: \(self.name!)")
			radar.addTarget(self)
		}
		else{
			print("event is unknown")
		}
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