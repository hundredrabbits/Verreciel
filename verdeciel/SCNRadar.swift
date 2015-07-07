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

class SCNRadar : SCNNode
{
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
			let event = node as! SCNRadarEvent
			event.position.y = event.origin.y - (user.z/200)
			event.position.x = event.origin.x - (user.x/200)
			event.position = SCNVector3(x: event.position.x, y: event.position.y, z: event.position.z)
		}
		updateOrientation()
	}
	
	func updateOrientation()
	{
		var cursorOrientation:Float = 1;
		switch user.orientationName() {
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
	
	func addEvent(event:SCNRadarEvent)
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
		titleLabel.position = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: 0)
		titleLabel.name = "radar.label"
		self.addChildNode(titleLabel)
		
		labelPositionX = SCNLabel(text: "x", scale: 0.1, align: alignment.left)
		labelPositionX.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale, z: 0)
		labelPositionX.name = "radar.x"
		self.addChildNode(labelPositionX)
		
		labelPositionZ = SCNLabel(text: "z", scale: 0.1, align: alignment.left)
		labelPositionZ.position = SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale - 0.3, z: 0)
		labelPositionZ.name = "radar.z"
		self.addChildNode(labelPositionZ)
		
		labelOrientation = SCNLabel(text: "r", scale: 0.1, align: alignment.left)
		labelOrientation.position = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale + 0.3, z: 0)
		labelOrientation.name = "radar.r"
		self.addChildNode(labelOrientation)
	}
	
	func update()
	{
		labelPositionX.update(String(Int(user.x/20)))
		labelPositionZ.update(String(Int(user.z/20)))
		labelOrientation.update(user.orientationName())
		
		updateEvents()
	}

	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}