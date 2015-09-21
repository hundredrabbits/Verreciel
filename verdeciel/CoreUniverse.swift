//
//  CoreUniverse.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-18.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import Foundation

class CoreUniverse
{
	init() // Todo
	{
		radar.addEvent(SCNEvent(newName: "test", x: 0, z: 1, size: 0.5, type: eventTypes.location))
		radar.addEvent(SCNEvent(newName: "home", x: 0, z: 0, size: 1, type: eventTypes.location))
	}
}