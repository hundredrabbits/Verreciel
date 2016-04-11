//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructureBank : Structure
{
	override init()
	{
		super.init()
		
		var i = 0
		while i < 14 {
			let rect = SCNRect(size:CGSize(width:6,height:6), color:white)
			rect.position.y = Float((Float(i)/2) - 3.5)
			root.addChildNode(rect)
			i += 1
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}