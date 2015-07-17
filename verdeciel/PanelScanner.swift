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
		let scale:Float = 0.8
		
		// Left Side
		val2Right = line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: -0.25, y: 0.25, z: 0))
		val2Left = line(SCNVector3(x: -0.25, y: 0.25, z: 0), SCNVector3(x: -0.5, y: 0, z: 0))
		val1Right = line(SCNVector3(x: -0.5, y: 0, z: 0), SCNVector3(x: -0.75, y: 0.25, z: 0))
		val1Left = line(SCNVector3(x: -0.75, y: 0.25, z: 0), SCNVector3(x: -1, y: 0, z: 0))
		
		// Right Size
		val3Left = line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0.25, y: 0.25, z: 0))
		val3Right = line(SCNVector3(x: 0.25, y: 0.25, z: 0), SCNVector3(x: 0.5, y: 0, z: 0))
		val4Left = line(SCNVector3(x: 0.5, y: 0, z: 0), SCNVector3(x: 0.75, y: 0.25, z: 0))
		val4Right = line(SCNVector3(x: 0.75, y: 0.25, z: 0), SCNVector3(x: 1, y: 0, z: 0))
		
		self.addChildNode(val2Right)
		self.addChildNode(val2Left)
		self.addChildNode(val1Right)
		self.addChildNode(val1Left)
		self.addChildNode(val3Right)
		self.addChildNode(val3Left)
		self.addChildNode(val4Right)
		self.addChildNode(val4Left)
		
		var nameLabel = SCNLabel(text: "scanner", scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: -0.5, z: 0)
		nameLabel.name = "label.navigation"
		self.addChildNode(nameLabel)
	}
	
	func update()
	{
		if radio.target == nil { return }
		
		let val1 = Float(abs(radio.freq1 - radar.target.freq1))
		let val2 = Float(abs(radio.freq2 - radar.target.freq2))
		let val3 = Float(abs(radio.freq3 - radar.target.freq3))
		let val4 = Float(abs(radio.freq4 - radar.target.freq4))
		
		let avg12:Float = (val1+val2)/2/4
		let avg23:Float = (val2+val3)/2/4
		let avg34:Float = (val3+val4)/2/4
	
		// Left Side
		val2Right.geometry = line(SCNVector3(x: 0, y: avg23/4, z: 0), SCNVector3(x: -0.25, y: val2/4, z: 0)).geometry
		val2Left.geometry = line(SCNVector3(x: -0.25, y: val2/4, z: 0), SCNVector3(x: -0.5, y: avg12/4, z: 0)).geometry
		val1Right.geometry = line(SCNVector3(x: -0.5, y: avg12/4, z: 0), SCNVector3(x: -0.75, y: val1/4, z: 0)).geometry
		val1Left.geometry = line(SCNVector3(x: -0.75, y: val1/4, z: 0), SCNVector3(x: -1, y: 0, z: 0)).geometry
		
		// Right Size
		val3Left.geometry = line(SCNVector3(x: 0, y: avg23/4, z: 0), SCNVector3(x: 0.25, y: val3/4, z: 0)).geometry
		val3Right.geometry = line(SCNVector3(x: 0.25, y: val3/4, z: 0), SCNVector3(x: 0.5, y: avg34/4, z: 0)).geometry
		val4Left.geometry = line(SCNVector3(x: 0.5, y: avg34/4, z: 0), SCNVector3(x: 0.75, y: val4/4, z: 0)).geometry
		val4Right.geometry = line(SCNVector3(x: 0.75, y: val4/4, z: 0), SCNVector3(x: 1, y: 0, z: 0)).geometry
	}
	
	func touch()
	{
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}