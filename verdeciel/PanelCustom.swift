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
	// Ports
	
	var inputLabel:SCNLabel!
	var input:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "custom"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		
		update()
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.1, y: highNode[7].y * scale, z: 0)
		
		inputLabel = SCNLabel(text: "Undocked", scale: 0.1, align: alignment.left)
		inputLabel.position = SCNVector3(x: lowNode[7].x * scale + 0.3, y: highNode[7].y * scale, z: 0)
		
		self.addChildNode(input)
		self.addChildNode(inputLabel)
		
		// Undock
		
		let undockLabel = SCNLabel(text: "Undock", scale: 0.1, align: alignment.right, color:red)
		undockLabel.position = SCNVector3(x: lowNode[0].x * scale, y: highNode[0].y * scale, z: 0)
		self.addChildNode(undockLabel)
		
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale - 0.25, z: 0),nodeB: SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale - 0.25, z: 0),color:grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * -scale + 0.25, z: 0),nodeB: SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * -scale + 0.25, z: 0),color:grey))
		
		let statusLabel = SCNLabel(text: "connected..", scale: 0.1, align: alignment.left, color:grey)
		statusLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * -scale, z: 0)
		self.addChildNode(statusLabel)
		
	}
	
	func dock(event:Event)
	{
		print("Load interface for \(event.name!)")
		print(event.interface)
		
		inputLabel.update(event.name!)
		
		self.addChildNode(event.interface)
		
//		self.updateInterface(event.interface)
	}
	
	override func listen(event:Event)
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}