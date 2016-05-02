//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class RecipesCollection
{
	var horadric:Array<Recipe> = []
	
	init()
	{
		keys()
		currencies()
	}
	
	private func keys()
	{
		horadric.append( Recipe(ingredients: [items.valenPortalFragment1, items.valenPortalFragment2], result: items.valenPortalKey) )
		horadric.append( Recipe(ingredients: [items.usulPortalFragment1, items.usulPortalFragment2], result: items.usulPortalKey) )
		
		// Master Keys
		
		horadric.append( Recipe(ingredients: [items.valenPortalKey, items.usulPortalKey], result: items.endKeyFragment1) )
		horadric.append( Recipe(ingredients: [items.loiqePortalKey, items.senniPortalKey], result: items.endKeyFragment2) )
		horadric.append( Recipe(ingredients: [items.endKeyFragment1, items.endKeyFragment2], result: items.endKey) )
	}
	
	private func currencies()
	{
		horadric.append( Recipe(ingredients: [items.currency1, items.currency2], result: Item(like:items.currency4)) )
		horadric.append( Recipe(ingredients: [items.currency2, items.currency3], result: Item(like:items.currency5)) )
		horadric.append( Recipe(ingredients: [items.currency4, items.currency5], result: Item(like:items.currency6)) )
	}
}