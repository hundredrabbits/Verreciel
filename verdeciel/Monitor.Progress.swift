
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MonitorProgress : Monitor
{
	var completed:Int = 0
	
	override init()
	{
		super.init()
		name = "map"
		self.eulerAngles.x = (degToRad(templates.monitorsAngle))
		
		nameLabel.update("--")
		detailsLabel.update(name!)
	}
	
	override func refresh()
	{
		super.refresh()
		
		var totalQuestLocations = 0
		var totalQuestLocations_complete = 0
		
		for location in universe.childNodes as! [Location] {
			if location.isComplete != nil {
				totalQuestLocations += 1
				if location.isComplete == true { totalQuestLocations_complete += 1}
			}
		}
		
		// MARK: Display
		if totalQuestLocations_complete > completed {
			nameLabel.update("\(totalQuestLocations_complete)/\(totalQuestLocations)", color:cyan)
			delay(2, block: { self.nameLabel.update(white) })
			completed = totalQuestLocations_complete
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
