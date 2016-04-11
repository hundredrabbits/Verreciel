//  Created by Devine Lu Linvega on 2015-07-16.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Helmet: SCNNode
{
	var canAlign:Bool = false

	var visor:SCNNode = SCNNode()
	var displayLeft:SCNNode!
	var displayRight:SCNNode!
	
	var leftHandLabel:SCNLabel!
	var rightHandLabel:SCNLabel!
	
	var messageLabel:SCNLabel!
	var passiveLabel:SCNLabel!
	
	
	var message:String = ""
	var passive:String = ""
	
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
		
		leftHandLabel = SCNLabel(text: "--", scale: textSize, align: alignment.left, color:grey)
		leftHandLabel.position = SCNVector3(x: -0.2, y: -1.375, z: 0)
		displayLeft.addChildNode(leftHandLabel)
		
		messageLabel = SCNLabel(text: "--", scale: textSize, align: alignment.center, color: white)
		messageLabel.position = SCNVector3(0,1.35,visorDepth)
		visor.addChildNode(messageLabel)
		
		passiveLabel = SCNLabel(text: "--", scale: textSize, align: alignment.center, color: grey)
		passiveLabel.position = SCNVector3(0,-1.2,visorDepth)
		visor.addChildNode(passiveLabel)
		
		displayLeft.eulerAngles.y = degToRad(10)
		
		visor.addChildNode(displayLeft)
		
		// Right
		
		displayRight = SCNNode()
		displayRight.position = SCNVector3(0.5,0,visorDepth)
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0.2, y: -1.3, z: 0), nodeB: SCNVector3(x: 0, y: -1.3, z: 0), color: grey))
		displayRight.addChildNode(SCNLine(nodeA: SCNVector3(x: 0, y: -1.3, z: 0), nodeB: SCNVector3(x: -0.01, y: -1.275, z: 0), color: grey))
		
		rightHandLabel = SCNLabel(text: "--", scale: textSize, align: alignment.right, color:white)
		rightHandLabel.position = SCNVector3(x: 0.2, y: -1.375, z: 0)
		displayRight.addChildNode(rightHandLabel)
		
		displayRight.eulerAngles.y = degToRad(-10)
		
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
		super.fixedUpdate()
        
		if eulerAngles.y > player.eulerAngles.y + 0.0001 {
			eulerAngles.y -= (eulerAngles.y - player.eulerAngles.y) * 0.75
		}
		else if eulerAngles.y < player.eulerAngles.y - 0.0001 {
			eulerAngles.y -= (eulerAngles.y - player.eulerAngles.y) * 0.75
		}
		if eulerAngles.x > player.eulerAngles.x + 0.0001 {
			eulerAngles.x -= (eulerAngles.x - player.eulerAngles.x) * 0.85
		}
		else if eulerAngles.y < player.eulerAngles.x - 0.0001 {
			eulerAngles.x -= (eulerAngles.x - player.eulerAngles.x) * 0.85
		}
		updatePort()
		
		warningLabel.blink()
	}
	
	override func onConnect()
	{
		print("Helmet mode is on!!")
	}

	func updatePort()
	{
		if player.port.origin == nil { return }
		
		let test = convertPosition(player.port.position, toNode: player.port.origin)
		player.port.origin.wire.update(SCNVector3(0,0,0), nodeB:SCNVector3( test.x, test.y, test.z ) )
		player.port.origin.wire.fixedUpdate()
	}
	
	func addMessage(message:String, color:UIColor = white)
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
			self.messageLabel.update(self.message, color:color)
			self.messageLabel.position = SCNVector3(0,1.375,self.visorDepth)
			self.messageLabel.opacity = 1
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
	
	var warningString:String = ""
	var warningColor:UIColor = red
	var warningLabel:SCNLabel!
	var warningFlag:String!
	
	func addWarning(text:String, color:UIColor = red, duration:Double, flag:String)
	{
		warningString = text
		warningColor = color
		warningFlag = flag
		
		warningLabel.update(warningString,color:warningColor)
		
		delay(duration, block: { self.hideWarning(self.warningFlag) })
	}
	
	func hideWarning(flag:String)
	{
		if flag != warningFlag { return }
		warningFlag = ""
		warningString = ""
		self.warningLabel.update("")
	}
	
	func showWarningUntil(warning:String, predicate:() -> Bool)
	{
//		showWarning(warning)
//		
//		if predicate() == true {
//			hideWarning()
//		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}