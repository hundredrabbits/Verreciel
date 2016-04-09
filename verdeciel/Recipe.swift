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
	
	init(ingredients:Array<Event>, result:Event)
	{
		self.ingredients = ingredients
		self.result = result
	}
	
	func isValid(inputs:Array<Event>) -> Bool
	{
		// Check if ingredients are all inputs
		for ingredient in ingredients {
			var isFound:Bool = false
			for input in inputs {
				if input.name == ingredient.name { isFound = true }
			}
			if isFound == false { return false }
		}
		
		// Check if inputs are all ingredients
		for input in inputs {
			var isFound:Bool = false
			for ingredient in ingredients {
				if input.name == ingredient.name { isFound = true }
			}
			if isFound == false { return false }
		}
		return true
	}
}