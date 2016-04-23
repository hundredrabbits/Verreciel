
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
		
		let aim = Empty()
		var i = 0
		while i < 3
		{
			let test = SCNLine(vertices: [SCNVector3(0,templates.radius * -2,0.75), SCNVector3(0,templates.radius * -2,0.95)], color: white)
			test.eulerAngles.y = (degToRad(CGFloat(120 * i)))
			aim.addChildNode(test)
			aim.eulerAngles.y = degToRad(240)
			i += 1
		}
		root.addChildNode(aim)
	}
	
	override func whenRenderer()
	{
		super.whenRenderer()
		
		if thruster.speed > 0 {
			root.updateChildrenColors(white)
		}
		else{
			root.updateChildrenColors(grey)
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}