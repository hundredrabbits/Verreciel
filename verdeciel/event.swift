//
//  events.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2014-10-23.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

extension GameViewController
{
	func eventSetup()
	{
		NSLog(" EVENT | Setup")
		
		var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("eventTrigger"), userInfo: nil, repeats: true)
	}
	
	func eventTrigger()
	{
		// Update location
		
		var rightward = (user.orientation / 10)
		
		var forward = 1 - rightward
		
		if user.orientation < 0 { forward = 1 + rightward }
		if user.orientation < -10 { rightward = (2 + rightward) * -1 }
		if user.orientation > 10 { rightward = forward + 1 }
		
		user.z += user.speed * forward
		user.x += user.speed * rightward
		
		if user.speed > 0 {
			radar.update()
		}
	}
}