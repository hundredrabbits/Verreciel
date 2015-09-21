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
	
	init(newName:String,x:Float = 0,z:Float = 0,size:Float = 0,range:Float = 0,type:eventTypes = eventTypes.unknown,frequency:String = "")
	{
		super.init()
		self.name = newName
		self.x = x
		self.z = z
		self.type = type
		
		/*
		let frequencies = Array(arrayLiteral: frequency)
		
		self.freq1 = Int(String(frequencies[0]))!
		self.freq2 = Int(String(frequencies[1]))!
		self.freq3 = Int(String(frequencies[2]))!
		self.freq4 = Int(String(frequencies[3]))!

*/
		
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
	
	override func touch()
	{
		radar.addTarget(self)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}