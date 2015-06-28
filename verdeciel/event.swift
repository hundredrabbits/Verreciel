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
		
		var ratio = CGPoint(x: 0, y: 1)
		
		if user.orientation == 1 { ratio = CGPoint(x: 0.5, y: 0.5) }
		if user.orientation == 2 { ratio = CGPoint(x: 1.0, y: 0.0) }
		if user.orientation == 3 { ratio = CGPoint(x: 0.5, y:-0.5) }
		if user.orientation == 4 { ratio = CGPoint(x: 0.0, y:-1.0) }
		
		if user.orientation == -1{ ratio = CGPoint(x:-0.5, y: 0.5) }
		if user.orientation == -2{ ratio = CGPoint(x:-1.0, y: 0.0) }
		if user.orientation == -3{ ratio = CGPoint(x:-0.5, y:-0.5) }
		if user.orientation == -4{ ratio = CGPoint(x: 0.0, y:-1.0) }
		
		user.z += user.speed * Float(ratio.y)
		user.x += user.speed * Float(ratio.x)
		
		if user.speed > 0 {
			radar.update()
		}
	}
}