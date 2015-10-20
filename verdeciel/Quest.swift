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
	var type:missions
	var target:NSObject!
	var requirement:requirements!
	
	init(type:missions = missions.none,target:NSObject!, requirement:requirements!)
	{
		self.type = type
		self.target = target
		self.requirement = requirement
		
		createName()
	}
	
	func createName()
	{
		var action = "Visit"
		if type == missions.panel { action = "Activate" }
		name = "\(action) \(type)"
	}
	
	func validate()
	{
		if requirement == requirements.isNotNil {
			print("\(requirement)")
			if target == nil{
				print("\(target)")
			}
			else if target != nil {
				print("\(target)")
				complete()
			}
		}
	}
	
	func complete()
	{
		print("Quest complete!")
	}
}