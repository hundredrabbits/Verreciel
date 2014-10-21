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
		
		var airports = ["YYZ": 35, "DUB": "Dublin"]
		
		
		// Shield
		airports["shield"] = ["active" : 1,"":""]
		
		
		
		
		NSLog("%@",airports)
	}
	
}