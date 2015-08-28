
//  Created by Devine Lu Linvega on 2015-07-17.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPoly : SCNNode
{
	init(vertices:Array<SCNVector3>, color:UIColor)
	{
		super.init()
		
		self.addChildNode(SCNTriangle(vertices: [vertices[0],vertices[1],vertices[2]], color:color))
		self.addChildNode(SCNTriangle(vertices: [vertices[1],vertices[2],vertices[3]], color:color))
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}