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
		self.eulerAngles.x = (degToRad(templates.monitorsAngle))
		
		nameLabel.update("--")
		detailsLabel.update(name!)
	}
	
	override func refresh()
	{
		nameLabel.update(cyan)
		delay(2, block: { self.nameLabel.update(white) })
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