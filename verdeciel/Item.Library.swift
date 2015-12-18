
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class ItemLibrary
{
	// Ship events
	let playerCargo = Item(name: "player cargo", type: .cargo, note:"need description", isQuest:true)
	let starmap = Item(name: "starmap", type: .map, note:"route to helmet", isQuest:true)
	
	// Quest items
	let materia = Item(name: "materia", type: .card, note:"trade for loiqe key", isQuest:true)
	let cyanineKey = Item(name: "Cyanine Key", type: .key, note:"unlocks the portal to cyanine", isQuest:true)

	// Batteries
	let cell1  = Item(name: "cell", type: .battery, note:"gives little power", isQuest:true)
	let cell2  = Item(name: "cell", type: .battery, note:"gives little power", isQuest:true)
	let cell3  = Item(name: "cell", type: .battery, note:"gives little power", isQuest:true)
	let cell4  = Item(name: "cell", type: .battery, note:"gives little power", isQuest:true)
	let array1 = Item(name: "array", type: .battery, note:"gives medium power", isQuest:true)
	let array2 = Item(name: "array", type: .battery, note:"gives medium power", isQuest:true)
	let array3 = Item(name: "array", type: .battery, note:"gives medium power", isQuest:true)
	let array4 = Item(name: "array", type: .battery, note:"gives medium power", isQuest:true)
	let grid1 = Item(name: "grid", type: .battery, note:"gives large power", isQuest:true)
	let grid2 = Item(name: "grid", type: .battery, note:"gives large power", isQuest:true)
	let grid3 = Item(name: "grid", type: .battery, note:"gives large power", isQuest:true)
	let grid4 = Item(name: "grid", type: .battery, note:"gives large power", isQuest:true)
	let matrix1 = Item(name: "matrix I", type: .battery, note:"gives large power", isQuest:true)
	let matrix2 = Item(name: "matrix II", type: .battery, note:"gives large power", isQuest:true)
	let matrix3 = Item(name: "matrix III", type: .battery, note:"gives large power", isQuest:true)
	let matrix4 = Item(name: "matrix IV", type: .battery, note:"gives large power", isQuest:true)
	
	// Misc
	let waste = Item(name: "waste", type: .waste, note:"useless junk")
	
	let loiqePortalKey = Item(name: "loiqe key", type: .card, note:"complete key", isQuest:true)
	
	let valenPortalKey = Item(name: "valen key", type: .card, note:"complete key", isQuest:true)
	let valenPortalFragment1 = Item(name: "Key fragment 1", type: .part, note:"half a Portal key", isQuest:true)
	let valenPortalFragment2 = Item(name: "Key fragment 2", type: .part, note:"half a Portal key", isQuest:true)
	
	let senniPortalKey = Item(name: "senni key", type: .card, note:"complete key", isQuest:true)
	let senniPortalFragment1 = Item(name: "Key fragment 1", type: .part, note:"half a Portal key", isQuest:true)
	let senniPortalFragment2 = Item(name: "Key fragment 2", type: .part, note:"half a Portal key", isQuest:true)
	
	let usulPortalKey = Item(name: "usul key", type: .card, note:"complete key", isQuest:true)
	let usulPortalFragment1 = Item(name: "Key fragment 1", type: .part, note:"half a Portal key", isQuest:true)
	let usulPortalFragment2 = Item(name: "Key fragment 2", type: .part, note:"half a Portal key", isQuest:true)
	
	let warpDrive = Item(name: "warpdrive", type: .drive, note:"local warpdrive", isQuest:true)
	
	// Records
	let record1 = Item(name: "record", type: .record, note:"an old audio tape", isQuest:true)
	
	// Currencies
	let credits = Item(name: "credits", type: .currency, note:"todo", isQuest:true)
}