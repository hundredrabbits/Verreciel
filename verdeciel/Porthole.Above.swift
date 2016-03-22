
//  Created by Devine Lu Linvega on 2016-03-22.
//  Copyright © 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelAbove : Panel
{
	override init()
	{
		super.init()
		
		let aim = SCNNode()
		var i = 0
		while i < 3
		{
			let test = SCNLine(nodeA: SCNVector3(0,templates.radius * -2,0.75), nodeB: SCNVector3(0,templates.radius * -2,0.95), color: white)
			test.eulerAngles.y = Float(degToRad(CGFloat(120 * i)))
			aim.addChildNode(test)
			i += 1
		}
		root.addChildNode(aim)
	}
	
	override func fixedUpdate()
	{
		if thruster.speed > 0 {
			root.eulerAngles.y += Float(degToRad(CGFloat(thruster.actualSpeed/5.0)))
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}