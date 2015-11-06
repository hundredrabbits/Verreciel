//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreUI: SCNNode
{
	var canAlign:Bool = false

	var visor:SCNNode = SCNNode()
	var displayLeft:SCNNode!
	var displayRight:SCNNode!
	
	var displayHealth:SCNLabel!
	var displayMagic:SCNLabel!
	
	var messageLabel:SCNLabel!
	var passiveLabel:SCNLabel!
	var warningLabel:SCNLabel!
	
	var message:String = ""
	var passive:String = ""
	var warning:String = ""
	
	var warningTimer:NSTimer!
	
	let textSize:Float = 0.025
	let visorDepth = -1.3
	
	override init()
	{
		super.init()
		setup()
	}
	
	func setup()
	{
		setupVisor()
		addChildNode(visor)
	}
	
	func setupVisor()
	{
		// Left
		
		displayLeft = SCNNode()
		displayLeft.position = SCNVector3(-0.5,0,visorDepth)
		displayLeft.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: -1.3, z: 0), nodeB: SCNVector3(x: 0, y: -1.3, z: 0), color: grey))
		displayLeft.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -1.3, z: 0), nodeB: SCNVector3(x: 0.01, y: -1.275, z: 0), color: grey))
		
		displayHealth = SCNLabel(text: "99HP", scale: textSize, align: alignment.left, color:white)
		displayHealth.position = SCNVector3(x: -0.2, y: -1.375, z: 0)
		displayLeft.addChildNode(displayHealth)
		
		messageLabel = SCNLabel(text: "--", scale: textSize, align: alignment.center, color: white)
		messageLabel.position = SCNVector3(0,1.35,visorDepth)
		visor.addChildNode(messageLabel)
		
		passiveLabel = SCNLabel(text: "--", scale: textSize, align: alignment.center, color: grey)
		passiveLabel.position = SCNVector3(0,-1.2,visorDepth)
		visor.addChildNode(passiveLabel)
		
		displayLeft.eulerAngles.y = Float(degToRad(10))
		
		visor.addChildNode(displayLeft)
		
		// Right
		
		displayRight = SCNNode()
		displayRight.position = SCNVector3(0.5,0,visorDepth)
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: -1.3, z: 0), nodeB: SCNVector3(x: 0, y: -1.3, z: 0), color: grey))
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -1.3, z: 0), nodeB: SCNVector3(x: -0.01, y: -1.275, z: 0), color: grey))
		
		displayMagic = SCNLabel(text: "0MP", scale: textSize, align: alignment.right, color:white)
		displayMagic.position = SCNVector3(x: 0.2, y: -1.375, z: 0)
		displayRight.addChildNode(displayMagic)
		
		displayRight.eulerAngles.y = Float(degToRad(-10))
		
		visor.addChildNode(displayRight)
		
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: 1.4, z: 0), nodeB: SCNVector3(x: 0.1, y: 1.4, z: 0), color: grey))
		displayLeft.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: 1.4, z: 0), nodeB: SCNVector3(x: -0.1, y: 1.4, z: 0), color: grey))
		
		// Center
		
		warningLabel = SCNLabel(text: "", scale: 0.1, align: alignment.center, color: red)
		warningLabel.position = SCNVector3(x: 0, y: 2, z: -3.25)
		visor.addChildNode(warningLabel)
		
		visor.addChildNode(player.port)
		player.port.position = SCNVector3(0,-3,-2.5)
	}
	
	override func fixedUpdate()
	{
		if canAlign == true {
			if (eulerAngles.y - player.eulerAngles.y) > 0.0001 && eulerAngles.y > player.eulerAngles.y {
				eulerAngles.y -= (eulerAngles.y - player.eulerAngles.y) * 0.1
			}
			if (eulerAngles.y - player.eulerAngles.y) < -0.0001 && eulerAngles.y < player.eulerAngles.y {
				eulerAngles.y -= (eulerAngles.y - player.eulerAngles.y) * 0.1
			}
			if (eulerAngles.x - player.eulerAngles.x) > 0.0001 && eulerAngles.x > player.eulerAngles.x {
				eulerAngles.x -= (eulerAngles.x - player.eulerAngles.x) * 0.1
			}
			if (eulerAngles.x - player.eulerAngles.x) < -0.0001 && eulerAngles.y < player.eulerAngles.x {
				eulerAngles.x -= (eulerAngles.x - player.eulerAngles.x) * 0.1
			}
		}
		updatePort()
		
		warningLabel.blink()
	}

	func updatePort()
	{
		if player.port.origin == nil { return }
		
		let test = convertPosition(player.port.position, toNode: player.port.origin)
		player.port.origin.wire.update(SCNVector3(0,0,0), nodeB:SCNVector3( test.x, test.y, test.z ) )
		player.port.origin.wire.fixedUpdate()
	}
	
	func addMessage(message:String)
	{
		if self.message == message { return }
		
		self.message = message
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.1)
		messageLabel.position = SCNVector3(0,1.375,self.visorDepth - 0.01)
		messageLabel.opacity = 0
		messageLabel.updateColor(cyan)
		SCNTransaction.setCompletionBlock({
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.1)
			self.messageLabel.update(self.message)
			self.messageLabel.position = SCNVector3(0,1.375,self.visorDepth)
			self.messageLabel.opacity = 1
			self.messageLabel.updateColor(white)
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
	}
	
	func addPassive(passive:String)
	{
		if self.passive == passive { return }
		
		self.passive = passive
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.1)
		passiveLabel.position = SCNVector3(0,-1.2,self.visorDepth - 0.01)
		passiveLabel.opacity = 0
		SCNTransaction.setCompletionBlock({
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.1)
			self.passiveLabel.update(self.passive)
			self.passiveLabel.position = SCNVector3(0,-1.2,self.visorDepth)
			self.passiveLabel.opacity = 1
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
	}
	
	func addWarning(warning:String,duration:Double! = nil)
	{		
		self.warning = warning
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.1)
		warningLabel.position = SCNVector3(x: 0, y: 2, z: -3.3)
		warningLabel.update("")
		SCNTransaction.setCompletionBlock({
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.1)
			self.warningLabel.update(self.warning)
			self.warningLabel.position = SCNVector3(x: 0, y: 2, z: -3.25)
			if duration != nil {
				SCNTransaction.setCompletionBlock({ self.warningTimer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: Selector("hideWarning"), userInfo: nil, repeats: false) })
			}
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
	}
	
	func hideWarning()
	{
		if warningTimer != nil {
			warningTimer.invalidate()
		}
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		warningLabel.position = SCNVector3(x: 0, y: 2, z: -3.25)
		warningLabel.update("")
		SCNTransaction.commit()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}