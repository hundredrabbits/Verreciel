//
//  PanelScanner.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-08.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelScanner : SCNNode
{
	var val1Left:SCNNode!
	var val1Right:SCNNode!
	var val2Left:SCNNode!
	var val2Right:SCNNode!
	var val3Left:SCNNode!
	var val3Right:SCNNode!
	var val4Left:SCNNode!
	var val4Right:SCNNode!
	
	override init()
	{
		super.init()
		name = "scanner"
		addInterface()
		
		position = SCNVector3(x: 0, y: -2, z: lowNode[7].z * 0.65)
		rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 0.85))
		
		update()
	}
	
	func addInterface()
	{		
		// Left Side
		val2Right = SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: -0.25, y: 0.25, z: 0),color:white)
		val2Left = SCNLine(nodeA: SCNVector3(x: -0.25, y: 0.25, z: 0), nodeB: SCNVector3(x: -0.5, y: 0, z: 0),color:white)
		val1Right = SCNLine(nodeA: SCNVector3(x: -0.5, y: 0, z: 0), nodeB: SCNVector3(x: -0.75, y: 0.25, z: 0),color:white)
		val1Left = SCNLine(nodeA: SCNVector3(x: -0.75, y: 0.25, z: 0), nodeB: SCNVector3(x: -1, y: 0, z: 0),color:white)
		
		// Right Size
		val3Left = SCNLine(nodeA: SCNVector3(x: 0, y: 0, z: 0), nodeB: SCNVector3(x: 0.25, y: 0.25, z: 0),color:white)
		val3Right = SCNLine(nodeA: SCNVector3(x: 0.25, y: 0.25, z: 0), nodeB: SCNVector3(x: 0.5, y: 0, z: 0),color:white)
		val4Left = SCNLine(nodeA: SCNVector3(x: 0.5, y: 0, z: 0), nodeB: SCNVector3(x: 0.75, y: 0.25, z: 0),color:white)
		val4Right = SCNLine(nodeA: SCNVector3(x: 0.75, y: 0.25, z: 0), nodeB: SCNVector3(x: 1, y: 0, z: 0),color:white)
		
		self.addChildNode(val2Right)
		self.addChildNode(val2Left)
		self.addChildNode(val1Right)
		self.addChildNode(val1Left)
		self.addChildNode(val3Right)
		self.addChildNode(val3Left)
		self.addChildNode(val4Right)
		self.addChildNode(val4Left)
		
		let nameLabel = SCNLabel(text: "scanner", scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: -0.5, z: 0)
		nameLabel.name = "label.navigation"
		self.addChildNode(nameLabel)
	}
	
	func update()
	{
		/*
		var val1 = Float(0)
		var val2 = Float(0)
		var val3 = Float(0)
		var val4 = Float(0)
		
		if radio.target != nil {
			val1 = Float(abs(radio.freq1 - radar.target.freq1))
			val2 = Float(abs(radio.freq2 - radar.target.freq2))
			val3 = Float(abs(radio.freq3 - radar.target.freq3))
			val4 = Float(abs(radio.freq4 - radar.target.freq4))
		}
		
		let avg12:Float = (val1+val2)/2/4
		let avg23:Float = (val2+val3)/2/4
		let avg34:Float = (val3+val4)/2/4
	
		// Left Side
		val2Right.geometry = SCNLine(nodeA: SCNVector3(x: 0, y: avg23/4, z: 0), nodeB: SCNVector3(x: -0.25, y: val2/4, z: 0),color:white).geometry
		val2Left.geometry = SCNLine(nodeA: SCNVector3(x: -0.25, y: val2/4, z: 0), nodeB: SCNVector3(x: -0.5, y: avg12/4, z: 0),color:white).geometry
		val1Right.geometry = SCNLine(nodeA: SCNVector3(x: -0.5, y: avg12/4, z: 0), nodeB: SCNVector3(x: -0.75, y: val1/4, z: 0),color:white).geometry
		val1Left.geometry = SCNLine(nodeA: SCNVector3(x: -0.75, y: val1/4, z: 0), nodeB: SCNVector3(x: -1, y: 0, z: 0),color:white).geometry
		
		// Right Size
		val3Left.geometry = SCNLine(nodeA: SCNVector3(x: 0, y: avg23/4, z: 0), nodeB: SCNVector3(x: 0.25, y: val3/4, z: 0),color:white).geometry
		val3Right.geometry = SCNLine(nodeA: SCNVector3(x: 0.25, y: val3/4, z: 0), nodeB: SCNVector3(x: 0.5, y: avg34/4, z: 0),color:white).geometry
		val4Left.geometry = SCNLine(nodeA: SCNVector3(x: 0.5, y: avg34/4, z: 0), nodeB: SCNVector3(x: 0.75, y: val4/4, z: 0),color:white).geometry
		val4Right.geometry = SCNLine(nodeA: SCNVector3(x: 0.75, y: val4/4, z: 0), nodeB: SCNVector3(x: 1, y: 0, z: 0),color:white).geometry
*/
	}
	
	override func touch()
	{
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}