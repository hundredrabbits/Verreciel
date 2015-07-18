//
//  PanelConsole.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelConsole : SCNNode
{
	var consoleLine1:SCNLabel!
	var consoleLine2:SCNLabel!
	var consoleLine3:SCNLabel!
	var consoleLine4:SCNLabel!
	var consoleLine5:SCNLabel!
	var consoleLine6:SCNLabel!
	var consoleLine7:SCNLabel!
	var consoleLine8:SCNLabel!
	
	var lines:Array<String> = ["","","","","","","",""]
	
	override init()
	{
		super.init()
		name = "console"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
	}
	
	func addLine(line:String)
	{
		lines.append(line)
		if lines.count > 8 { lines.removeAtIndex(0) }
		update()
	}
	
	func addInterface()
	{
		let scale:Float = 0.8
		
		self.addChildNode(line(SCNVector3(x: highNode[7].x * scale, y: highNode[7].y * scale - 0.25, z: 0),SCNVector3(x: highNode[0].x * scale, y: highNode[7].y * scale - 0.25, z: 0)))
		
		let titleLabel = SCNLabel(text: "console", scale: 0.1, align: alignment.left)
		titleLabel.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale, z: 0)
		self.addChildNode(titleLabel)
		
		consoleLine1 = SCNLabel(text: "> ", scale: 0.1, align: alignment.left)
		consoleLine1.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 0.5, z: 0)
		self.addChildNode(consoleLine1)
		
		consoleLine2 = SCNLabel(text: "> ", scale: 0.1, align: alignment.left)
		consoleLine2.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 0.75, z: 0)
		self.addChildNode(consoleLine2)
		
		consoleLine3 = SCNLabel(text: "> ", scale: 0.1, align: alignment.left)
		consoleLine3.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 1, z: 0)
		self.addChildNode(consoleLine3)
		
		consoleLine4 = SCNLabel(text: "> ", scale: 0.1, align: alignment.left)
		consoleLine4.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 1.25, z: 0)
		self.addChildNode(consoleLine4)
		
		consoleLine5 = SCNLabel(text: "> ", scale: 0.1, align: alignment.left)
		consoleLine5.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 1.5, z: 0)
		self.addChildNode(consoleLine5)
		
		consoleLine6 = SCNLabel(text: "> ", scale: 0.1, align: alignment.left)
		consoleLine6.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 1.75, z: 0)
		self.addChildNode(consoleLine6)
		
		consoleLine7 = SCNLabel(text: "> ", scale: 0.1, align: alignment.left)
		consoleLine7.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 2, z: 0)
		self.addChildNode(consoleLine7)
		
		consoleLine8 = SCNLabel(text: "> ", scale: 0.1, align: alignment.left)
		consoleLine8.position = SCNVector3(x: lowNode[7].x * scale, y: highNode[7].y * scale - 2.25, z: 0)
		self.addChildNode(consoleLine8)
	}
	
	func touch(knobId:String)
	{
	}
	
	func update()
	{
		consoleLine1.update("  \(lines[0])")
		consoleLine2.update("  \(lines[1])")
		consoleLine3.update("  \(lines[2])")
		consoleLine4.update("  \(lines[3])")
		consoleLine5.update("  \(lines[4])")
		consoleLine6.update("  \(lines[5])")
		consoleLine7.update("  \(lines[6])")
		consoleLine8.update("> \(lines[7])")
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}