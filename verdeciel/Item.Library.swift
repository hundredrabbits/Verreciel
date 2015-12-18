//
//  ItemLibrary.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import Foundation

class ItemLibrary
{
	// Ship events
	let playerCargo = Item(newName: "player cargo", type: .cargo, note:"need description", isQuest:true)
	let starmap = Item(newName: "starmap", type: .map, note:"route to helmet", isQuest:true)
	
	// Quest items
	let materia = Item(newName: "materia", type: .card, note:"trade for loiqe key", isQuest:true)
	let cyanineKey = Item(newName: "Cyanine Key", type: .key, note:"unlocks the portal to cyanine", isQuest:true)

	// Batteries
	let cell1  = Item(newName: "cell", type: .battery, note:"gives little power", isQuest:true)
	let cell2  = Item(newName: "cell", type: .battery, note:"gives little power", isQuest:true)
	let cell3  = Item(newName: "cell", type: .battery, note:"gives little power", isQuest:true)
	let cell4  = Item(newName: "cell", type: .battery, note:"gives little power", isQuest:true)
	let array1 = Item(newName: "array", type: .battery, note:"gives medium power", isQuest:true)
	let array2 = Item(newName: "array", type: .battery, note:"gives medium power", isQuest:true)
	let array3 = Item(newName: "array", type: .battery, note:"gives medium power", isQuest:true)
	let array4 = Item(newName: "array", type: .battery, note:"gives medium power", isQuest:true)
	let grid1 = Item(newName: "grid", type: .battery, note:"gives large power", isQuest:true)
	let grid2 = Item(newName: "grid", type: .battery, note:"gives large power", isQuest:true)
	let grid3 = Item(newName: "grid", type: .battery, note:"gives large power", isQuest:true)
	let grid4 = Item(newName: "grid", type: .battery, note:"gives large power", isQuest:true)
	let matrix1 = Item(newName: "matrix I", type: .battery, note:"gives large power", isQuest:true)
	let matrix2 = Item(newName: "matrix II", type: .battery, note:"gives large power", isQuest:true)
	let matrix3 = Item(newName: "matrix III", type: .battery, note:"gives large power", isQuest:true)
	let matrix4 = Item(newName: "matrix IV", type: .battery, note:"gives large power", isQuest:true)
	
	// Misc
	let waste = Item(newName: "waste", type: .waste, note:"useless junk")
	
	let loiqePortalKey = Item(newName: "loiqe key", type: .card, note:"complete key", isQuest:true)
	
	let valenPortalKey = Item(newName: "valen key", type: .card, note:"complete key", isQuest:true)
	let valenPortalFragment1 = Item(newName: "Key fragment 1", type: .part, note:"half a Portal key", isQuest:true)
	let valenPortalFragment2 = Item(newName: "Key fragment 2", type: .part, note:"half a Portal key", isQuest:true)
	
	let senniPortalKey = Item(newName: "senni key", type: .card, note:"complete key", isQuest:true)
	let senniPortalFragment1 = Item(newName: "Key fragment 1", type: .part, note:"half a Portal key", isQuest:true)
	let senniPortalFragment2 = Item(newName: "Key fragment 2", type: .part, note:"half a Portal key", isQuest:true)
	
	let usulPortalKey = Item(newName: "usul key", type: .card, note:"complete key", isQuest:true)
	let usulPortalFragment1 = Item(newName: "Key fragment 1", type: .part, note:"half a Portal key", isQuest:true)
	let usulPortalFragment2 = Item(newName: "Key fragment 2", type: .part, note:"half a Portal key", isQuest:true)
	
	let warpDrive = Item(newName: "warpdrive", type: .drive, note:"local warpdrive", isQuest:true)
	
	// Records
	let record1 = Item(newName: "record", type: .record, note:"an old audio tape", isQuest:true)
	
	// Currencies
	
	let credits = Item(newName: "credits", type: .currency, note:"todo", isQuest:true)
	
}