//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MonitorComplete : Monitor
{
	var distance:Float = 0
	
	override init()
	{
		super.init()
		
		name = "complete"
		self.eulerAngles.x = Float(degToRad(templates.monitorsAngle))
		
		label.update("--")
		details.update(name!)
	}
	
	override func start()
	{
		super.start()
	}
	
	override func refresh()
	{
		label.update(cyan)
		delay(2, block: { self.label.update(white) })
	}
	
	override func onInstallationBegin()
	{
//		player.lookAt(deg: 90)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}