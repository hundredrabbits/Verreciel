//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class RecipesLibrary
{
	var horadric:Array<Recipe> = []
	
	init()
	{
		horadric.append( Recipe(name: "radio", ingredients: [items.radioPart1, items.radioPart2], result: items.radio) )
	}
}