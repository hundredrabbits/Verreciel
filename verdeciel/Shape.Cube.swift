//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class ShapeCube : Empty
{
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	var line5:SCNLine!
	var line6:SCNLine!
	var line7:SCNLine!
	var line8:SCNLine!
	var line9:SCNLine!
	var line10:SCNLine!
	var line11:SCNLine!
	var line12:SCNLine!
	
	init(size:CGFloat, color:UIColor = white)
	{
		super.init()
		
		line1 = SCNLine(vertices: [SCNVector3(size,size,size), SCNVector3(-size,size,size)], color: color)
		self.addChildNode(line1)
		line2 = SCNLine(vertices: [SCNVector3(size,size,-size), SCNVector3(-size,size,-size)], color: color)
		self.addChildNode(line2)
		line3 = SCNLine(vertices: [SCNVector3(size,size,size), SCNVector3(size,size,-size)], color: color)
		self.addChildNode(line3)
		line4 = SCNLine(vertices: [SCNVector3(-size,size,size), SCNVector3(-size,size,-size)], color: color)
		self.addChildNode(line4)
		
		line5 = SCNLine(vertices: [SCNVector3(size,-size,size), SCNVector3(-size,-size,size)], color: color)
		self.addChildNode(line5)
		line6 = SCNLine(vertices: [SCNVector3(size,-size,-size), SCNVector3(-size,-size,-size)], color: color)
		self.addChildNode(line6)
		line7 = SCNLine(vertices: [SCNVector3(size,-size,size), SCNVector3(size,-size,-size)], color: color)
		self.addChildNode(line7)
		line8 = SCNLine(vertices: [SCNVector3(-size,-size,size), SCNVector3(-size,-size,-size)], color: color)
		self.addChildNode(line8)
		
		line9 = SCNLine(vertices: [SCNVector3(size,size,size), SCNVector3(size,-size,size)], color: color)
		self.addChildNode(line9)
		line10 = SCNLine(vertices: [SCNVector3(size,size,-size), SCNVector3(size,-size,-size)], color: color)
		self.addChildNode(line10)
		line11 = SCNLine(vertices: [SCNVector3(-size,size,-size), SCNVector3(-size,-size,-size)], color: color)
		self.addChildNode(line11)
		line12 = SCNLine(vertices: [SCNVector3(-size,size,size), SCNVector3(-size,-size,size)], color: color)
		self.addChildNode(line12)
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
