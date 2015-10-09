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
	var statusLabel:SCNLabel!
	var progressBar:SCNProgressBar!
	
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
	
	override func update()
	{
		
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		dockNameLabel = SCNLabel(text: "Undocked", scale: 0.1, align: alignment.left)
		dockNameLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale, z: 0)

		self.addChildNode(dockNameLabel)
		
		progressBar = SCNProgressBar(width: CGFloat(highNode[0].x * scale) * 2)
		progressBar.position = SCNVector3(highNode[7].x * scale,highNode[7].y * scale - 0.25,0)
		self.addChildNode(progressBar)
		
		// Undock
		
		statusLabel = SCNLabel(text: "trading..", scale: 0.1, align: alignment.left, color:grey)
		statusLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * -scale, z: 0)
		self.addChildNode(statusLabel)
		
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
	
	func dock(location:Location)
	{
		dockNameLabel.update(location.name!)
		statusLabel.update(location.interaction)
		content.addChildNode(location.interface)
	}
	
	func undock()
	{
		content.empty()
		statusLabel.update("undocked")
	}
	
	override func listen(event:Event)
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}