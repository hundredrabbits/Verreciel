
//  Created by Devine Lu Linvega on 2015-12-18.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Item : Event
{
	var type:ItemTypes!
	var location:Location!
	
	init(name:String = "",type:ItemTypes = ItemTypes.generic, location:Location! = nil, note:String = "", isQuest:Bool = false)
	{
		super.init()
		
		self.name = name
		self.type = type
		self.details = details
		self.isQuest = isQuest
		self.location = location
	}
	
	init(like:Item)
	{
		super.init()
		
		self.name = like.name
		self.type = like.type
		self.details = like.details
		self.isQuest = like.isQuest
	}

	required init(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}
