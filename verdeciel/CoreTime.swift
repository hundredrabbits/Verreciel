//
//  CoreTime.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-18.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreTime : NSObject
{
	var time:NSTimer!
	
	override init()
	{
		super.init()
		
	}
	
	func start()
	{
		let eventSelector = Selector("tic")
		time = NSTimer.scheduledTimerWithTimeInterval(0.075, target: self, selector: eventSelector, userInfo: nil, repeats: true)
	}
	
	func tic()
	{
		universe.update()
	
		space.update()
		
		battery.tic()
		
		pilot.tic()
		radar.tic()
		monitor.tic()
		
		capsule.tic()
		
		thruster.tic()
		
		player.tic()
	}
}