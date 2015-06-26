//
//  user.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2014-10-21.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import Foundation

class User
{
	var x:Float = 0
	var z:Float = 0
	var orientation:Float = 0
	var speed:Float = 0
	
	var storage:Dictionary<String,Float> = ["new":0]
	
	init()
	{
		NSLog("USER   | Setup")
		storage["thruster"] = 0
		storage["electric"] = 0
	}	
}