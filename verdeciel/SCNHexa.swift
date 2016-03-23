
//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNHexa : SCNNode
{
	init(radius:CGFloat, color:UIColor = white)
	{
		super.init()
		
		addChildNode(SCNLine(nodeA: SCNVector3(0,radius,0), nodeB: SCNVector3(radius/2,radius/2,0), color: color))
		addChildNode(SCNLine(nodeA: SCNVector3(radius/2,-radius/2,0), nodeB: SCNVector3(radius/2,radius/2,0), color: color))
		addChildNode(SCNLine(nodeA: SCNVector3(radius/2,-radius/2,0), nodeB: SCNVector3(0,-radius,0), color: color))
		
		addChildNode(SCNLine(nodeA: SCNVector3(0,radius,0), nodeB: SCNVector3(-radius/2,radius/2,0), color: color))
		addChildNode(SCNLine(nodeA: SCNVector3(-radius/2,-radius/2,0), nodeB: SCNVector3(-radius/2,radius/2,0), color: color))
		addChildNode(SCNLine(nodeA: SCNVector3(-radius/2,-radius/2,0), nodeB: SCNVector3(0,-radius,0), color: color))
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}