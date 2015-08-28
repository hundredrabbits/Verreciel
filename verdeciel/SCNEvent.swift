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
	var isTargetted:Bool = false
	
	var targetNode:SCNNode!
	
	init(newName:String,x:Float,z:Float,size:Float,range:Float,type:eventTypes,frequency:String)
	{
		super.init()
		name = newName
		self.x = x
		self.z = z
		self.type = type
		
		let frequencies = Array(frequency)
		
		self.freq1 = String(frequencies[0]).toInt()!
		self.freq2 = String(frequencies[1]).toInt()!
		self.freq3 = String(frequencies[2]).toInt()!
		self.freq4 = String(frequencies[3]).toInt()!
		
		// Event Size
		let displaySize = size/10
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:displaySize,z:0),nodeB: SCNVector3(x:displaySize,y:0,z:0),color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:-displaySize,y:0,z:0),nodeB: SCNVector3(x:0,y:-displaySize,z:0),color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:displaySize,z:0),nodeB: SCNVector3(x:-displaySize,y:0,z:0),color: grey))
		self.addChildNode(SCNLine(nodeA: SCNVector3(x:displaySize,y:0,z:0),nodeB: SCNVector3(x:0,y:-displaySize,z:0),color: grey))
		
		// Add interactible events on the radar
		self.geometry = SCNPlane(width: 1, height: 1)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		update()
	}
	
	func update()
	{
		if type == eventTypes.station {
			typeString = "station"
		}
		else if type == eventTypes.star {
			typeString = "star"
		}
		else{
			typeString = "unknown"
		}
		
		for node in self.childNodes
		{
			let line = node as! SCNLine
			if isKnown == true {
				line.color(white)
			}
			else{
				line.color(grey)
			}
		}
	}
	
	func touch()
	{
		radar.addTarget(self)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}