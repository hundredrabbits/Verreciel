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
	var knobMesh:SCNKnob!
	
	override init()
	{
		super.init()
		name = "thruster"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		update()
	}
	
	func addInterface()
	{
		knobMesh = SCNKnob(newName:"thruster",position:SCNVector3(x: 0, y: 0, z: 0))
		self.addChildNode(knobMesh)
		
		let scale:Float = 0.7
		
		let titleLabel = SCNLabel(text: "thruster", scale: 0.1, align: alignment.center)
		titleLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(titleLabel)
		
		let speedValueLabel = SCNLabel(text: "radar", scale: 0.1, align: alignment.center)
		speedValueLabel.position = SCNVector3(x: 0, y: lowNode[7].y * scale, z: 0)
		speedValueLabel.name = "label.speed"
		self.addChildNode(speedValueLabel)
	}
	
	func touch()
	{
		if( user.speed < 3 ){
			user.speed += 1
		}
		else{
			user.speed = 0
		}
		NSLog("SPEED:%d",user.speed)
		update()
	}
	
	func update()
	{
		knobMesh.update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}