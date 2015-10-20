//
//  PanelBeacon.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelBreaker : Panel
{
	var interfaceActive:SCNLine!
	var isActive = false
	
	override func setup()
	{		
		self.position = SCNVector3(x: 0, y: templates.radius, z: 0)
		self.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 1))
		self.geometry = SCNPlane(width: 2, height: 2)
		self.geometry?.materials.first?.diffuse.contents = clear
		
		label = SCNLabel(text: "breaker", scale: 0.075, align: alignment.center, color: white)
		label.position = SCNVector3(0,-0.7,0)
		self.addChildNode(label)
		
		interface = SCNNode()
		interface.addChildNode(SCNLine(nodeA: SCNVector3(-0.4,0.4,0), nodeB: SCNVector3(0.4,0.4,0), color: red))
		interface.addChildNode(SCNLine(nodeA: SCNVector3(-0.4,-0.4,0), nodeB: SCNVector3(0.4,-0.4,0), color: red))
		interface.addChildNode(SCNLine(nodeA: SCNVector3(-0.4,0.4,0), nodeB: SCNVector3(-0.4,-0.4,0), color: red))
		interface.addChildNode(SCNLine(nodeA: SCNVector3(0.4,0.4,0), nodeB: SCNVector3(0.4,-0.4,0), color: red))
		self.addChildNode(interface)
		
		interfaceActive = SCNLine(nodeA: SCNVector3(-0.4,0,0), nodeB: SCNVector3(0.4,0,0), color: red)
		interfaceActive.position = SCNVector3(0,-0.4,0)
		self.addChildNode(interfaceActive)
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,0,0), nodeB: SCNVector3(templates.leftMargin,0,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,0,0), nodeB: SCNVector3(templates.rightMargin,0,0), color: grey))
	}
	
	override func touch(id:Int = 0)
	{
		if isActive != true {
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(1.5)
			interfaceActive.position = SCNVector3(0,0,0)
			SCNTransaction.setCompletionBlock({ self.setActive() })
			SCNTransaction.commit()
			interface.updateChildrenColors(red)
			interfaceActive.updateColor(red)
		}
		else{
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(1.5)
			interfaceActive.position = SCNVector3(0,-0.4,0)
			SCNTransaction.setCompletionBlock({ self.setInactive() })
			SCNTransaction.commit()
			interface.updateChildrenColors(red)
			interfaceActive.updateColor(red)
		}
	}
	
	func setInactive()
	{
		isActive = false
		interface.updateChildrenColors(red)
		interfaceActive.updateColor(red)
		label.updateColor(grey)
		capsule.setInactive()
	}
	
	func setActive()
	{
		isActive = true
		interface.updateChildrenColors(cyan)
		interfaceActive.updateColor(cyan)
		label.updateColor(white)
		capsule.setActive()
	}
}