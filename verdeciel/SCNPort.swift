//
//  SCNToggle.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPort : SCNNode
{
	var outline1:SCNLine!
	var outline2:SCNLine!
	var outline3:SCNLine!
	var outline4:SCNLine!
	
	var polarity:Bool = false
	var isSelected:Bool = false
	
	init(polarity:Bool)
	{
		self.polarity = polarity
		super.init()
		
		addGeometry()
		update()
	}
	
	func addGeometry()
	{
		self.geometry = SCNPlane(width: 1, height: 1)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		let radius:Float = 0.1
		
		outline1 = SCNLine(nodeA: SCNVector3(x: 0, y: radius, z: 0),nodeB: SCNVector3(x: radius, y: 0, z: 0),color:white)
		outline2 = SCNLine(nodeA: SCNVector3(x: radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: -radius, z: 0),color:white)
		outline3 = SCNLine(nodeA: SCNVector3(x: 0, y: -radius, z: 0),nodeB: SCNVector3(x: -radius, y: 0, z: 0),color:white)
		outline4 = SCNLine(nodeA: SCNVector3(x: -radius, y: 0, z: 0),nodeB: SCNVector3(x: 0, y: radius, z: 0),color:white)
		
		self.addChildNode(outline1)
		self.addChildNode(outline2)
		self.addChildNode(outline3)
		self.addChildNode(outline4)
	}
	
	func touch()
	{
		isSelected = true
		update()
	}
	
	func update()
	{
		if( isSelected == true ){
			outline1.color(grey)
			outline2.color(grey)
			outline3.color(grey)
			outline4.color(grey)
		}
		else if( polarity == true ){
			outline1.color(cyan)
			outline2.color(cyan)
			outline3.color(cyan)
			outline4.color(cyan)
		}
		else{
			outline1.color(red)
			outline2.color(red)
			outline3.color(red)
			outline4.color(red)
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}