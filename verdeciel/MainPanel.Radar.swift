//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelRadar : MainPanel
{
	var x:Float = 0
	var z:Float = 0
	
	var eventPivot = SCNNode()
	var eventView = universe
	var shipCursor:SCNNode!
	
	var targetter:SCNNode!
	var targetterFar:SCNNode!
	
	var handle:SCNHandle!
	
	// MARK: Default -
	
	override init()
	{
		super.init()
		
		name = "radar"
		
		mainNode.addChildNode(eventPivot)
		eventPivot.addChildNode(eventView)
		
		// Ship
		
		shipCursor = SCNNode()
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: 0.2, y: 0, z: 0),color:white))
		shipCursor.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: 0.2, z: 0),nodeB: SCNVector3(x: -0.2, y: 0, z: 0),color:white))
		mainNode.addChildNode(shipCursor)
		
		targetterFar = SCNNode()
		targetterFar.addChildNode(SCNLine(nodeA: SCNVector3(0.8,0,0), nodeB: SCNVector3(1,0,0), color: red))
		targetterFar.opacity = 0
		mainNode.addChildNode(targetterFar)
		
		// Decals
	
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
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
		mainNode.addChildNode(targetter)
		
		self.position = SCNVector3(0,0,0)
		
		port.input = Location.self
		port.output = Location.self
		
		handle = SCNHandle(destination: SCNVector3(1,0,0),host:self)
		footer.addChildNode(handle)
	}
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		eventView.position = SCNVector3(capsule.at.x * -1,capsule.at.y * -1,0)
		
		let directionNormal = Double(Float(capsule.direction)/180) * -1
		shipCursor.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * directionNormal))
		
		updateTarget()
		scan()
	}
	
	// MARK: Ports -
	
	override func bang()
	{
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
				targetter.updateChildrenColors(clear)
			}
			else{
				targetter.position = SCNVector3(port.event.at.x - capsule.at.x,port.event.at.y - capsule.at.y,0)
				targetterFar.opacity = 0
				targetter.updateChildrenColors(red)
			}
			targetter.blink()
		}
	}

	func addTarget(event:Location)
	{
		if capsule.dock != nil && capsule.isDocked == false { return }
		if capsule.isWarping == true { return }
		
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
	
	// MARK: Scan -
	
	var closestStar:Location!
	
	func scan()
	{
//		for location in universe.childNodes {
//			let location = location as! Location
//			if location.type == .star {
//				if closestStar == nil {
//					closestStar = location
//				}
//				else if( location.distance < closestStar.distance ){
//					closestStar = location
//				}
//			}
//		}
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		player.lookAt(deg: -90)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}