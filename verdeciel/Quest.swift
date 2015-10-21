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
	var predicate:() -> Bool
	var isCompleted:Bool = false
	var result:() -> Void
	
	init(type:missions = missions.none, predicate:() -> Bool, name:String, result: () -> Void )
	{
		self.name = name
		self.type = type
		self.predicate = predicate
		self.result = result
	}
	
	func validate()
	{
		if predicate() {
			complete()
		}
	}
	
	func complete()
	{
		if isCompleted == true { return }
		print("Quest complete!")
		isCompleted = true
		self.result()
	}
}