//
//  SCNRadarEvent.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-26.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNEvent : SCNNode
{
	var eventName:String = ""
	var x:Float!
	var z:Float!
	var type:eventTypes!
	
	init(newName:String,x:Float,z:Float,size:Float,range:Float,type:eventTypes)
	{
		super.init()
		name = newName
		self.x = x
		self.z = z
		self.type = type
		
		var eventColor = UIColor.grayColor()
		
		if type == eventTypes.station { eventColor = cyan }
		if type == eventTypes.star { eventColor = red }
		
		// Event Size
		let displaySize = size/10
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:displaySize,z:0),nodeB: SCNVector3(x:displaySize,y:0,z:0),color: eventColor))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:-displaySize,y:0,z:0),nodeB: SCNVector3(x:0,y:-displaySize,z:0),color: eventColor))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:displaySize,z:0),nodeB: SCNVector3(x:-displaySize,y:0,z:0),color: eventColor))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:displaySize,y:0,z:0),nodeB: SCNVector3(x:0,y:-displaySize,z:0),color: eventColor))
		
		// Range Size
		let rangeSize = range/10
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:rangeSize,z:0),nodeB: SCNVector3(x:rangeSize,y:0,z:0),color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:-rangeSize,y:0,z:0),nodeB: SCNVector3(x:0,y:-rangeSize,z:0),color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:rangeSize,z:0),nodeB: SCNVector3(x:-rangeSize,y:0,z:0),color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:rangeSize,y:0,z:0),nodeB: SCNVector3(x:0,y:-rangeSize,z:0),color: grey))
		
		var eventLabel = SCNLabel(text: newName, scale: 0.075, align: alignment.left)
		eventLabel.position = SCNVector3(x: 0.25, y: 0, z: 0)
		self.addChildNode(eventLabel)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}