//
//  user.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2014-10-21.
//  Copyright (c) 2014 XXIIVV. All rights reserved.
//

import Foundation

extension GameViewController {

	func userSetup()
	{
		NSLog("USER   | Setup")
		userStart()
	}
	
	func userStart()
	{
		NSLog("USER   | Start")
		
		var userNew:NSMutableDictionary = [:]
		
		userNew["general"]   = ["time" : 0,"capsule":""]
		userNew["power"]     = ["active" : 0]
		userNew["thrusters"] = ["active" : 0, "speed":0]
		userNew["shield"]    = ["active" : 0]
		userNew["position"]  = ["x" : 0,"y" : 0,"z" : 0]
		
		NSLog("%@",userNew)
	}
	
}