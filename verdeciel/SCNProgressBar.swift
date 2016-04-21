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
	var color:UIColor = red
	
	init(width:CGFloat, color:UIColor = red)
	{
		super.init()
		self.width = width
		self.color = color
		
		addGeometry()
	}
	
	func addGeometry()
	{
		progressLine = SCNLine(vertices: [SCNVector3(0,0,0), SCNVector3(0,0,0)], color: color)
		self.addChildNode(progressLine)
		remainingLine = SCNLine(vertices: [SCNVector3(0,0,0), SCNVector3(width,0,0)], color: grey)
		self.addChildNode(remainingLine)
	}
	
	func update(percent:CGFloat)
	{
		let to = width * (percent/100)
		
		progressLine.geometry = SCNLine(vertices: [SCNVector3(0,0,0), SCNVector3(to,0,0)], color: color).geometry
		remainingLine.geometry = SCNLine(vertices: [SCNVector3(to,0,0), SCNVector3(width,0,0)], color: grey).geometry
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}