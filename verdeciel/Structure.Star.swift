//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructureStar : Structure
{
	override init()
	{
		super.init()
		
		var value1:Float = 2.75
		
		var i = 0
		while i < 20 {
			value1 -= 0.125
			root.addChildNode(SCNLine(nodeA: SCNVector3(value1 * 1.5,0,0), nodeB: SCNVector3(value1,0,-value1 * 1.5), color: red))
			root.addChildNode(SCNLine(nodeA: SCNVector3(value1 * 1.5,0,0), nodeB: SCNVector3(value1,0,value1 * 1.5), color: red))
			root.addChildNode(SCNLine(nodeA: SCNVector3(-value1 * 1.5,0,0), nodeB: SCNVector3(-value1,0,-value1 * 1.5), color: red))
			root.addChildNode(SCNLine(nodeA: SCNVector3(-value1 * 1.5,0,0), nodeB: SCNVector3(-value1,0,value1 * 1.5), color: red))
			root.addChildNode(SCNLine(nodeA: SCNVector3(value1,0,-value1 * 1.5), nodeB: SCNVector3(-value1,0,-value1 * 1.5), color: red))
			root.addChildNode(SCNLine(nodeA: SCNVector3(value1,0,value1 * 1.5), nodeB: SCNVector3(-value1,0,value1 * 1.5), color: red))
			i += 1
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}