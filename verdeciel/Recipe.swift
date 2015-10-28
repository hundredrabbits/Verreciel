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

class Recipe
{
	var name:String!
	var requirements:Array<Event> = []
	var result:Event!
	
	init(name:String, requirements:Array<Event>, result:Event)
	{
		self.name = name
		self.requirements = requirements
		self.result = result
	}
	
	func validate(inputs:Array<Event>)
	{
		for requirement in requirements {
			for input in inputs {
				if input == requirement {
					print("requirement: \(requirement) -> Fullfiled")
				}
				else {
					print("requirement: \(requirement) -> Missing")
				}
			}
		}
	}
}