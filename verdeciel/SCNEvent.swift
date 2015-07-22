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
	var x:Float!
	var z:Float!
	var type:eventTypes!
	var	typeString:String!
	
	var freq1:Int = 0
	var freq2:Int = 0
	var freq3:Int = 0
	var freq4:Int = 0
	
	var isKnown:Bool = false
	
	init(newName:String,x:Float,z:Float,size:Float,range:Float,type:eventTypes,frequency:String)
	{
		super.init()
		name = newName
		self.x = x
		self.z = z
		self.type = type
		
		let frequencies = Array(frequency)
		/*
		self.freq1 = Int(String(frequencies[0]))
		self.freq2 = Int(String(frequencies[1]))
		self.freq3 = Int(String(frequencies[2]))
		self.freq4 = Int(String(frequencies[3]))
*/
		
		var eventColor = UIColor.grayColor()
		
		if type == eventTypes.station {
			eventColor = cyan
			typeString = "station"
		}
		else if type == eventTypes.star {
			eventColor = red
			typeString = "star"
		}
		else{
			typeString = "unknown"		
		}
		
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
		
		let eventLabel = SCNLabel(text: newName, scale: 0.075, align: alignment.left)
		eventLabel.position = SCNVector3(x: 0.25, y: 0, z: 0)
		self.addChildNode(eventLabel)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}