
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
			test.eulerAngles.y = (degToRad(Float(120 * i)))
			aim.addChildNode(test)
			aim.eulerAngles.y = degToRad(0)
			i += 1
		}
		root.addChildNode(aim)
	}
	
	override func whenSecond()
	{
		super.whenSecond()
		
		if thruster.speed > 0 {
			root.updateChildrenColors(white)
		}
		else{
			root.updateChildrenColors(grey)
		}
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		self.eulerAngles.y = degToRad(floor((radToDeg(player.eulerAngles.y)+22.5)/45) * 45)
		SCNTransaction.commit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
