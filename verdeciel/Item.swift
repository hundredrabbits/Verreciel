
//  Created by Devine Lu Linvega on 2015-12-18.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Item : Event
{
	var type:itemTypes!
	
	init(newName:String = "",type:itemTypes = itemTypes.unknown, note:String = "", color:UIColor = grey, isQuest:Bool = false)
	{
		super.init()

		self.type = type
	}

	required init(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}
