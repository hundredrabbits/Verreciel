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

class PanelCustom : Panel
{
	var content:SCNNode!
	
	var undockButton:SCNTrigger!
	var statusLabel:SCNLabel!
	var undockButtonLabel:SCNLabel!
	
	var dockingStatus:Int = 0
	var dockingTimer:NSTimer!
	
	// Ports
	
	var dockNameLabel:SCNLabel!
	
	override init()
	{
		super.init()
		
		name = "custom"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		content = SCNNode()
		self.addChildNode(content)
		
		update()
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		dockNameLabel = SCNLabel(text: "Undocked", scale: 0.1, align: alignment.left)
		dockNameLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale, z: 0)

		self.addChildNode(dockNameLabel)
		
		// Undock
		
		statusLabel = SCNLabel(text: "trading..", scale: 0.1, align: alignment.left, color:grey)
		statusLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * -scale, z: 0)
		self.addChildNode(statusLabel)
		
		undockButtonLabel = SCNLabel(text: "Undock", scale: 0.1, align: alignment.right, color:red)
		undockButtonLabel.position = SCNVector3(x: lowNode[0].x * scale, y: highNode[0].y * scale, z: 0)
		self.addChildNode(undockButtonLabel)
		
		undockButton = SCNTrigger(host: self, size: CGSize(width: 1.5, height: 0.7), operation: false)
		undockButton.position = SCNVector3(x: lowNode[0].x - 1, y: highNode[0].y * scale, z: 0)

		self.addChildNode(undockButton)
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale - 0.25, z: 0),nodeB: SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale - 0.25, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * -scale + 0.25, z: 0),nodeB: SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * -scale + 0.25, z: 0),color:grey))
	}
	
	override func bang(param:Bool)
	{
		touch()
	}
	
	override func touch()
	{
		undock()
	}
	
	func dock(event:Event)
	{
		dockNameLabel.update(event.name!)
		content.addChildNode(event.interface)
	}
	
	func undock()
	{
		content.empty()
		player.alert("<undocking>")
		statusLabel.update("undocking")
		undockButton.opacity = 0
		undockButtonLabel.opacity = 0
		
		dockingTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("undocking"), userInfo: nil, repeats: true)
	}
	
	func undocking()
	{
		dockingStatus += Int(arc4random_uniform(7))
		
		if dockingStatus >= 100 {
			dockingTimer.invalidate()
			dockingStatus = 0
			undockingComplete()
			statusLabel.update("> in flight")
		}
		else{
			statusLabel.update("progress \(dockingStatus)%")
		}
	}
	
	func undockingComplete()
	{
		dockNameLabel.update("")
		player.clearAlert()
		player.message("in flight")
		dockingTimer.invalidate()
		capsule.undock()
	}
	
	override func listen(event:Event)
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}