//
//  CameraNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//
import UIKit
import QuartzCore
import SceneKit
import Foundation

class CorePlayer : SCNNode
{
	var displayHealth:SCNLabel!
	var displayMagic:SCNLabel!
	
	var eventLabel:SCNLabel!
	var messageLabel:SCNLabel!
	var messageTimer:NSTimer!
	
	var alertLabel:SCNLabel!
	var alertTimer:NSTimer!
	var alertIsActive:Bool = false
	
	var health:Int
	var magic:Int
	
	var port:SCNPort!
	var event:Event!
	var handle:PanelHandle!
	
	var inRadar:Bool = false
	
	override init()
	{
		health = 99
		magic = 99
		
		super.init()
	
		// Camera
		self.camera = SCNCamera()
		self.camera?.xFov = 75
		self.name = "cameraNode"
		self.position = SCNVector3(x: 0, y: 0, z: 0)
		self.camera?.aperture = 100
		self.camera?.automaticallyAdjustsZRange = true
		
		addInterface()
		addHelmet()
	}
	
	override func update()
	{
		displayHealth.update("\(health)hp")
		displayMagic.update("\(magic)mp")
		
		if health < 0 {
			displayHealth.updateWithColor("dead",color: red)
		}
	}
	
	func addHelmet()
	{
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: -0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: 0.8, y: -0.92, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: 0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: 0.3, y: -1, z: -1.2), color: grey) )
		self.addChildNode( SCNLine(nodeA: SCNVector3(x: -0.25, y: -0.8, z: -1.01), nodeB: SCNVector3(x: -0.3, y: -1, z: -1.2), color: grey) )
	}
	
	func addInterface()
	{
		displayHealth = SCNLabel(text: "99hp", scale: 0.05, align: alignment.left)
		displayHealth.position = SCNVector3(x: -0.7, y: -1, z: -1.01)
		displayHealth.rotation = SCNVector4Make(0, 1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(displayHealth)
		
		displayMagic = SCNLabel(text: "34mp", scale: 0.05, align: alignment.right)
		displayMagic.position = SCNVector3(x: 0.7, y: -1, z: -1.01)
		displayMagic.rotation = SCNVector4Make(0, -1, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(displayMagic)
		
		alertLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		alertLabel.position = SCNVector3(x: 0, y: 1, z: -1.01)
		alertLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(alertLabel)
		
		messageLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		messageLabel.position = SCNVector3(x: 0, y: 1.1, z: -1.01)
		messageLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(messageLabel)
		
		eventLabel = SCNLabel(text: "", scale: 0.03, align: alignment.center)
		eventLabel.position = SCNVector3(x: 0, y: 0.9, z: -1.01)
		eventLabel.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.1)); // rotate 90 degrees
		self.addChildNode(eventLabel)
	}
	
	func activateEvent(event:Event)
	{
		self.event = event
	}
	
	func activatePort(port:SCNPort)
	{
		if self.port != nil {
			// Disconnect
			if self.port == port {
				self.port = nil
				port.disconnect()
				port.desactivate()
			}
			// New Connection
			else if self.port.polarity == true && port.polarity == false {
				self.port.connect(port)
				port.desactivate()
				self.port.desactivate()
				self.port = nil
				return
			}
		}
		else if port.polarity == true {
			// Select
			self.port = port
			self.port.activate()
		}
	}
	
	func desactivatePort()
	{
		self.port.desactivate()
	}
	
	func message(text:String)
	{
		messageLabel.update(text)
		messageTimer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("clearMessage"), userInfo: nil, repeats: false)
	}
	
	func clearMessage()
	{
		messageLabel.update("")
	}
	
	func alert(text:String)
	{
		alertIsActive = true
		alertLabel.update(text)
		alertTimer = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: Selector("clearAlert"), userInfo: nil, repeats: false)
	}
	
	func clearAlert()
	{
		alertIsActive = false
		alertTimer.invalidate()
		alertLabel.update("")
		alertLabel.opacity = 0
	}
	
	func enterRadar()
	{
		self.inRadar = true
		eventLabel.update("leave radar view")
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		cameraNode.position = SCNVector3(13,0,0)
		radar.eventPivot.position = SCNVector3(0,0,-14)
		radar.shipCursor.position = SCNVector3(0,0,-14)
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		for newEvent in universe.childNodes {
			let event = newEvent as! Event
			event.wire.opacity = 1
			event.opacity = 1
		}
		radar.leaveButton.opacity = 1
	}
	
	func leaveRadar()
	{
		self.inRadar = false
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2.5)
		cameraNode.position = SCNVector3(0,0,0)
		radar.eventPivot.position = SCNVector3(universe.position.x,universe.position.y,0)
		radar.shipCursor.position = SCNVector3(0,0,0)
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()

		for newEvent in universe.childNodes {
			let event = newEvent as! Event
			event.connection.opacity = 0
			event.opacity = 0
		}
		radar.leaveButton.opacity = 0
	}
	
	override func tic()
	{
		if capsule.dock != nil {
			player.eventLabel.updateWithColor("docked at \(capsule.dock.name!)", color: grey)
		}
		else{
			player.eventLabel.update("")
		}
		flickerAlert()
	}
	
	func flickerAlert()
	{
		if alertIsActive == false { return }
		if alertLabel.opacity == 0 { alertLabel.opacity = 1}
		else{ alertLabel.opacity = 0 }
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}