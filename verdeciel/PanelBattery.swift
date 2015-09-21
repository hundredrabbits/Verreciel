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

class PanelBattery : SCNNode
{
	var nameLabel = SCNLabel(text: "")
	
	// Ports
	
	var output1:SCNPort!
	var output2:SCNPort!
	var output3:SCNPort!
	var output4:SCNPort!
	
	override init()
	{
		super.init()
		name = "battery"
		addInterface()
		
	}
	
	func addInterface()
	{
		nameLabel = SCNLabel(text: self.name!)
		self.addChildNode(nameLabel)
	}
	
	func touch(knobId:String)
	{
		
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}