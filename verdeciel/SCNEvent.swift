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
	var type:eventTypes!
	var	typeString:String!
	
	var freq1:Int = 0
	var freq2:Int = 0
	var freq3:Int = 0
	var freq4:Int = 0
	
	var isKnown:Bool = false
	var isTargetted:Bool = false
	
	var targetNode:SCNNode!
	
	var content:Array<SCNEvent>!
	var details:String
	var count:Int
	
	var location = CGPoint()
	
	init(newName:String,location:CGPoint = CGPoint(),size:Float = 0,type:eventTypes,details:String = "", count:Int = 1)
	{
		self.content = []
		self.details = details
		self.count = count
		
		super.init()
		self.name = newName
		self.location = location
		self.type = type
		
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
	
	override func update()
	{
		typeString = "unknown"
		
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