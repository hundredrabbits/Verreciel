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
	var targetLabel:SCNLabel!
	
	var labelPositionX:SCNLabel!
	var labelPositionZ:SCNLabel!
	var labelOrientation:SCNLabel!
	var eventView:SCNNode!
	var shipCursor:SCNNode!
	
	var freq1:Int = 0
	var freq2:Int = 0
	var freq3:Int = 0
	var freq4:Int = 0
	
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
		
		frequencyLabel = SCNLabel(text: "\(freq1)\(freq2)\(freq3)\(freq4)", scale: 0.1, align: alignment.center)
		frequencyLabel.position = SCNVector3(x: 0, y: -1, z: 0)
		self.addChildNode(frequencyLabel)
	}
	
	func updateFrequency()
	{
		freq1 = Int(frequencyKnobC.value)
		freq2 = Int(frequencyKnobA.value) + Int(frequencyKnobB.value)
		freq3 = Int(frequencyKnobB.value) + Int(frequencyKnobC.value)
		freq4 = Int(frequencyKnobA.value)
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
		updateFrequency()
		
		frequencyKnobA.update()
		frequencyKnobB.update()
		frequencyKnobC.update()
		
		frequencyLabel.update("\(freq1)\(freq2)\(freq3)\(freq4)")
		
		scanner.update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}