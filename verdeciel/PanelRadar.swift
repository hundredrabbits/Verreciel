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

class PanelRadar : Panel
{
	var x:Float = 0
	var z:Float = 0
	
	var eventPivot = SCNNode()
	var eventView = universe
	var shipCursor:SCNNode!
	
	var targetter:SCNNode!
	var targetterFar:SCNNode!
	
	var mapPort:SCNPort!
	var handle:SCNHandle!
	
	// MARK: Default -
	
	override func setup()
	{
		name = "radar"
		
		interface.addChildNode(eventPivot)
		eventPivot.addChildNode(eventView)
		
		// Ship
		
		shipCursor = SCNNode()
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: 0.2, y: 0, z: 0),color:white))
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: -0.2, y: 0, z: 0),color:white))
		interface.addChildNode(shipCursor)
		
		targetterFar = SCNNode()
		targetterFar.addChildNode(SCNLine(nodeA: SCNVector3(0.8,0,0), nodeB: SCNVector3(1,0,0), color: red))
		targetterFar.opacity = 0
		interface.addChildNode(targetterFar)
		
		// Decals
		
		decals.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
		// Targetter
		let scale:Float = 0.3
		let depth:Float = 0
		targetter = SCNNode()
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: depth), nodeB: SCNVector3(x: scale * 0.2, y: scale * 0.8, z: depth), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: scale, z: depth), nodeB: SCNVector3(x: -scale * 0.2, y: scale * 0.8, z: depth), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: depth), nodeB: SCNVector3(x: scale * 0.2, y: -scale * 0.8, z: depth), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -scale, z: depth), nodeB: SCNVector3(x: -scale * 0.2, y: -scale * 0.8, z: depth), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: depth), nodeB: SCNVector3(x: scale * 0.8, y: scale * 0.2, z: depth), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: scale, y: 0, z: depth), nodeB: SCNVector3(x: scale * 0.8, y: -scale * 0.2, z: depth), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: -scale, y: 0, z: depth), nodeB: SCNVector3(x: -scale * 0.8, y: scale * 0.2, z: depth), color: red))
		targetter.addChildNode(SCNLine(nodeA: SCNVector3(x: -scale, y: 0, z: depth), nodeB: SCNVector3(x: -scale * 0.8, y: -scale * 0.2, z: depth), color: red))
		targetter.opacity = 0
		interface.addChildNode(targetter)
		
		self.position = SCNVector3(0,0,0)
		
		port.input = eventTypes.location
		port.output = eventTypes.location
		
		// Map Port
		
		mapPort = SCNPort(host: self, input: eventTypes.map, output: eventTypes.map)
		mapPort.position = SCNVector3(0,-0.6,templates.radius)
		mapPort.enable()
		mapPort.addEvent(items.starmap)
		
		let mapPortInputLabel = SCNLabel(text: "\(mapPort.input)", scale: 0.03, color:grey, align: alignment.right)
		let mapPortOutputLabel = SCNLabel(text: "\(mapPort.input)", scale: 0.03, color:grey, align: alignment.left)
		mapPortInputLabel.position = SCNVector3(-templates.margin * 0.5,0,0)
		mapPortOutputLabel.position = SCNVector3(templates.margin * 0.5,0,0)
		mapPort.addChildNode(mapPortInputLabel)
		mapPort.addChildNode(mapPortOutputLabel)
		
		footer.addChildNode(mapPort)
		
		handle = SCNHandle(destination: SCNVector3(1,0,0))
		footer.addChildNode(handle)
	}
	
	override func installedFixedUpdate()
	{
		eventView.position = SCNVector3(capsule.at.x * -1,capsule.at.y * -1,0)
		
		let directionNormal = Double(Float(capsule.direction)/180) * -1
		shipCursor.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * directionNormal))
		
		updateTarget()
	}
	
	// MARK: Ports -
	
	override func bang()
	{
		if mapPort.connection != nil && mapPort.event != nil {
			mapPort.connection.host.listen(mapPort.event)
		}
		if port.connection != nil && port.event != nil {
			port.connection.host.listen(port.event)
		}
	}

	// MARK: Custom -
	
	func updateTarget()
	{		
		if port.event != nil {
			let shipNodePosition = CGPoint(x: CGFloat(capsule.at.x), y: CGFloat(capsule.at.y))
			let eventNodePosition = CGPoint(x: CGFloat(port.event.at.x), y: CGFloat(port.event.at.y))
			let distanceFromShip = Float(distanceBetweenTwoPoints(shipNodePosition,point2: eventNodePosition))
			
			if distanceFromShip > 2 {
				let angleTest = angleBetweenTwoPoints(capsule.at, point2: port.event.at, center: capsule.at)
				let targetDirectionNormal = Double(Float(angleTest)/180) * 1
				targetterFar.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * targetDirectionNormal))
				targetterFar.opacity = 1
			}
			else{
				targetter.position = SCNVector3(port.event.at.x - capsule.at.x,port.event.at.y - capsule.at.y,0)
				targetterFar.opacity = 0
			}
			targetter.blink()
		}
	}

	func addTarget(event:Location)
	{
		port.event = event
		
		updateTarget()
		bang()
		
		// Check for overlapping events
		for newEvent in eventView.childNodes {
			if newEvent.position.x == event.position.x && newEvent.position.y == event.position.y && event != newEvent {
				print("Overlapping event: \(newEvent.name!) -> \(event.position.x)")
			}
		}
	}
	
	func removeTarget()
	{
		port.event = nil
		targetter.opacity = 0
	}
	
	override func onInstallationBegin()
	{
		player.lookAt(deg: -90)
	}
}