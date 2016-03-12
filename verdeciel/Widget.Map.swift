
//  Created by Devine Lu Linvega on 2015-12-15.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class WidgetMap : Widget
{
	override init()
	{
		super.init()
		
		name = "map"
		info = "[missing text]"
		requirement = ItemTypes.map
		
		label.update(name!)
	}
	
	func hasMap(map:Item) -> Bool
	{
		if port.hasEvent() == false { return false }
		if port.event == map { return true }
		return false
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		
		battery.installMap()
	}

	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}