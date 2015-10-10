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
	
	var labelPositionX:SCNLabel!
	var labelPositionZ:SCNLabel!
	var labelDistance:SCNLabel!
	
	var eventPivot = SCNNode()
	var eventView = universe
	var shipCursor:SCNNode!
	
	var targetterAway:SCNNode!
	
	// Ports
	
	var inputLabel:SCNLabel!
	var outputLabel:SCNLabel!
	var input:SCNPort!
	var output:SCNPort!
	
	override init()
	{
		super.init()
		
		print("@ RADAR    | Init")
		
		name = "radar"
		addInterface()
		
		self.addChildNode(eventPivot)
		eventPivot.addChildNode(eventView)
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
		
		inputLabel = SCNLabel(text: "", scale: 0.1, align: alignment.left)
		inputLabel.position = SCNVector3(x: lowNode[7].x * scale + 0.3, y: highNode[7].y * scale, z: 0)
		
		outputLabel = SCNLabel(text: "", scale: 0.1, align: alignment.right)
		outputLabel.position = SCNVector3(x: lowNode[0].x * scale - 0.3, y: highNode[0].y * scale, z: 0)
		
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
		
		targetterAway = SCNNode()
		targetterAway.addChildNode(SCNLine(nodeA: SCNVector3(0.8,0,0), nodeB: SCNVector3(1,0,0), color: red))
		self.addChildNode(targetterAway)
		targetterAway.opacity = 0
		
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[7].x,lowNode[7].y,0), nodeB: SCNVector3(lowNode[7].x * 0.8,lowNode[7].y,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[0].x,lowNode[0].y,0), nodeB: SCNVector3(lowNode[0].x * 0.8,lowNode[0].y,0), color: white))
	
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[7].x * 0.8,lowNode[7].y,0), nodeB: SCNVector3(lowNode[7].x * 0.7,lowNode[7].y * 1.3,0), color: white))
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[0].x * 0.8,lowNode[0].y,0), nodeB: SCNVector3(lowNode[0].x * 0.7,lowNode[0].y * 1.3,0), color: white))
		
		addChildNode(SCNLine(nodeA: SCNVector3(lowNode[0].x * 0.7,lowNode[0].y * 1.3,0), nodeB: SCNVector3(lowNode[7].x * 0.7,lowNode[7].y * 1.3,0), color: white))
		
		let zoomLabel = SCNLabel(text: "enter radar", scale: 0.1, align: alignment.center, color: red)
		zoomLabel.position = SCNVector3(0,lowNode[7].y - 0.2,0)
		addChildNode(zoomLabel)
		
		let trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.7), operation: true)
		trigger.geometry?.materials.first?.diffuse.contents = clear
		trigger.position = SCNVector3(0,lowNode[7].y - 0.2,0)
		addChildNode(trigger)
	}
	
	override func tic()
	{
		let directionNormal = Double(Float(capsule.direction)/180) * -1
		shipCursor.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * directionNormal))
		
		update()
		self.bang(true)
	}
	
	override func update()
	{
		labelPositionX.update(String(Int(capsule.at.x)))
		labelPositionZ.update(String(Int(capsule.at.y)))
		
		eventView.position = SCNVector3(capsule.at.x * -1,capsule.at.y * -1,0)
		
		updateTarget()

		output.update()
	}
	
	func updateTarget()
	{		
		if output.event != nil {
			
			let shipNodePosition = CGPoint(x: CGFloat(capsule.at.x), y: CGFloat(capsule.at.y))
			let eventNodePosition = CGPoint(x: CGFloat(output.event.at.x), y: CGFloat(output.event.at.y))
			let distanceFromShip = Float(distanceBetweenTwoPoints(shipNodePosition,point2: eventNodePosition))
			
			labelDistance.update(String(format: "%.1f",distanceFromShip))
			labelDistance.opacity = 1
			
			if output.event.isKnown == false && distanceFromShip < 0.2 {
				output.event.isKnown = true
				output.event.update()
			}
			
			if distanceFromShip > 1.4 {
				let angleTest = angleBetweenTwoPoints(capsule.at, point2: output.event.at, center: capsule.at)
				let targetDirectionNormal = Double(Float(angleTest)/180) * 1
				targetterAway.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * targetDirectionNormal))
				targetterAway.opacity = 1
			}
			else{
				targetterAway.opacity = 0
			}
		}
		else{
			labelDistance.opacity = 0
		}
		
	}

	func addTarget(event:Event)
	{
		if output.event != nil { output.event.deselection() }
		event.selection()
		
		output.addEvent(event)
		outputLabel.updateWithColor(event.name!, color: white)
		
		self.bang()
		updateTarget()
	}
	
	func removeTarget()
	{
		output.disconnect()
		output.removeEvent()
		updateTarget()
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
			radar.inputLabel.update("+\(event.content.count) new")
			for location in event.content {
				universe.addChildNode(location)
			}
			event.size = 0
			cargo.bang(true)
		}
		update()
	}
	
	override func bang(param:Bool = true)
	{
		if param == false { player.leaveRadar() }
		
		if output.connection == nil { return }
		if output.event == nil {
			output.update()
			return
		} // TODO: Allow the broadcast of null
		
		output.connection.host.listen(output.event)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}