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

class PanelDock : Panel
{
	var label:SCNLabel!
	
	var dockingStatus:CGFloat = 0
	var dockingTimer:NSTimer!
	var triangle:SCNNode!
	
	override init()
	{
		super.init()
		addInterface()
		self.position = SCNVector3(x: 0, y: 3.3, z: lowNode[7].z * 0.825)
		self.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2 * 0.6))
		self.geometry = SCNPlane(width: 2, height: 2)
		self.geometry?.materials.first?.diffuse.contents = clear
	}
	
	override func start()
	{
		update()
	}
	
	override func update()
	{
		if capsule.dock != nil {
			label.updateWithColor("docked", color: red)
			triangle.updateChildrenColors(red)
		}
		else{
			label.updateWithColor("undocked", color: grey)
			triangle.updateChildrenColors(grey)
		}
	}
	
	func addInterface()
	{
		label = SCNLabel(text: "UNDOCK", scale: 0.1, align: alignment.center, color: red)
		label.position = SCNVector3(0.05,0.35,0)
		self.addChildNode(label)
		
		let size:Float = 0.7
		triangle = SCNNode()
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(size * 0.25,size * 0.75,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(size * -0.25,size * 0.75,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(size,0,0), nodeB: SCNVector3(size * 0.75,0,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(size,0,0), nodeB: SCNVector3(size * 0.75,size * 0.25,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(-size,0,0), nodeB: SCNVector3(size * -0.75,0,0), color: red))
		triangle.addChildNode(SCNLine(nodeA: SCNVector3(-size,0,0), nodeB: SCNVector3(size * -0.75,size * 0.25,0), color: red))
		self.addChildNode(triangle)
	}
	
	override func touch()
	{
		if capsule.dock == nil { return }
		beginUndocking()
	}
	
	func beginUndocking()
	{
		player.alert("<undocking>")
		dockingTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateUndocking"), userInfo: nil, repeats: true)
		triangle.updateChildrenColors(grey)
	}
	
	func updateUndocking()
	{
		dockingStatus += CGFloat(arc4random_uniform(7))
		
		if dockingStatus >= 100 {
			dockingTimer.invalidate()
			dockingStatus = 0
			completeUndocking()
			custom.progressBar.update(0)
		}
		else{
			label.updateWithColor("Undocking \(Int(dockingStatus))%", color: grey)
			custom.progressBar.update(dockingStatus)
		}
	}
	
	func completeUndocking()
	{
		player.clearAlert()
		label.updateWithColor("undocked", color: grey)
		capsule.undock()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}