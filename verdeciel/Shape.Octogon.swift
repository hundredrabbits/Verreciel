
//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class ShapeOctogon : Empty
{
	init(size:CGFloat, color:UIColor = white)
	{
		super.init()
		
		let angle:CGFloat = 1.5
		
		addChildNode(SCNLine(vertices: [SCNVector3(0,0,-size), SCNVector3(size/angle,0,-size/angle), SCNVector3(size/angle,0,-size/angle), SCNVector3(size,0,0), SCNVector3(size,0,0), SCNVector3(size/angle,0,size/angle), SCNVector3(size/angle,0,size/angle), SCNVector3(0,0,size), SCNVector3(0,0,size), SCNVector3(-size/angle,0,size/angle), SCNVector3(-size/angle,0,size/angle), SCNVector3(-size,0,0), SCNVector3(-size,0,0), SCNVector3(-size/angle,0,-size/angle), SCNVector3(-size/angle,0,-size/angle), SCNVector3(0,0,-size)], color: color))
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}