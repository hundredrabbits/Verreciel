
//
//  CapsuleNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

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
	var displayMessage:SCNLabel!
	var displayPassive:SCNLabel!
	var displayAlert:SCNLabel!
	
	var message:String = ""
	var passive:String = ""
	var alert:String = ""
	
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
		displayLeft = SCNNode()
		displayLeft.position = SCNVector3(-0.5,0,visorDepth)
		displayLeft.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: -1.3, z: 0), nodeB: SCNVector3(x: 0, y: -1.3, z: 0), color: grey))
		displayLeft.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -1.3, z: 0), nodeB: SCNVector3(x: 0.01, y: -1.275, z: 0), color: grey))
		
		displayHealth = SCNLabel(text: "99hp", scale: textSize, align: alignment.left, color:white)
		displayHealth.position = SCNVector3(x: -0.2, y: -1.375, z: 0)
		displayLeft.addChildNode(displayHealth)
		
		displayMessage = SCNLabel(text: "--", scale: textSize, align: alignment.center, color: white)
		displayMessage.position = SCNVector3(0,1.35,visorDepth)
		visor.addChildNode(displayMessage)
		
		displayPassive = SCNLabel(text: "--", scale: textSize, align: alignment.center, color: grey)
		displayPassive.position = SCNVector3(0,-1.375,visorDepth)
		visor.addChildNode(displayPassive)
		
		displayAlert = SCNLabel(text: "--", scale: textSize, align: alignment.center, color: red)
		displayAlert.position = SCNVector3(0,1.325,visorDepth)
		visor.addChildNode(displayAlert)
		
		displayLeft.eulerAngles.y = Float(degToRad(10))
		
		visor.addChildNode(displayLeft)
		
		displayRight = SCNNode()
		displayRight.position = SCNVector3(0.5,0,visorDepth)
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: -1.3, z: 0), nodeB: SCNVector3(x: 0, y: -1.3, z: 0), color: grey))
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -1.3, z: 0), nodeB: SCNVector3(x: -0.01, y: -1.275, z: 0), color: grey))
		
		displayMagic = SCNLabel(text: "16mp", scale: textSize, align: alignment.right, color:white)
		displayMagic.position = SCNVector3(x: 0.2, y: -1.375, z: 0)
		displayRight.addChildNode(displayMagic)
		
		displayRight.eulerAngles.y = Float(degToRad(-10))
		
		visor.addChildNode(displayRight)
		
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: 1.4, z: 0), nodeB: SCNVector3(x: 0.1, y: 1.4, z: 0), color: grey))
		displayLeft.addChildNode(SCNLine(nodeA: SCNVector3(x: -0.2, y: 1.4, z: 0), nodeB: SCNVector3(x: -0.1, y: 1.4, z: 0), color: grey))
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
	}
	
	func addMessage(message:String)
	{
		if self.message == message { return }
		
		self.message = message
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.1)
		displayMessage.position = SCNVector3(0,1.375,self.visorDepth - 0.01)
		displayMessage.opacity = 0
		displayMessage.updateColor(cyan)
		SCNTransaction.setCompletionBlock({
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.1)
			self.displayMessage.update(self.message)
			self.displayMessage.position = SCNVector3(0,1.375,self.visorDepth)
			self.displayMessage.opacity = 1
			self.displayMessage.updateColor(white)
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
		displayPassive.position = SCNVector3(0,-1.35,self.visorDepth - 0.01)
		displayPassive.opacity = 0
		SCNTransaction.setCompletionBlock({
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.1)
			self.displayPassive.update(self.passive)
			self.displayPassive.position = SCNVector3(0,-1.35,self.visorDepth)
			self.displayPassive.opacity = 1
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}