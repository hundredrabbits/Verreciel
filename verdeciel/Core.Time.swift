//  Created by Devine Lu Linvega on 2015-07-18.
//  Copyright (c) 2015 XXIIVV. All rights reserved.


import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreTime : NSObject
{
	var elapsed:Float = 0
	
	override init()
	{
		super.init()
	}
	
	func start()
	{
		NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("tic"), userInfo: nil, repeats: true)
		NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("onSeconds"), userInfo: nil, repeats: true)
	}
	
	func onSeconds()
	{
		game.onSeconds()
		capsule.onSeconds()
	}
	
	func tic()
	{
		elapsed += 1
	}
}