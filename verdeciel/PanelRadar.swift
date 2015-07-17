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
	var direction = cardinals.n
	
	var labelPositionX:SCNLabel!
	var labelPositionZ:SCNLabel!
	var labelOrientation:SCNLabel!
	var labelDistance:SCNLabel!
	
	var target:SCNEvent!
	var targetter:SCNLine!
	
	var labelTargetName:SCNLabel!
	var labelTargetType:SCNLabel!
	
	var eventView:SCNNode!
	var shipCursor:SCNNode!
	
	// Markers
	
	var markerHome:SCNNode!
	var markerLastStar:SCNNode!
	var markerLastStation:SCNNode!
	
	var lastStation:SCNEvent!
	var lastStar:SCNEvent!
	
	override init()
	{
		super.init()
		name = "radar"
		addInterface()
		
		targetter = SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0, z: 0), color: red)
		self.addChildNode(targetter)
		
		eventView = SCNNode()
		self.addChildNode(eventView)
		
		createCardinals()
	}
	
	func createCardinals()
	{
		markerHome = SCNNode()
		markerHome.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: highNode[7].x * 0.65, z: 0), nodeB: SCNVector3(x: 0, y: lowNode[0].y, z: 0), color: grey))
		self.addChildNode(markerHome)
		
		markerLastStation = SCNNode()
		markerLastStation.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: highNode[7].x * 0.65, z: 0), nodeB: SCNVector3(x: 0, y: lowNode[0].y, z: 0), color: cyan))
		self.addChildNode(markerLastStation)
		
		markerLastStar = SCNNode()
		markerLastStar.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: highNode[7].x * 0.65, z: 0), nodeB: SCNVector3(x: 0, y: lowNode[0].y, z: 0), color: red))
		self.addChildNode(markerLastStar)
	}
	
	func updateOrientation()
	{
		var cursorOrientation:Float = 1;
		switch directionName() {
			case "n" : cursorOrientation = 0
			case "ne" : cursorOrientation = 0.5
			case "e" : cursorOrientation = 1
			case "se" : cursorOrientation = 1.5
			case "nw" : cursorOrientation = -0.5
			case "w" : cursorOrientation = -1
			case "sw" : cursorOrientation = -1.5
			default : cursorOrientation = 2
		}
		shipCursor.rotation = SCNVector4Make(0, 0, 1, -1 * Float(Float(M_PI/2) * cursorOrientation ));
	}
	
	func directionName() -> String
	{
		switch direction {
		case  cardinals.n : return "n"
		case  cardinals.ne : return "ne"
		case  cardinals.e : return "e"
		case  cardinals.se : return "se"
		case  cardinals.nw : return "nw"
		case  cardinals.w : return "w"
		case  cardinals.sw : return "sw"
		default : return "s"
		}
	}
	
	func addEvent(event:SCNEvent)
	{
		eventView.addChildNode(event)
		update()
	}
	
	func addInterface()
	{
		// Draw the frame
		
		let scale:Float = 0.8
		
		// Draw Radar
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		// Frame
		let newScale:Float = 0.65
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: highNode[7].x * newScale, z: 0), nodeB: SCNVector3(x: highNode[7].x * newScale, y: 0, z: 0), color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: highNode[7].x * -newScale, z: 0), nodeB: SCNVector3(x: highNode[7].x * newScale, y: 0, z: 0), color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: highNode[7].x * newScale, z: 0), nodeB: SCNVector3(x: highNode[7].x * -newScale, y: 0, z: 0), color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: highNode[7].x * -newScale, z: 0), nodeB: SCNVector3(x: highNode[7].x * -newScale, y: 0, z: 0), color: grey))
		
		shipCursor = SCNNode()
		
		// Ship
		shipCursor.addChildNode(line(SCNVector3(x: 0, y: 0.15, z: 0),SCNVector3(x: 0.15, y: 0, z: 0)))
		shipCursor.addChildNode(line(SCNVector3(x: 0, y: 0.15, z: 0),SCNVector3(x: -0.15, y: 0, z: 0)))
		self.addChildNode(shipCursor)
		
		let titleLabel = SCNLabel(text: "radar", scale: 0.1, align: alignment.left)
		titleLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale, z: 0)
		self.addChildNode(titleLabel)
		
		labelPositionX = SCNLabel(text: "x", scale: 0.1, align: alignment.left)
		labelPositionX.position = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: 0)
		labelPositionX.name = "radar.x"
		self.addChildNode(labelPositionX)
		
		labelPositionZ = SCNLabel(text: "z", scale: 0.1, align: alignment.left)
		labelPositionZ.position = SCNVector3(x: highNode[7].x * scale, y: lowNode[7].y * scale + 0.3, z: 0)
		labelPositionZ.name = "radar.z"
		self.addChildNode(labelPositionZ)
		
		labelOrientation = SCNLabel(text: "r", scale: 0.1, align: alignment.left)
		labelOrientation.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 0.3, z: 0)
		labelOrientation.name = "radar.r"
		self.addChildNode(labelOrientation)
		
		labelTargetName = SCNLabel(text: "radar", scale: 0.1, align: alignment.right)
		labelTargetName.position = SCNVector3(x: lowNode[0].x * scale, y: highNode[0].y * scale, z: 0)
		self.addChildNode(labelTargetName)
		
		labelTargetType = SCNLabel(text: "Target", scale: 0.1, align: alignment.right)
		labelTargetType.position = SCNVector3(x: lowNode[0].x * scale, y: highNode[0].y * scale - 0.3, z: 0)
		self.addChildNode(labelTargetType)
		
		labelDistance = SCNLabel(text: "90.4", scale: 0.1, align: alignment.right)
		labelDistance.position = SCNVector3(x: lowNode[0].x * scale, y: lowNode[7].y * scale, z: 0)
		self.addChildNode(labelDistance)
	}
	
	func update()
	{
		labelPositionX.update(String(Int(x/20)))
		labelPositionZ.update(String(Int(z/20)))
		labelOrientation.update(directionName())
		
		let distance = String(format: "%.1f", distanceBetweenTwoPoints(CGPoint(x: 0, y: 0),CGPoint(x: CGFloat(x), y: CGFloat(z))))
		
		labelDistance.update( "\(distance)" )
		
		updatePosition()
		updateEvents()
		updateTarget()
	}
	
	func updateEvents()
	{
		for node in eventView.childNodes
		{
			let event = node as! SCNEvent
			event.position.z = event.z - (z/200)
			event.position.x = event.x - (x/200)
			event.position = SCNVector3(x: event.position.x, y: event.position.z, z: 0)
			
			let scale:Float = 0.65
			event.opacity = 1
			
			if event.position.y > highNode[7].y * scale { event.opacity = 0 }
			if event.position.y < lowNode[7].y * scale { event.opacity = 0 }
			if event.position.x < lowNode[7].x * scale { event.opacity = 0 }
			if event.position.x > lowNode[0].x * scale { event.opacity = 0 }
		}
		updateOrientation()
	}
	func updatePosition()
	{
		var ratio = CGPoint(x: 0, y: 1)
		
		switch direction {
			case  cardinals.n : ratio = CGPoint(x: 0, y: 1)
			case  cardinals.ne : ratio = CGPoint(x: 0.5, y: 0.5)
			case  cardinals.e : ratio = CGPoint(x: 1, y: 0)
			case  cardinals.se : ratio = CGPoint(x: 0.5, y: -0.5)
			case  cardinals.nw : ratio = CGPoint(x: -0.5, y: 0.5)
			case  cardinals.w : ratio = CGPoint(x: -1, y: 0)
			case  cardinals.sw : ratio = CGPoint(x: -0.5, y: -0.5)
			default : ratio = CGPoint(x: 0, y: -1)
		}
		
		z += thruster.speed * Float(ratio.y)
		x += thruster.speed * Float(ratio.x)
		
		// Home Marker
		var markerHomeOrientation = (-90 + angleBetweenTwoPoints(CGPoint(x: 0, y: 0), CGPoint(x: CGFloat(x), y: CGFloat(z)), CGPoint(x: 0, y: 0))) / 90
		markerHome.rotation = SCNVector4Make(0, 0, 1, Float(M_PI/2 * Double(markerHomeOrientation)))
		
		if lastStar != nil {
			var markerLastStarOrientation = (90 + angleBetweenTwoPoints(CGPoint(x: CGFloat(x/200), y: CGFloat(z/200)), CGPoint(x: CGFloat(lastStar.x), y: CGFloat(lastStar.z)), CGPoint(x: CGFloat(x/200), y: CGFloat(z/200)))) / 90
			markerLastStar.rotation = SCNVector4Make(0, 0, 1, Float(M_PI/2 * Double(markerLastStarOrientation)))
		}
		if lastStation != nil {
			var markerLastStationOrientation = (90 + angleBetweenTwoPoints(CGPoint(x: CGFloat(x/200), y: CGFloat(z/200)), CGPoint(x: CGFloat(lastStation.x), y: CGFloat(lastStation.z)), CGPoint(x: CGFloat(x/200), y: CGFloat(z/200)))) / 90
			markerLastStation.rotation = SCNVector4Make(0, 0, 1, Float(M_PI/2 * Double(markerLastStationOrientation)))
		}
	}
	
	func updateTarget()
	{
		var closestDistance:Float = 9000
		
		var shipNodePosition = CGPoint(x: CGFloat(x/200), y: CGFloat(z/200))
	
		var closestEvent:SCNEvent!
		
		for node in eventView.childNodes
		{
			let event = node as! SCNEvent
			
			let eventNodePosition = CGPoint(x: CGFloat(event.x), y: CGFloat(event.z))
			let distanceFromShip = Float(distanceBetweenTwoPoints(shipNodePosition,eventNodePosition))
			
			if event.isKnown == true { continue }
			if distanceFromShip > 1 { continue }
			
			if distanceFromShip < closestDistance {
				closestDistance = distanceFromShip
				closestEvent = event
			}
		}
		
		if closestEvent != nil {
			if closestEvent != target {
				addTarget(closestEvent)
			}
			targetter.geometry = SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: target.position.x, y: target.position.y, z: 0), color: UIColor.grayColor()).geometry
			targetter.opacity = 1
		}
		else{
			target = nil
			targetter.opacity = 0
			labelTargetName.update("")
			labelTargetType.update("")
			radio.removeTarget()
		}
	}

	func addTarget(event:SCNEvent)
	{
		target = event
		labelTargetName.update(target.name!)
		labelTargetType.update(target.typeString!)
		console.addLine("scan \(target.name!)")
		
		if target.type == eventTypes.star { lastStar = target }
		if target.type == eventTypes.station { lastStation = target }
		
		radio.addTarget(target)
	}

	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}