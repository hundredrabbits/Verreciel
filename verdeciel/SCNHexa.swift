
//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNHexa : SCNNode
{
	init(size:CGFloat, color:UIColor = white, eulerAngles:SCNVector3! = SCNVector3(0,0,0))
	{
		super.init()
		
		addChildNode(SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(size/2,size/2,0), color: color))
		addChildNode(SCNLine(nodeA: SCNVector3(size/2,-size/2,0), nodeB: SCNVector3(size/2,size/2,0), color: color))
		addChildNode(SCNLine(nodeA: SCNVector3(size/2,-size/2,0), nodeB: SCNVector3(0,-size,0), color: color))
		
		addChildNode(SCNLine(nodeA: SCNVector3(0,size,0), nodeB: SCNVector3(-size/2,size/2,0), color: color))
		addChildNode(SCNLine(nodeA: SCNVector3(-size/2,-size/2,0), nodeB: SCNVector3(-size/2,size/2,0), color: color))
		addChildNode(SCNLine(nodeA: SCNVector3(-size/2,-size/2,0), nodeB: SCNVector3(0,-size,0), color: color))
		
		self.eulerAngles = eulerAngles
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}