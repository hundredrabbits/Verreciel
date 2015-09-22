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
		let eventSelector = Selector("tic")
		time = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: eventSelector, userInfo: nil, repeats: true)
	}
	
	func tic()
	{
//		radar.update()
		thruster.update()
		
		if( capsule.oxygen < 10 && player.health > 0 ){
			player.health -= 1
			player.update()
		}
		monitor.update()
		space.update()
	}
}