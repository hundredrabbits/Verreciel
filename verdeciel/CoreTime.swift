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
	var elapsed:Float = 0
	
	override init()
	{
		super.init()
	}
	
	func start()
	{
		time = NSTimer.scheduledTimerWithTimeInterval(0.075, target: self, selector: Selector("tic"), userInfo: nil, repeats: true)
	}
	
	func tic()
	{
		counter = 0
		capsule._fixedUpdate()
		elapsed += 1
	}
}