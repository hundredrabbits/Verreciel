//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MonitorJourney : Monitor
{
	var distance:Float = 0
	
	override func installedFixedUpdate()
	{
		label.update("\(Int(distance/100))")
	}
	
	override func onInstallationBegin()
	{
		player.lookAt(deg: -90)
	}
}