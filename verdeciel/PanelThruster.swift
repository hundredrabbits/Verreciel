//
//  SCNThruster.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

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
	
	var panelHead:SCNNode!
	var label:SCNLabel!
	var input:SCNPort!
	
	var panelFoot:SCNNode!
	var labelSecondary:SCNLabel!
	
	override func setup()
	{
		name = "thruster"
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		panelHead = SCNNode()
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		label = SCNLabel(text: name!, scale: 0.1, align: alignment.center)
		label.position = SCNVector3(x: 0.05, y: 0, z: templates.radius)
		panelHead.addChildNode(input)
		panelHead.addChildNode(label)
		addChildNode(panelHead)
		panelHead.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		panelFoot = SCNNode()
		labelSecondary = SCNLabel(text: "0", scale: 0.1, align: alignment.center)
		labelSecondary.position = SCNVector3(x: 0.05, y: 0, z: templates.radius)
		panelFoot.addChildNode(labelSecondary)
		addChildNode(panelFoot)
		panelFoot.eulerAngles.x += Float(degToRad(-templates.titlesAngle))
		
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
		
		draw()
	}

	override func touch(id:Int = 0)
	{
		if id == 1 {
			speedUp()
		}
		else{
			speedDown()
		}
	}
	
	func speedUp()
	{
		if speed <= maxSpeed {
			speed += 1
		}
		draw()
	}
	
	func speedDown()
	{
		if speed >= 1 {
			speed -= 1
		}
		draw()
	}
	
	func draw()
	{
		maxSpeed = 4
		
		if speed >= maxSpeed {
			speed = maxSpeed
		}
		
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
		
		if maxSpeed < 4 { line4.opacity = 0 }
		if maxSpeed < 3 { line3.opacity = 0 }
		if maxSpeed < 2 { line2.opacity = 0 }
		if maxSpeed < 1 { line1.opacity = 0 }
	}
	
	func enable()
	{
		isEnabled = true
		accelerate.opacity = 1
		decelerate.opacity = 1
		draw()
	}
	
	func disable()
	{
		isEnabled = false
		accelerate.opacity = 0
		decelerate.opacity = 0
		speed = 0
		draw()
	}
	
	override func fixedUpdate()
	{
		if speed * 10 > Int(actualSpeed * 10) {
			actualSpeed += 0.1
		}
		else if speed * 10 < Int(actualSpeed * 10) {
			actualSpeed -= 0.1
		}
		
		if capsule.dock != nil {
			speed = 0
			actualSpeed = 0
			labelSecondary.update("docked")
		}
		else if actualSpeed < 0.1 {
			actualSpeed = 0.1
		}
		
		if Float(speed) != actualSpeed {
			labelSecondary.update(String(format: "%.1f", actualSpeed))
		}
		
		thrust()
	}
	
	func thrust()
	{
		if actualSpeed > 0
		{
			let speed:Float = Float(actualSpeed)/300
			let angle:CGFloat = CGFloat((capsule.direction) % 360)
			
			let angleRad = degToRad(angle)
			
			capsule.at.x += CGFloat(speed) * CGFloat(sin(angleRad))
			capsule.at.y += CGFloat(speed) * CGFloat(cos(angleRad))
			
			radar.update()
		}
		capsule.travel += actualSpeed
	}
	
	override func listen(event: Event)
	{
		if event.type == eventTypes.warp {
//			warp(event.destination)
		}
	}
	
	func warp(destination:CGPoint, sector:sectors = capsule.sector)
	{
		print("  WARP     | Warping to \(destination)")
		
		capsule.at = destination
		capsule.sector = sector
	}
}