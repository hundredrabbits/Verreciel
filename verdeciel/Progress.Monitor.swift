
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MonitorProgress : Monitor
{
	override func setup()
	{
		name = "progress"
		self.eulerAngles.x = Float(degToRad(templates.monitorsAngle))
	}
	
	override func refresh()
	{
		label.update("4/39")
	}
	
	override func onInstallationBegin()
	{
//		player.lookAt(deg: -270)
	}
}