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
		
		nameLabel.update("--")
		detailsLabel.update(name!)
	}
	
	override func refresh()
	{
		var kl = 0
		for location in universe.childNodes as! [Location] {
			if location.isKnown == true {
				kl += 1
			}
		}
		
		// MARK: Display
		if kl > knownLocations {
			nameLabel.update("\(knownLocations)/\(universe.childNodes.count)", color:cyan)
			delay(2, block: { self.nameLabel.update(white) })
			knownLocations = kl
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}