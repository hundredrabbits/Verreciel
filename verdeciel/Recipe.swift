//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Recipe
{
	var name:String!
	var ingredients:Array<Event> = []
	var result:Event!
	
	init(name:String, ingredients:Array<Event>, result:Event)
	{
		self.name = name
		self.ingredients = ingredients
		self.result = result
	}
	
	func isValid(inputs:Array<Event>) -> Bool
	{
		for ingredient in ingredients {
			var isFound:Bool = false
			for input in inputs {
				if input == ingredient { isFound = true }
			}
			if isFound == false {
				print("missing \(ingredient.name)")
				return false
			}
		}
		return true
	}
}