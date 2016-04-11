//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MonitorExploration : Monitor
{
	var distance:Float = 0
	var knownLocations:Int = 0
	
	override init()
	{
		super.init()
		
		name = "exploration"
		self.eulerAngles.x = (degToRad(templates.monitorsAngle))
		
		label.update("--")
		details.update(name!)
	}
	
	override func refresh()
	{
		knownLocations = 0
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
//		player.lookAt(deg: -180)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}