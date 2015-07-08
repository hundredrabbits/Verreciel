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

class PanelBeacon : SCNNode
{	
	override init()
	{
		super.init()
		name = "beacon"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z)
		update()
	}
	
	func addInterface()
	{
		let scale:Float = 0.7
		
		let beaconButton = SCNButton(newName: "beacon")
		self.addChildNode(beaconButton)
		
		let titleLabel = SCNLabel(text: "beacon", scale: 0.1, align: alignment.center)
		titleLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(titleLabel)
		
		let speedValueLabel = SCNLabel(text: "-", scale: 0.1, align: alignment.center)
		speedValueLabel.position = SCNVector3(x: 0, y: lowNode[7].y * scale, z: 0)
		speedValueLabel.name = "label.speed"
		self.addChildNode(speedValueLabel)
	}
	
	func touch()
	{
		update()
	}
	
	func update()
	{
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}