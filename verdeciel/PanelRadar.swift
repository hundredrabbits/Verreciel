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
	var eventView:SCNNode!
	var shipCursor:SCNNode!
	
	override init()
	{
		super.init()
		name = "radar"
		addInterface()
		
		eventView = SCNNode()
		self.addChildNode(eventView)
	}
	
	func updateEvents()
	{
		for node in eventView.childNodes
		{
			let event = node as! PanelRadarEvent
			event.position.y = event.origin.y - (z/200)
			event.position.x = event.origin.x - (x/200)
			event.position = SCNVector3(x: event.position.x, y: event.position.y, z: event.position.z)
		}
		updateOrientation()
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
		
		println(direction)
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
	
	func addEvent(event:PanelRadarEvent)
	{
		eventView.addChildNode(event)
		update()
	}
	
	func addInterface()
	{
		// Draw the frame
		
		let scale:Float = 0.8
		let nodeA = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale, z: highNode[7].z)
		let nodeB = SCNVector3(x: highNode[0].x * scale, y: highNode[0].y * scale, z: highNode[0].z)
		let nodeC = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: lowNode[7].z)
		let nodeD = SCNVector3(x: lowNode[0].x * scale, y: lowNode[0].y * scale, z: lowNode[0].z)
		
		// Draw Radar
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		// Frame
		self.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * scale, z: 0),SCNVector3(x: highNode[7].x * scale, y: 0, z: 0)))
		self.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * -scale, z: 0),SCNVector3(x: highNode[7].x * scale, y: 0, z: 0)))
		self.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * scale, z: 0),SCNVector3(x: highNode[7].x * -scale, y: 0, z: 0)))
		self.addChildNode(line(SCNVector3(x: 0, y: highNode[7].y * -scale, z: 0),SCNVector3(x: highNode[7].x * -scale, y: 0, z: 0)))
		
		shipCursor = SCNNode()
		
		// Ship
		shipCursor.addChildNode(line(SCNVector3(x: 0, y: 0.15, z: 0),SCNVector3(x: 0.15, y: 0, z: 0)))
		shipCursor.addChildNode(line(SCNVector3(x: 0, y: 0.15, z: 0),SCNVector3(x: -0.15, y: 0, z: 0)))
		shipCursor.addChildNode(grey(SCNVector3(x: 0, y: 0, z: 0),SCNVector3(x: 0, y: -0.15, z: 0)))
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
	}
	
	func update()
	{
		labelPositionX.update(String(Int(x/20)))
		labelPositionZ.update(String(Int(z/20)))
		labelOrientation.update(directionName())
		
		updatePosition()
		updateEvents()
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
	}

	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}