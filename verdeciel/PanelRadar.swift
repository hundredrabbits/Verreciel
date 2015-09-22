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
	var labelDistance:SCNLabel!
	
	var eventView:SCNNode!
	var shipCursor:SCNNode!
	
	// Markers
	
	var markerHome:SCNNode!
	var markerLastStar:SCNNode!
	var markerLastStation:SCNNode!
	
	var lastStation:SCNEvent!
	var lastStar:SCNEvent!
	
	var targetter:SCNNode!
	
	// Ports
	
	var inputLabel:SCNLabel!
	var outputLabel:SCNLabel!
	var input:SCNPort!
	var output:SCNPort!
	
	override init()
	{
		super.init()
		name = "radar"
		addInterface()
		
		targetter = createTargetter()
		self.addChildNode(targetter)
		
		eventView = SCNNode()
		self.addChildNode(eventView)
		
		createCardinals()
	}
	
	func createTargetter() -> SCNNode
	{
		let targetterNode = SCNNode()
		
		targetterNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0), nodeB: SCNVector3(x: 0.2, y: 0, z: 0), color: red))
		targetterNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: -0.2, z: 0), color: red))
		targetterNode.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -0.2, z: 0), nodeB: SCNVector3(x: -0.2, y: 0, z: 0), color: red))
		targetterNode.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: 0, z: 0), nodeB: SCNVector3(x: 0, y: 0.2, z: 0), color: red))
		
		return targetterNode
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
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(1)
		shipCursor.rotation = SCNVector4Make(0, 0, 1, -1 * Float(Float(M_PI/2) * cursorOrientation ))
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	func directionName() -> String
	{
		switch direction {
		case  .n : return "n"
		case  .ne : return "ne"
		case  .e : return "e"
		case  .se : return "se"
		case  .nw : return "nw"
		case  .w : return "w"
		case  .sw : return "sw"
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
		
		// Ports
		
		input = SCNPort(host: self, polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.1, y: highNode[7].y * scale, z: 0)
		output = SCNPort(host: self, polarity: true)
		output.position = SCNVector3(x: lowNode[0].x * scale - 0.15, y: highNode[7].y * scale, z: 0)
		
		inputLabel = SCNLabel(text: "radar", scale: 0.1, align: alignment.left)
		inputLabel.position = SCNVector3(x: lowNode[7].x * scale + 0.3, y: highNode[7].y * scale, z: 0)
		inputLabel.updateWithColor("radar", color: grey)
		
		outputLabel = SCNLabel(text: "", scale: 0.1, align: alignment.right)
		outputLabel.position = SCNVector3(x: lowNode[0].x * scale - 0.3, y: highNode[0].y * scale, z: 0)
		outputLabel.updateColor(grey)
		
		self.addChildNode(input)
		self.addChildNode(output)
		self.addChildNode(inputLabel)
		self.addChildNode(outputLabel)
		
		// Ship
		
		shipCursor = SCNNode()
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: 0.2, y: 0, z: 0),color:white))
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: -0.2, y: 0, z: 0),color:white))
		self.addChildNode(shipCursor)
		
		labelPositionX = SCNLabel(text: "x", scale: 0.1, align: alignment.left)
		labelPositionX.position = SCNVector3(x: lowNode[7].x * scale, y: lowNode[7].y * scale, z: 0)
		labelPositionX.name = "radar.x"
		self.addChildNode(labelPositionX)
		
		labelPositionZ = SCNLabel(text: "z", scale: 0.1, align: alignment.left)
		labelPositionZ.position = SCNVector3(x: highNode[7].x * scale, y: lowNode[7].y * scale + 0.3, z: 0)
		labelPositionZ.name = "radar.z"
		self.addChildNode(labelPositionZ)
		
		labelDistance = SCNLabel(text: "90.4", scale: 0.1, align: alignment.right)
		labelDistance.position = SCNVector3(x: lowNode[0].x * scale, y: lowNode[7].y * scale, z: 0)
		self.addChildNode(labelDistance)
	}
	
	override func tic()
	{
		let directionNormal = Double(Float(capsule.direction)/180) * -1
		shipCursor.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * directionNormal))
	}
	
	override func update()
	{
		labelPositionX.update(String(Int(capsule.location.x/20)))
		labelPositionZ.update(String(Int(capsule.location.y/20)))
		
		updateEvents()
		updateTarget()
	}
	
	func updateEvents()
	{
		for node in eventView.childNodes
		{
			let event = node as! SCNEvent
			event.position.z = Float(event.location.y - (capsule.location.y))
			event.position.x = Float(event.location.x - (capsule.location.x))
			event.position = SCNVector3(x: event.position.x, y: event.position.z, z: 0)
			
			let scale:Float = 0.65
			event.opacity = 1
			
			if event.position.y > highNode[7].y * scale { event.opacity = 0 }
			if event.position.y < lowNode[7].y * scale { event.opacity = 0 }
			if event.position.x < lowNode[7].x * scale { event.opacity = 0 }
			if event.position.x > lowNode[0].x * scale { event.opacity = 0 }
			
			print("\(capsule.location.y) - \(event.location.y)")
		}
		updateOrientation()
	}
	
	func updateTarget()
	{
		if (output.event != nil) {
			targetter.position = output.event.position
			targetter.opacity = 1
			
			let shipNodePosition = CGPoint(x: CGFloat(capsule.location.x), y: CGFloat(capsule.location.y))
			let eventNodePosition = CGPoint(x: CGFloat(output.event.location.x), y: CGFloat(output.event.location.y))
			let distanceFromShip = Float(distanceBetweenTwoPoints(shipNodePosition,point2: eventNodePosition))
			
			labelDistance.update(String(format: "%.1f",distanceFromShip))
			labelDistance.opacity = 1
		}
		else{
			targetter.opacity = 0
			labelDistance.opacity = 0
		}
	}

	func addTarget(event:SCNEvent)
	{
		print("added target")
		output.addEvent(event)
		outputLabel.updateWithColor(event.name!, color: white)
		
		targetter.position = event.position
		targetter.opacity = 1
		
		self.bang()
	}
	
	func removeTarget()
	{
		output.disconnect()
		targetter.opacity = 0
		
		output.removeEvent()
		outputLabel.updateWithColor("", color: grey)
	}
	
	override func bang(param:Bool = true)
	{
		if output.event != nil {
			output.connection.host.listen(output.event)
		}
		else{
			print("missing")
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}