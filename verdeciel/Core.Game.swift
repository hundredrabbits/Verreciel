
//  Created by Devine Lu Linvega on 2015-12-18.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreGame
{
	var time:Float = 0
	
	init()
	{
		NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(self.onTic), userInfo: nil, repeats: true)
		NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.onSeconds), userInfo: nil, repeats: true)
	}
	
	func start()
	{
		universe.whenStart()
		capsule.whenStart()
		player.whenStart()
		space.whenStart()
		helmet.whenStart()
	}
	
	@objc func onSeconds()
	{
		capsule.onSeconds()
		missions.refresh()
	}
	
	@objc func onTic()
	{
		time += 1
		space.whenStart()
	}
}