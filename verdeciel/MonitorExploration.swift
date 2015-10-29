//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MonitorExploration : Monitor
{
	var distance:Float = 0
	
	override func setup()
	{
		name = "exploration"
		self.eulerAngles.x = Float(degToRad(templates.monitorsAngle))
	}
	
	override func installedFixedUpdate()
	{
		var knownLocations:Int = 0
		
		for location in universe.childNodes {
			let locationData = location as! Location
			if locationData.isKnown == true {
				knownLocations += 1
			}
		}
		label.update("\(knownLocations)/\(universe.childNodes.count)")
	}
	
	override func onInstallationBegin()
	{
		player.lookAt(deg: -180)
	}
}