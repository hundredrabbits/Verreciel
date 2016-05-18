//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MonitorJourney : Monitor
{
	var distance:Float = 0
	
	override init()
	{
		super.init()
		
		name = "journey"
		self.eulerAngles.x = (degToRad(templates.monitorsAngle))
		
		nameLabel.update("--")
		detailsLabel.update(name!)
	}
	
	override func whenSecond()
	{
		super.whenSecond()
		nameLabel.update("\(Int(distance/100))")
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
