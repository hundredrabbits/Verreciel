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

class PanelRadiation : Panel
{
	var dockingStatus:CGFloat = 0
	var dockingTimer:NSTimer!
	var triangle:SCNNode!
	
	override func setup()
	{
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		interface.geometry = SCNPlane(width: 2, height: 2)
		interface.geometry?.materials.first?.diffuse.contents = clear
		
		label = SCNLabel(text: "No radiation", scale: 0.1, align: alignment.center, color: red)
		label.position = SCNVector3(0.05,0.35,0)
		interface.addChildNode(label)
		
		let size:Float = 0.7
		triangle = SCNNode()
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(size * 0.25,size * 0.75,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(size * -0.25,size * 0.75,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(size,0,0), nodeB: SCNVector3(size * 0.75,0,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(size,0,0), nodeB: SCNVector3(size * 0.75,size * 0.25,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(-size,0,0), nodeB: SCNVector3(size * -0.75,0,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(-size,0,0), nodeB: SCNVector3(size * -0.75,size * 0.25,0), color: red))
		interface.addChildNode(triangle)
		
		triangle.updateChildrenColors(grey)
		label.updateWithColor("no radiation", color: grey)
		
		self.eulerAngles.x += Float(degToRad(templates.warningsAngle))
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.updateWithColor("--", color: grey)
	}
	
	func update(value:CGFloat)
	{
		if value > 0 {
			let radiationString = String(format: "%.1f", value)
			label.updateWithColor("radiation \(radiationString)%", color: red)
			triangle.updateChildrenColors(red)
		}
		else{
			label.updateWithColor("no radiation", color: grey)
			triangle.updateChildrenColors(grey)
			
		}
		
	}
}