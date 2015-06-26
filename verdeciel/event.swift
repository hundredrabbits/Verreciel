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
		
		var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("eventClock"), userInfo: nil, repeats: true)
	}
	
	func eventClock()
	{
		game.time += 1
		eventTrigger()
	}
	
	func eventTrigger()
	{
		// Update location
		user.z += user.speed
		
		if user.storage["speed"] > 0 {
			panel_radar_update()
		}
		
	}
}