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
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: 0, y: -0.2, z: 0),color:grey))
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
	
	override func update()
	{
		labelPositionX.update(String(Int(x/20)))
		labelPositionZ.update(String(Int(z/20)))
		
		let distance = String(format: "%.1f", distanceBetweenTwoPoints(CGPoint(x: 0, y: 0),point2: CGPoint(x: CGFloat(x), y: CGFloat(z)))/1000 )
		
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
			case  .n : ratio = CGPoint(x: 0, y: 1)
			case  .ne : ratio = CGPoint(x: 0.5, y: 0.5)
			case  .e : ratio = CGPoint(x: 1, y: 0)
			case  .se : ratio = CGPoint(x: 0.5, y: -0.5)
			case  .nw : ratio = CGPoint(x: -0.5, y: 0.5)
			case  .w : ratio = CGPoint(x: -1, y: 0)
			case  .sw : ratio = CGPoint(x: -0.5, y: -0.5)
			default : ratio = CGPoint(x: 0, y: -1)
		}
		
//		z += thruster.knob.value * Float(ratio.y)
//		x += thruster.knob.value * Float(ratio.x)
		
		// Cardinals
		let markerHomeOrientation = (-90 + angleBetweenTwoPoints(CGPoint(x: 0, y: 0), point2: CGPoint(x: CGFloat(x), y: CGFloat(z)), center: CGPoint(x: 0, y: 0))) / 90
		markerHome.rotation = SCNVector4Make(0, 0, 1, Float(M_PI/2 * Double(markerHomeOrientation)))
		
		markerLastStar.opacity = 0
		markerLastStation.opacity = 0
		
		if lastStar != nil {
			let markerLastStarOrientation = (90 + angleBetweenTwoPoints(CGPoint(x: CGFloat(x/200), y: CGFloat(z/200)), point2: CGPoint(x: CGFloat(lastStar.x), y: CGFloat(lastStar.z)), center: CGPoint(x: CGFloat(x/200), y: CGFloat(z/200)))) / 90
			markerLastStar.rotation = SCNVector4Make(0, 0, 1, Float(M_PI/2 * Double(markerLastStarOrientation)))
			markerLastStar.opacity = 1
		}
		if lastStation != nil && lastStation.x != 0 && lastStation.z != 0 {
			let markerLastStationOrientation = (90 + angleBetweenTwoPoints(CGPoint(x: CGFloat(x/200), y: CGFloat(z/200)), point2: CGPoint(x: CGFloat(lastStation.x), y: CGFloat(lastStation.z)), center: CGPoint(x: CGFloat(x/200), y: CGFloat(z/200)))) / 90
			markerLastStation.rotation = SCNVector4Make(0, 0, 1, Float(M_PI/2 * Double(markerLastStationOrientation)))
			markerLastStar.opacity = 1
		}
	}
	
	func updateTarget()
	{
		if (output.event != nil) {
			targetter.position = output.event.position
			targetter.opacity = 1
			
			let shipNodePosition = CGPoint(x: CGFloat(x/200), y: CGFloat(z/200))
			let eventNodePosition = CGPoint(x: CGFloat(output.event.x), y: CGFloat(output.event.z))
			let distanceFromShip = Float(distanceBetweenTwoPoints(shipNodePosition,point2: eventNodePosition))
			
			if distanceFromShip > 1 {
				removeTarget()
			}
		}
		else{
			targetter.opacity = 0
		}
	}

	func addTarget(event:SCNEvent)
	{
		output.addEvent(event)
		outputLabel.updateWithColor(event.name!, color: white)
		
		targetter.position = event.position
		targetter.opacity = 1
	}
	
	func removeTarget()
	{
		output.disconnect()
		print("remove")
		targetter.opacity = 0
		
		output.removeEvent()
		outputLabel.updateWithColor("", color: grey)
	}
	
	override func bang()
	{
		if output.event != nil {
			output.connection.host.listen(output.event)
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}