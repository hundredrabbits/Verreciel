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

class SCNProgressBar : SCNNode
{
	var percent:CGFloat = 0
	var progressLine:SCNLine!
	var width:CGFloat = 0
	
	init(width:CGFloat)
	{
		super.init()
		self.width = width
		
		addGeometry()
	}
	
	func addGeometry()
	{
		progressLine = SCNLine(nodeA: SCNVector3((-width/2)+0.1,0,0), nodeB: SCNVector3((-width/2)+1,0,0), color: red)
		self.addChildNode(progressLine)
		
		self.addChildNode(SCNLine(nodeA: SCNVector3(-width/2,0.1,0), nodeB: SCNVector3(width/2,0.1,0), color: white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(-width/2,-0.1,0), nodeB: SCNVector3(width/2,-0.1,0), color: white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(-width/2,0.1,0), nodeB: SCNVector3(-width/2,-0.1,0), color: white))
		self.addChildNode(SCNLine(nodeA: SCNVector3(width/2,0.1,0), nodeB: SCNVector3(width/2,-0.1,0), color: white))
	}
	
	func update(percent:CGFloat)
	{
		let maxWidth = width - 0.2
		let from = -maxWidth/2
		let to = maxWidth * (percent/100)
	
		progressLine.geometry = SCNLine(nodeA: SCNVector3(from,0,0), nodeB: SCNVector3(from + to,0,0), color: red).geometry
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}