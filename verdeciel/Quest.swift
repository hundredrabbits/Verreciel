//
//  SCNCommand.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Quest
{
	var name:String!
	var event:Event!
	var type:missions
	var isUnlocked:Bool = false
	
	init(type:missions = missions.none,event:Event = Event())
	{
		self.event = event
		self.type = type
		
		createName()
	}
	
	func createName()
	{
		name = "\(type) \(event.name!)"
	}
}