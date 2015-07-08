//
//  PanelRadio.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelRadio : SCNNode
{
	var frequencyKnobA:SCNKnob!
	var frequencyKnobB:SCNKnob!
	var frequencyKnobC:SCNKnob!
	
	var frequencyLabel:SCNLabel!
	
	var labelPositionX:SCNLabel!
	var labelPositionZ:SCNLabel!
	var labelOrientation:SCNLabel!
	var eventView:SCNNode!
	var shipCursor:SCNNode!
	
	override init()
	{
		super.init()
		name = "radio"
		addInterface()
	
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		let titleLabel = SCNLabel(text: "radio", scale: 0.1, align: alignment.left)
		titleLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale, z: 0)
		self.addChildNode(titleLabel)
		
		frequencyKnobA = SCNKnob(newName: "frequencyA")
		frequencyKnobA.position = SCNVector3(x: 0, y: 0.5, z: 0)
		self.addChildNode(frequencyKnobA)
		
		frequencyKnobB = SCNKnob(newName: "frequencyB")
		frequencyKnobB.position = SCNVector3(x: 1, y: -0.5, z: 0)
		self.addChildNode(frequencyKnobB)
		
		frequencyKnobC = SCNKnob(newName: "frequencyC")
		frequencyKnobC.position = SCNVector3(x: -1, y: -0.5, z: 0)
		self.addChildNode(frequencyKnobC)
		
		frequencyLabel = SCNLabel(text: "451", scale: 0.1, align: alignment.center)
		frequencyLabel.position = SCNVector3(x: 0, y: -1, z: 0)
		self.addChildNode(frequencyLabel)
	}
	
	func touch(knobId:String)
	{
		if knobId == "frequencyA" { user.frequencyA = user.frequencyA <= 3 ? (user.frequencyA+1) : 0 }
		if knobId == "frequencyB" { user.frequencyB = user.frequencyB <= 3 ? (user.frequencyB+1) : 0 }
		if knobId == "frequencyC" { user.frequencyC = user.frequencyC <= 3 ? (user.frequencyC+1) : 0 }
		
		println(user.frequencyA)
		println(user.frequencyB)
		println(user.frequencyC)
		
		update()
	}
	
	func update()
	{
		frequencyKnobA.update(user.frequencyA)
		frequencyKnobB.update(user.frequencyB)
		frequencyKnobC.update(user.frequencyC)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}