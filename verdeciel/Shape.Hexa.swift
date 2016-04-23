
//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class ShapeHexa : Empty
{
	init(size:CGFloat, color:UIColor = white)
	{
		super.init()
		
		addChildNode(SCNLine(vertices: [SCNVector3(0,size,0), SCNVector3(size/2,size/2,0), SCNVector3(size/2,-size/2,0), SCNVector3(size/2,size/2,0), SCNVector3(size/2,-size/2,0), SCNVector3(0,-size,0), SCNVector3(0,size,0), SCNVector3(-size/2,size/2,0), SCNVector3(-size/2,-size/2,0), SCNVector3(-size/2,size/2,0), SCNVector3(-size/2,-size/2,0), SCNVector3(0,-size,0)], color: color))
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}