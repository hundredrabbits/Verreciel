
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
		label.update(name!)
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