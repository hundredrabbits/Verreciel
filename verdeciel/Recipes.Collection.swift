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
		
		horadric.append( Recipe(ingredients: [items.valenPortalKey, items.usulPortalKey], result: items.horizontalKey) )
		horadric.append( Recipe(ingredients: [items.loiqePortalKey, items.senniPortalKey], result: items.verticalKey) )
		horadric.append( Recipe(ingredients: [items.horizontalKey, items.verticalKey], result: items.masterKey) )
	}
	
	private func currencies()
	{
		horadric.append( Recipe(ingredients: [items.currency1, items.currency2], result: Item(like:items.currency4)) )
	}
}