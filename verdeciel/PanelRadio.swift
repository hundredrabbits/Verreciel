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
	var frequencyA:Float = 0
	var frequencyB:Float = 0
	var frequencyC:Float = 0
	var frequencyD:Float = 0
	
	var frequencyKnobA:SCNKnob!
	var frequencyKnobB:SCNKnob!
	var frequencyKnobC:SCNKnob!
	
	var frequencyLabel:SCNLabel!
	var targetLabel:SCNLabel!
	
	var labelPositionX:SCNLabel!
	var labelPositionZ:SCNLabel!
	var labelOrientation:SCNLabel!
	var eventView:SCNNode!
	var shipCursor:SCNNode!
	
	var target:SCNEvent!
	
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
		
		targetLabel = SCNLabel(text: "radio", scale: 0.1, align: alignment.right)
		targetLabel.position = SCNVector3(x: lowNode[0].x * scale, y: highNode[7].y * scale, z: 0)
		self.addChildNode(targetLabel)
		
		frequencyKnobA = SCNKnob(newName: "frequencyA")
		frequencyKnobA.position = SCNVector3(x: 0, y: 0.5, z: 0)
		self.addChildNode(frequencyKnobA)
		
		frequencyKnobB = SCNKnob(newName: "frequencyB")
		frequencyKnobB.position = SCNVector3(x: 1, y: -0.5, z: 0)
		self.addChildNode(frequencyKnobB)
		
		frequencyKnobC = SCNKnob(newName: "frequencyC")
		frequencyKnobC.position = SCNVector3(x: -1, y: -0.5, z: 0)
		self.addChildNode(frequencyKnobC)
		
		frequencyLabel = SCNLabel(text: "1221", scale: 0.1, align: alignment.center)
		frequencyLabel.position = SCNVector3(x: 0, y: -1, z: 0)
		self.addChildNode(frequencyLabel)
	}
	
	func createFrequency()
	{
		var freq = 0		
	}
	
	func touch(knobId:String)
	{
		if knobId == "frequencyA" { frequencyA = frequencyA <= 3 ? (frequencyA+1) : 0 }
		if knobId == "frequencyB" { frequencyB = frequencyB <= 3 ? (frequencyB+1) : 0 }
		if knobId == "frequencyC" { frequencyC = frequencyC <= 3 ? (frequencyC+1) : 0 }
		update()
	}
	
	func addTarget(target:SCNEvent)
	{
		self.target = target
		targetLabel.update(target.name!)
	}
	
	func removeTarget()
	{
		target = nil
		targetLabel.update("")
	}
	
	func update()
	{
		frequencyKnobA.update()
		frequencyKnobB.update()
		frequencyKnobC.update()
		
		scanner.update(frequencyA, val2: frequencyB, val3: frequencyC, val4: 0)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}