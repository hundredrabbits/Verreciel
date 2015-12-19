
//  Created by Devine Lu Linvega on 2015-12-18.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Item : Event
{
	var type:ItemTypes!
	
	init(name:String = "",type:ItemTypes = ItemTypes.generic, note:String = "", isQuest:Bool = false)
	{
		super.init()
		
		self.name = name
		self.type = type
		self.note = note
		self.isQuest = isQuest
	}

	required init(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}
