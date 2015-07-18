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
		universeSetup()
		timeSetup()
	}
	
	func timeSetup()
	{
		time = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("eventTrigger"), userInfo: nil, repeats: true)
	}
	
	func universeSetup()
	{
		radar.addEvent(SCNEvent(newName:"su-ar37",x:0,z:1,size:0.5,range:7,type:eventTypes.sentry,frequency:"2231"))
		radar.addEvent(SCNEvent(newName:"home",x:0,z:0,size:1,range:5,type:eventTypes.station,frequency:"2231"))
	}
	
	func eventTrigger()
	{
		// Update location
		
		if thruster.knob.value > 0 {
			radar.update()
		}
		
		if( capsule.oxygen < 47 ){
			player.health -= 1
			player.update()
		}
		
		monitor.update()
	}
}