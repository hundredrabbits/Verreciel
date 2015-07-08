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
	
	func orientationName() -> String
	{
		switch orientation {
			case  0 : return "n"
			case  1 : return "ne"
			case  2 : return "e"
			case  3 : return "se"
			case -1 : return "nw"
			case -2 : return "w"
			case -3 : return "sw"
			default : return "s"
		}
	}
}