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

class SCNThruster : SCNNode
{
	var knobMesh:SCNKnob!
	
	override init()
	{
		super.init()
		name = "thruster"
		addInterface()
	}
	
	func addInterface()
	{
		let panelNode = SCNNode()
		panelNode.name = "panel.thruster"
		panelNode.position = SCNVector3(x:0,y:floorNode[0].y,z:0)
		knobMesh = SCNKnob(newName:"thruster",position:SCNVector3(x: 0, y: 0, z: 0))
		panelNode.addChildNode(knobMesh)
		panelNode.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 1)); // rotate 90 degrees
		
		var testLabel = SCNLabel(text: "speed", scale: 0.05, align: alignment.left)
		testLabel.position = SCNVector3(x: 0.1, y: 0.65, z: 0)
		panelNode.addChildNode(testLabel)
		
		var testLabel2 = SCNLabel(text: "-", scale: 0.05, align: alignment.left)
		testLabel2.position = SCNVector3(x: 0.1, y: -0.65, z: 0)
		testLabel2.name = "label.speed"
		panelNode.addChildNode(testLabel2)
		
		self.addChildNode(panelNode)
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