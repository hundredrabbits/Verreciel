//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNProgressBar : SCNNode
{
	var percent:CGFloat = 0
	var progressLine:SCNLine!
	var remainingLine:SCNLine!
	var width:CGFloat = 0
	
	init(width:CGFloat)
	{
		super.init()
		self.width = width
		
		addGeometry()
	}
	
	func addGeometry()
	{
		progressLine = SCNLine(nodeA: SCNVector3(0,0,0), nodeB: SCNVector3(0,0,0), color: red)
		self.addChildNode(progressLine)
		remainingLine = SCNLine(nodeA: SCNVector3(0,0,0), nodeB: SCNVector3(width,0,0), color: grey)
		self.addChildNode(remainingLine)
	}
	
	func update(percent:CGFloat)
	{
		let to = width * (percent/100)
		
		progressLine.geometry = SCNLine(nodeA: SCNVector3(0,0,0), nodeB: SCNVector3(to,0,0), color: red).geometry
		remainingLine.geometry = SCNLine(nodeA: SCNVector3(to,0,0), nodeB: SCNVector3(width,0,0), color: grey).geometry
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}