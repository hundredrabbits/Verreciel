
//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNOcta : Empty
{
	var mesh:SCNLine!
	
	init(size:CGFloat, color:UIColor = white, eulerAngles:SCNVector3! = SCNVector3(0,0,0))
	{
		super.init()
		
		mesh = SCNLine(vertices: [SCNVector3(0,size,0), SCNVector3(-size,0,size), SCNVector3(0,size,0), SCNVector3(size,0,size), SCNVector3(0,size,0), SCNVector3(-size,0,-size), SCNVector3(0,size,0), SCNVector3(size,0,-size), SCNVector3(0,-size,0), SCNVector3(-size,0,size), SCNVector3(0,-size,0), SCNVector3(size,0,size), SCNVector3(0,-size,0), SCNVector3(-size,0,-size), SCNVector3(0,-size,0), SCNVector3(size,0,-size)], color: color)
		
		self.eulerAngles = eulerAngles
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}