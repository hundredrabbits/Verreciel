//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelThruster : Panel
{
	var accelerate:SCNTrigger!
	var decelerate:SCNTrigger!
	
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	
	var maxSpeed:Int = 0
	var speed:Int = 0
	var actualSpeed:Float = 0
	
	var trigger:SCNTrigger!
	
	// MARK: Default -
	
	override func setup()
	{
		name = "thruster"
		
		// Lines
		line1 = SCNLine(nodeA: SCNVector3(-0.5, -0.3, 0), nodeB: SCNVector3(0.5, -0.3, 0), color: grey)
		line2 = SCNLine(nodeA: SCNVector3(-0.5, -0.1, 0), nodeB: SCNVector3(0.5, -0.1, 0), color: grey)
		line3 = SCNLine(nodeA: SCNVector3(-0.5, 0.1, 0), nodeB: SCNVector3(0.5, 0.1, 0), color: white)
		line4 = SCNLine(nodeA: SCNVector3(-0.5, 0.3, 0), nodeB: SCNVector3(0.5, 0.3, 0), color: white)
		
		interface.addChildNode(line1)
		interface.addChildNode(line2)
		interface.addChildNode(line3)
		interface.addChildNode(line4)
		
		// Triggers
		accelerate = SCNTrigger(host: self, size: CGSize(width: 1, height: 1), operation: 1)
		accelerate.position = SCNVector3(0, 0.5, 0)
		accelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, 0), nodeB: SCNVector3(0.5, 0, 0), color: cyan))
		accelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, 0), nodeB: SCNVector3(-0.5, 0, 0), color: cyan))
		
		decelerate = SCNTrigger(host: self, size: CGSize(width: 1, height: 1), operation: 0)
		decelerate.position = SCNVector3(0, -0.5, 0)
		decelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, 0), nodeB: SCNVector3(0.5, 0, 0), color: red))
		decelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, 0), nodeB: SCNVector3(-0.5, 0, 0), color: red))
		
		interface.addChildNode(accelerate)
		interface.addChildNode(decelerate)
		
		port.input = eventTypes.location
		port.output = eventTypes.unknown
		
		let buttonWidth = 0.65
		trigger = SCNTrigger(host: self, size: CGSize(width: 2, height: 0.5), operation: 2)
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,-0.25,0), nodeB: SCNVector3(buttonWidth,-0.25,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,0.25,0), nodeB: SCNVector3(buttonWidth,0.25,0), color: red))
		
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,0.25,0), nodeB: SCNVector3(-buttonWidth - 0.25,0,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(-buttonWidth,-0.25,0), nodeB: SCNVector3(-buttonWidth - 0.25,0,0), color: red))
		
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(buttonWidth,0.25,0), nodeB: SCNVector3(buttonWidth + 0.25,0,0), color: red))
		trigger.addChildNode(SCNLine(nodeA: SCNVector3(buttonWidth,-0.25,0), nodeB: SCNVector3(buttonWidth + 0.25,0,0), color: red))
		details.addChildNode(trigger)
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.updateWithColor("--", color: grey)
	}

	override func touch(id:Int = 0)
	{
		if id == 0 { speedDown() ; return }
		if id == 1 { speedUp() ; return }
		if id == 2 { capsule.undock() ; return }
	}
	
	override func installedFixedUpdate()
	{
		if battery.thrusterPort.origin == nil {
			speed = 0
			modeUnpowered()
		}
		else if capsule.isDocked == true {
			modeDocked()
		}
		else if capsule.dock != nil {
			modeDocking()
		}
		else {
			modeFlight()
		}
	
		thrust()
	}
	
	// MARK: Custom -
	
	func modeUnpowered()
	{
		label.updateColor(grey)
		details.updateWithColor("unpowered", color: grey)
		port.disable()
		trigger.opacity = 0
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(clear)
		decelerate.updateChildrenColors(clear)
		
		line1.color(grey)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
	}
	
	func modeDocking()
	{
		label.updateColor(white)
		details.updateWithColor("Docking \( Int((1 - distanceBetweenTwoPoints(capsule.at, point2: capsule.dock.at)/0.5) * 100 ))%", color: white)
		port.enable()
		trigger.opacity = 0
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		line1.blink()
		line1.color(white)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
	}
	
	func modeDocked()
	{
		label.updateColor(white)
		details.update("Undock")
		port.enable()
		trigger.opacity = 1
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		line1.opacity = 1
		line1.color(grey)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
	}
	
	func modeFlight()
	{
		maxSpeed = 1
	
		label.updateColor(white)
		details.updateWithColor(String(format: "%.1f", actualSpeed), color: white)
		port.enable()
		trigger.opacity = 0
		
		line1.opacity = 1
		line2.opacity = 1
		line3.opacity = 1
		line4.opacity = 1
		
		line1.color(grey)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
		
		if speed > 0 { line1.color(white) }
		if speed > 1 { line2.color(white) }
		if speed > 2 { line3.color(white) }
		if speed > 3 { line4.color(white) }
		
		accelerate.enable()
		decelerate.enable()
		
		if speed == maxSpeed {
			accelerate.updateChildrenColors(grey)
		}
		else{
			accelerate.updateChildrenColors(cyan)
		}
		
		if speed == 0 {
			decelerate.updateChildrenColors(grey)
		}
		else{
			decelerate.updateChildrenColors(red)
		}
	}
	
	func speedUp()
	{
		if speed < maxSpeed {
			speed += 1
		}
	}
	
	func speedDown()
	{
		if speed >= 1 {
			speed -= 1
		}
	}
	
	func thrust()
	{
		if capsule.isDocked ==  true { speed = 0 ; actualSpeed = 0 ; return }
		
		if speed * 10 > Int(actualSpeed * 10) {
			actualSpeed += 0.1
		}
		else if speed * 10 < Int(actualSpeed * 10) {
			actualSpeed -= 0.1
		}
		
		if capsule.dock != nil {
			speed = 0
		}
		else if actualSpeed < 0.1 {
			actualSpeed = 0.1
		}
		
		if actualSpeed > 0
		{
			let speed:Float = Float(actualSpeed)/600
			let angle:CGFloat = CGFloat((capsule.direction) % 360)
			
			let angleRad = degToRad(angle)
			
			capsule.at.x += CGFloat(speed) * CGFloat(sin(angleRad))
			capsule.at.y += CGFloat(speed) * CGFloat(cos(angleRad))
			
			radar.update()
		}
		capsule.journey += actualSpeed
		space.starTimer += actualSpeed
	}
}