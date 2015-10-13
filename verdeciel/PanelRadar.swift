//
//  displayNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelRadar : SCNNode
{
	var x:Float = 0
	var z:Float = 0
	
	var sectorLabel:SCNLabel!
	
	var eventPivot = SCNNode()
	var eventView = universe
	var shipCursor:SCNNode!
	
	var target:Location!
	var targetter:SCNNode!
	var targetterFar:SCNNode!
	
	override init()
	{
		super.init()
		
		print("@ RADAR    | Init")
		
		name = "radar"
		addInterface()
		
		self.addChildNode(eventPivot)
		eventPivot.addChildNode(eventView)
		
	}
	
	func addInterface()
	{
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
	
		sectorLabel = SCNLabel(text: "enter radar", scale: 0.1, align: alignment.center, color: white)
		sectorLabel.position = SCNVector3(0,highNode[7].y + 0.2,0)
		addChildNode(sectorLabel)
		
		// Ship
		
		shipCursor = SCNNode()
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: 0.2, y: 0, z: 0),color:white))
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: -0.2, y: 0, z: 0),color:white))
		self.addChildNode(shipCursor)
		
		targetterFar = SCNNode()
		targetterFar.addChildNode(SCNLine(nodeA: SCNVector3(0.8,0,0), nodeB: SCNVector3(1,0,0), color: red))
		targetterFar.opacity = 0
		self.addChildNode(targetterFar)
		
		// Design Top
		addChildNode(SCNLine(nodeA: SCNVector3(highNode[7].x,highNode[7].y,0), nodeB: SCNVector3(highNode[7].x * 0.8,highNode[7].y,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(highNode[0].x,highNode[0].y,0), nodeB: SCNVector3(highNode[0].x * 0.8,highNode[0].y,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(highNode[7].x * 0.8,highNode[7].y,0), nodeB: SCNVector3(highNode[7].x * 0.7,highNode[7].y * 1.3,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(highNode[0].x * 0.8,highNode[0].y,0), nodeB: SCNVector3(highNode[0].x * 0.7,highNode[0].y * 1.3,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(highNode[0].x * 0.7,highNode[0].y * 1.3,0), nodeB: SCNVector3(highNode[7].x * 0.7,highNode[7].y * 1.3,0), color: white))
		
		// Design Bottom
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[7].x,lowNode[7].y,0), nodeB: SCNVector3(lowNode[7].x * 0.8,lowNode[7].y,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[0].x,lowNode[0].y,0), nodeB: SCNVector3(lowNode[0].x * 0.8,lowNode[0].y,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[7].x * 0.8,lowNode[7].y,0), nodeB: SCNVector3(lowNode[7].x * 0.7,lowNode[7].y * 1.3,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[0].x * 0.8,lowNode[0].y,0), nodeB: SCNVector3(lowNode[0].x * 0.7,lowNode[0].y * 1.3,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[0].x * 0.7,lowNode[0].y * 1.3,0), nodeB: SCNVector3(lowNode[7].x * 0.7,lowNode[7].y * 1.3,0), color: white))
		
		// Targetter
		
		targetter = SCNNode()
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0), nodeB: SCNVector3(x: 0.2, y: 0, z: 0), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: -0.2, z: 0), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -0.2, z: 0), nodeB: SCNVector3(x: -0.2, y: 0, z: 0), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0.2, z: 0), color: red))
		targetter.opacity = 0
		addChildNode(targetter)
		
		/* TODO: wtf
		let zoomLabel = SCNLabel(text: "enter radar", scale: 0.1, align: alignment.center, color: red)
		zoomLabel.position = SCNVector3(0,lowNode[7].y - 0.2,0)
		addChildNode(zoomLabel)
		
		let trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.7), operation: true)
		trigger.geometry?.materials.first?.diffuse.contents = clear
		trigger.position = SCNVector3(0,lowNode[7].y - 0.2,0)
		addChildNode(trigger)
		*/
	}
	
	override func fixedUpdate()
	{
		if target != nil {
			sectorLabel.updateWithColor(target.name!, color: white)
		}
		else{
			sectorLabel.updateWithColor("\(closestLocation(eventDetails.star).name!) system", color: grey)
		}
		
		if targetter.opacity == 1 { targetter.opacity = 0 }
		else{ targetter.opacity = 1 }
		
		eventView.position = SCNVector3(capsule.at.x * -1,capsule.at.y * -1,0)
		
		let directionNormal = Double(Float(capsule.direction)/180) * -1
		shipCursor.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * directionNormal))
	}
	
	func updateTarget()
	{		
		if target != nil {
			
			let shipNodePosition = CGPoint(x: CGFloat(capsule.at.x), y: CGFloat(capsule.at.y))
			let eventNodePosition = CGPoint(x: CGFloat(target.at.x), y: CGFloat(target.at.y))
			let distanceFromShip = Float(distanceBetweenTwoPoints(shipNodePosition,point2: eventNodePosition))
			
			if distanceFromShip > 2 {
				let angleTest = angleBetweenTwoPoints(capsule.at, point2: target.at, center: capsule.at)
				let targetDirectionNormal = Double(Float(angleTest)/180) * 1
				targetterFar.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * targetDirectionNormal))
				targetterFar.opacity = 1
				targetter.opacity = 0
			}
			else{
				targetter.position = SCNVector3(target.at.x - capsule.at.x,target.at.y - capsule.at.y,0)
				targetterFar.opacity = 0
				targetter.opacity = 1
			}
		}
	}

	func addTarget(event:Location)
	{
		target = event
		updateTarget()
	}
	
	func removeTarget()
	{
		target = nil
	}
	
	func closestLocation(type:eventDetails) -> Location
	{
		var closestEvent:Location!
		for newEvent in universe.childNodes {
			let event = newEvent as! Location
			if closestEvent == nil { closestEvent = event }
			if event.details != type { continue }
			if event.distance > closestEvent.distance { continue }
			closestEvent = event
		}
		return closestEvent
	}
	
	override func listen(event: Event)
	{
		if event.type == eventTypes.map {
			for location in event.content {
				universe.addChildNode(location)
			}
			event.size = 0
			cargo.bang(true)
		}
		update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}