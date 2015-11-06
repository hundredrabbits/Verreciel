//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class RecipesLibrary
{
	var horadric:Array<Recipe> = []
	
	init()
	{
		horadric.append( Recipe(name: "valen key", ingredients: [items.valenPortalFragment1, items.valenPortalFragment2], result: items.valenPortalKey) )
//		horadric.append( Recipe(name: "senni key", ingredients: [items.senniPortalFragment1, items.senniPortalFragment2], result: items.senniPortalKey) )
//		horadric.append( Recipe(name: "usul key", ingredients: [items.usulPortalFragment1, items.usulPortalFragment2], result: items.usulPortalKey) )
	}
}