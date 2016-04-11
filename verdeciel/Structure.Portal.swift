//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructurePortal : Structure
{
	let nodes:Int = 52
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let value1:Float = 5
			
		var i = 0
		while i < nodes {
			let node = SCNNode()
			node.addChildNode(SCNLine(nodeA: SCNVector3(-value1,0 * 3,0), nodeB: SCNVector3(0,0/2,value1), color: red))
			root.addChildNode(node)
			node.eulerAngles.y = (degToRad(CGFloat(i * (360/nodes))))
			i += 1
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}