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

class PanelThruster : SCNNode
{
	var knob:SCNKnob!
	var speedLabel:SCNLabel!
	
	override init()
	{
		super.init()
		name = "thruster"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		update()
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	func addInterface()
	{
		knob = SCNKnob(newName:"thruster")
		self.addChildNode(knob)
		
		let scale:Float = 0.7
		
		let titleLabel = SCNLabel(text: "thruster", scale: 0.1, align: alignment.center)
		titleLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(titleLabel)
		
		speedLabel = SCNLabel(text: "-", scale: 0.1, align: alignment.center)
		speedLabel.position = SCNVector3(x: 0, y: lowNode[7].y * scale, z: 0)
		speedLabel.name = "label.speed"
		self.addChildNode(speedLabel)
	}
	
	override func update()
	{
		knob.update()
		speedLabel.update("\(Int(knob.value))")
	}
}