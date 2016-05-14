//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class RecipesCollection
{
	var horadric:Array<Recipe> = []
	
	init()
	{
		horadric.append( Recipe(ingredients: [items.record1, items.record2], result: items.record3) )
		
		// Keys
		
		horadric.append( Recipe(ingredients: [items.valenPortalFragment1, items.valenPortalFragment2], result: items.valenPortalKey) )
		horadric.append( Recipe(ingredients: [items.usulPortalFragment1, items.usulPortalFragment2], result: items.usulPortalKey) )
		
		horadric.append( Recipe(ingredients: [items.valenPortalKey, items.usulPortalKey], result: items.endPortalKeyFragment1) )
		horadric.append( Recipe(ingredients: [items.loiqePortalKey, items.senniPortalKey], result: items.endPortalKeyFragment2) )
		horadric.append( Recipe(ingredients: [items.endPortalKeyFragment1, items.endPortalKeyFragment2], result: items.endPortalKey) )
		
		// Currencies
		
		horadric.append( Recipe(ingredients: [items.currency1, items.currency2], result: Item(like:items.currency4)) )
		horadric.append( Recipe(ingredients: [items.currency2, items.currency3], result: Item(like:items.currency5)) )
		horadric.append( Recipe(ingredients: [items.currency4, items.currency5], result: Item(like:items.currency6)) )
		
		//
		
		horadric.append( Recipe(ingredients: [items.record1, items.record2], result: items.record4) )
	}
}