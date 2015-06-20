//
//  events.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2014-10-23.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import Foundation

extension GameViewController {
	
	func eventSetup()
	{
		NSLog("EVENT | Setup")
		var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("eventClock"), userInfo: nil, repeats: true)
	}
	
	func eventClock()
	{
		eventTime += user["speed"] as! Int
		if( eventTime > 30){
			eventTrigger()
			eventTime = 0
		}
	}
	
	func eventTrigger()
	{
		NSLog("EVENT | Clock: Trigger")
	}
	
}