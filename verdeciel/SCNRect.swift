//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNRect : SCNNode
{
	init(size:CGSize, color:UIColor)
	{
		super.init()
		
		addChildNode(SCNLine(vertices: [SCNVector3(-size.width/2,0,size.height/2), SCNVector3(size.width/2,0,size.height/2), SCNVector3(size.width/2,0,size.height/2), SCNVector3(size.width/2,0,-size.height/2), SCNVector3(size.width/2,0,-size.height/2), SCNVector3(-size.width/2,0,-size.height/2), SCNVector3(-size.width/2,0,-size.height/2), SCNVector3(-size.width/2,0,size.height/2)], color: color))
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}