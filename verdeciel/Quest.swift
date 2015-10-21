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
	var predicate:() -> Bool
	var result:() -> Void
	var isCompleted:Bool = false
	
	init(name:String, predicate:() -> Bool, result: () -> Void )
	{
		self.name = name
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