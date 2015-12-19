//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelThruster : MainPanel
{
	var accelerate:SCNTrigger!
	var decelerate:SCNTrigger!
	
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	
	var cutLine1Left:SCNLine!
	var cutLine1Right:SCNLine!
	var cutLine2Left:SCNLine!
	var cutLine2Right:SCNLine!
	var cutLine3Left:SCNLine!
	var cutLine3Right:SCNLine!
	var cutLine4Left:SCNLine!
	var cutLine4Right:SCNLine!
	
	var maxSpeed:Int = 0
	var speed:Int = 0
	var actualSpeed:Float = 0
	
	var button:SCNButton!
	
	var canWarp:Bool = false
	
	// MARK: Default -
	
	override init()
	{
		super.init()
		
		name = "thruster"
		
		// Lines
		line1 = SCNLine(nodeA: SCNVector3(-0.5, -0.3, 0), nodeB: SCNVector3(0.5, -0.3, 0), color: grey)
		line2 = SCNLine(nodeA: SCNVector3(-0.5, -0.1, 0), nodeB: SCNVector3(0.5, -0.1, 0), color: grey)
		line3 = SCNLine(nodeA: SCNVector3(-0.5, 0.1, 0), nodeB: SCNVector3(0.5, 0.1, 0), color: grey)
		line4 = SCNLine(nodeA: SCNVector3(-0.5, 0.3, 0), nodeB: SCNVector3(0.5, 0.3, 0), color: grey)
		
		mainNode.addChildNode(line1)
		mainNode.addChildNode(line2)
		mainNode.addChildNode(line3)
		mainNode.addChildNode(line4)
		
		cutLine1Left = SCNLine(nodeA: SCNVector3(-0.5, -0.3, 0), nodeB: SCNVector3(-0.1, -0.3, 0), color: grey)
		cutLine1Right = SCNLine(nodeA: SCNVector3(0.5, -0.3, 0), nodeB: SCNVector3(0.1, -0.3, 0), color: grey)
		cutLine2Left = SCNLine(nodeA: SCNVector3(-0.5, -0.1, 0), nodeB: SCNVector3(-0.1, -0.1, 0), color: grey)
		cutLine2Right = SCNLine(nodeA: SCNVector3(0.5, -0.1, 0), nodeB: SCNVector3(0.1, -0.1, 0), color: grey)
		cutLine3Left = SCNLine(nodeA: SCNVector3(-0.5, 0.1, 0), nodeB: SCNVector3(-0.1, 0.1, 0), color: grey)
		cutLine3Right = SCNLine(nodeA: SCNVector3(0.5, 0.1, 0), nodeB: SCNVector3(0.1, 0.1, 0), color: grey)
		cutLine4Left = SCNLine(nodeA: SCNVector3(-0.5, 0.3, 0), nodeB: SCNVector3(-0.1, 0.3, 0), color: grey)
		cutLine4Right = SCNLine(nodeA: SCNVector3(0.5, 0.3, 0), nodeB: SCNVector3(0.1, 0.3, 0), color: grey)
		
		mainNode.addChildNode(cutLine1Left)
		mainNode.addChildNode(cutLine1Right)
		mainNode.addChildNode(cutLine2Left)
		mainNode.addChildNode(cutLine2Right)
		mainNode.addChildNode(cutLine3Left)
		mainNode.addChildNode(cutLine3Right)
		mainNode.addChildNode(cutLine4Left)
		mainNode.addChildNode(cutLine4Right)
		
		// Triggers
		
		accelerate = SCNTrigger(host: self, size: CGSize(width: 1, height: 1), operation: 1)
		accelerate.position = SCNVector3(0, 0.5, 0)
		accelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, 0), nodeB: SCNVector3(0.5, 0, 0), color: cyan))
		accelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, 0), nodeB: SCNVector3(-0.5, 0, 0), color: cyan))
		
		decelerate = SCNTrigger(host: self, size: CGSize(width: 1, height: 1), operation: 0)
		decelerate.position = SCNVector3(0, -0.5, 0)
		decelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, 0), nodeB: SCNVector3(0.5, 0, 0), color: red))
		decelerate.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, 0), nodeB: SCNVector3(-0.5, 0, 0), color: red))
		
		mainNode.addChildNode(accelerate)
		mainNode.addChildNode(decelerate)
		
		port.input = Event.self
		port.output = Event.self
		
		button = SCNButton(host:self, text: "undock", operation: 2)
		details.addChildNode(button)
	}

	override func touch(id:Int = 0)
	{
		if id == 0 {
			speedDown()
		}
		else if id == 1 {
			speedUp()
		}
		if id == 2 {
			if canWarp == true {
				capsule.warp(pilot.port.origin.event as! Location)
			}
			else{
				capsule.undock()
			}
		}
	}
	
	override func update()
	{
		maxSpeed = 0
		
		if battery.thrusterPort.origin != nil && battery.thrusterPort.origin.event != nil {
			if battery.thrusterPort.origin.event == items.cell1 || battery.thrusterPort.origin.event == items.cell2 || battery.thrusterPort.origin.event == items.cell3 || battery.thrusterPort.origin.event == items.cell4 { maxSpeed = 1 }
			if battery.thrusterPort.origin.event == items.array1 || battery.thrusterPort.origin.event == items.array2 || battery.thrusterPort.origin.event == items.array3 || battery.thrusterPort.origin.event == items.array4 { maxSpeed = 2 }
			if battery.thrusterPort.origin.event == items.grid1 || battery.thrusterPort.origin.event == items.grid2 || battery.thrusterPort.origin.event == items.grid3 || battery.thrusterPort.origin.event == items.grid4 { maxSpeed = 3 }
			if battery.thrusterPort.origin.event == items.matrix1 || battery.thrusterPort.origin.event == items.matrix2 || battery.thrusterPort.origin.event == items.matrix3 || battery.thrusterPort.origin.event == items.matrix4 { maxSpeed = 4 }
		}
		
		if maxSpeed > 0 { line1.opacity = 1 ; cutLine1Left.opacity = 0 ; cutLine1Right.opacity = 0 } else { line1.opacity = 0 ; cutLine1Left.opacity = 1 ; cutLine1Right.opacity = 1 }
		if maxSpeed > 1 { line2.opacity = 1 ; cutLine2Left.opacity = 0 ; cutLine2Right.opacity = 0 } else { line2.opacity = 0 ; cutLine2Left.opacity = 1 ; cutLine2Right.opacity = 1 }
		if maxSpeed > 2 { line3.opacity = 1 ; cutLine3Left.opacity = 0 ; cutLine3Right.opacity = 0 } else { line3.opacity = 0 ; cutLine3Left.opacity = 1 ; cutLine3Right.opacity = 1 }
		if maxSpeed > 3 { line4.opacity = 1 ; cutLine4Left.opacity = 0 ; cutLine4Right.opacity = 0 } else { line4.opacity = 0 ; cutLine4Left.opacity = 1 ; cutLine4Right.opacity = 1 }
	}
	
	override func fixedUpdate()
	{
		canWarp = false
		
		update()
		
		// Check for warp
		if battery.thrusterPort.isReceivingItemOfType(.battery) == false {
			speed = 0
			modeUnpowered()
		}
		if capsule.isWarping == true {
			modeWarping()
		}
		else if port.isReceiving(items.warpDrive) == true && pilot.port.isReceivingLocationOfType(.portal) == true {
			modeWaitingForWarp()
			canWarp = true
		}
		else if port.isReceiving(items.warpDrive) == true {
			modeMissingPilotForWarp()
			canWarp = true
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
	
	func modeWarping()
	{
		button.disable("warping")
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(clear)
		decelerate.updateChildrenColors(clear)
		
		line1.opacity = 1 ; cutLine1Left.opacity = 0 ; cutLine1Right.opacity = 0
		line2.opacity = 1 ; cutLine2Left.opacity = 0 ; cutLine2Right.opacity = 0
		line3.opacity = 1 ; cutLine3Left.opacity = 0 ; cutLine3Right.opacity = 0
		line4.opacity = 1 ; cutLine4Left.opacity = 0 ; cutLine4Right.opacity = 0
		
		line1.blink()
		line2.blink()
		line3.blink()
		line4.blink()
	}
	
	func modeWaitingForWarp()
	{
		button.enable("warp")
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		line1.opacity = 1 ; cutLine1Left.opacity = 0 ; cutLine1Right.opacity = 0
		line2.opacity = 1 ; cutLine2Left.opacity = 0 ; cutLine2Right.opacity = 0
		line3.opacity = 1 ; cutLine3Left.opacity = 0 ; cutLine3Right.opacity = 0
		line4.opacity = 1 ; cutLine4Left.opacity = 0 ; cutLine4Right.opacity = 0
	}
	
	func modeMissingPilotForWarp()
	{
		button.disable("pilot")
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		line1.opacity = 1 ; cutLine1Left.opacity = 0 ; cutLine1Right.opacity = 0
		line2.opacity = 1 ; cutLine2Left.opacity = 0 ; cutLine2Right.opacity = 0
		line3.opacity = 1 ; cutLine3Left.opacity = 0 ; cutLine3Right.opacity = 0
		line4.opacity = 1 ; cutLine4Left.opacity = 0 ; cutLine4Right.opacity = 0
	}
	
	func modeUnpowered()
	{
		button.disable("unpowered")
		
		accelerate.disable()
		decelerate.disable()
		accelerate.updateChildrenColors(grey)
		decelerate.updateChildrenColors(grey)
		
		line1.opacity = 0 ; cutLine1Left.opacity = 1 ; cutLine1Right.opacity = 1
		line2.opacity = 0 ; cutLine2Left.opacity = 1 ; cutLine2Right.opacity = 1
		line3.opacity = 0 ; cutLine3Left.opacity = 1 ; cutLine3Right.opacity = 1
		line4.opacity = 0 ; cutLine4Left.opacity = 1 ; cutLine4Right.opacity = 1
	}
	
	func modeDocking()
	{
		let dockingProgress = Int((1 - distanceBetweenTwoPoints(capsule.at, point2: capsule.dock.at)/0.5) * 100)
		button.disable("docking \(dockingProgress)%", outline:clear)
		
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
		button.enable("undock")
		
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
		button.disable(String(format: "%.1f", actualSpeed), outline:clear)
		
		if speed > 0 { line1.color(white) } else { line1.color(grey) }
		if speed > 1 { line2.color(white) } else { line2.color(grey) }
		if speed > 2 { line3.color(white) } else { line3.color(grey) }
		if speed > 3 { line4.color(white) } else { line4.color(grey) }
		
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
		if capsule.isWarping == true { speed = 100 ; return }
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
		}
		
		journey.distance += actualSpeed
		space.starTimer += actualSpeed
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		player.lookAt(deg: -45)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}