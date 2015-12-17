
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Panel : SCNNode
{
	var isEnabled:Bool = false
	
	override init()
	{
		super.init()
	}
	
	func enable()
	{
		isEnabled = true
	}
	
	func disable()
	{
		isEnabled = false
	}
	
	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}