//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class RecipesLibrary
{
	var horadric:Array<Recipe> = []
	
	init()
	{
		keys()
		batteries()
		currencies()
	}
	
	private func keys()
	{
		horadric.append( Recipe(ingredients: [items.valenPortalFragment1, items.valenPortalFragment2], result: items.valenPortalKey) )
		horadric.append( Recipe(ingredients: [items.senniPortalFragment1, items.senniPortalFragment2], result: items.senniPortalKey) )
		horadric.append( Recipe(ingredients: [items.usulPortalFragment1, items.usulPortalFragment2], result: items.usulPortalKey) )
		
		// Master Keys
		
		horadric.append( Recipe(ingredients: [items.valenPortalKey, items.usulPortalKey], result: items.masterRedKey) )
		horadric.append( Recipe(ingredients: [items.loiqePortalKey, items.senniPortalKey], result: items.masterCyanKey) )
		horadric.append( Recipe(ingredients: [items.masterRedKey, items.masterCyanKey], result: items.masterWhiteKey) )
	}
	
	private func batteries()
	{
		horadric.append( Recipe(ingredients: [items.cell1, items.cell2], result: items.array1) )
		horadric.append( Recipe(ingredients: [items.array1, items.array2], result: items.grid1) )
		horadric.append( Recipe(ingredients: [items.grid1, items.grid2], result: items.matrix1) )
	}
	
	private func currencies()
	{
		horadric.append( Recipe(ingredients: [items.alta, items.credit], result: Item(name: items.materia.name!, type: items.materia.type, note:items.materia.note)) )
		horadric.append( Recipe(ingredients: [items.materia, items.alta], result: Item(name: "mynir", type: .currency, note:"trading currency")) )
		horadric.append( Recipe(ingredients: [items.materia, items.credit], result: Item(name: "uli", type: .currency, note:"trading currency")) )
		horadric.append( Recipe(ingredients: [items.mynir, items.uli], result: Item(name: "natal", type: .currency, note:"trading currency")) )
	}
}