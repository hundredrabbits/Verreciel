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
	let playerCargo = Event(newName: "player cargo", type: eventTypes.cargo, details: itemTypes.panel, note:"need description", isQuest:true)
	let starmap = Event(newName: "starmap", type: eventTypes.map, details: itemTypes.panel, note:"route to helmet", isQuest:true)
	
	// Quest items
	let materia = Event(newName: "materia", type: eventTypes.item, details: itemTypes.card, note:"trade for loiqe key", isQuest:true)
	let cyanineKey = Event(newName: "Cyanine Key", type: eventTypes.item, details: itemTypes.key, note:"unlocks the portal to cyanine", isQuest:true)

	// Batteries
	let cell1  = Event(newName: "cell", type: eventTypes.item, details: itemTypes.battery, note:"gives little power", isQuest:true)
	let cell2  = Event(newName: "cell", type: eventTypes.item, details: itemTypes.battery, note:"gives little power", isQuest:true)
	let cell3  = Event(newName: "cell", type: eventTypes.item, details: itemTypes.battery, note:"gives little power", isQuest:true)
	let cell4  = Event(newName: "cell", type: eventTypes.item, details: itemTypes.battery, note:"gives little power", isQuest:true)
	let array1 = Event(newName: "array", type: eventTypes.item, details: itemTypes.battery, note:"gives medium power", isQuest:true)
	let array2 = Event(newName: "array", type: eventTypes.item, details: itemTypes.battery, note:"gives medium power", isQuest:true)
	let array3 = Event(newName: "array", type: eventTypes.item, details: itemTypes.battery, note:"gives medium power", isQuest:true)
	let array4 = Event(newName: "array", type: eventTypes.item, details: itemTypes.battery, note:"gives medium power", isQuest:true)
	let grid1 = Event(newName: "grid", type: eventTypes.item, details: itemTypes.battery, note:"gives large power", isQuest:true)
	let grid2 = Event(newName: "grid", type: eventTypes.item, details: itemTypes.battery, note:"gives large power", isQuest:true)
	let grid3 = Event(newName: "grid", type: eventTypes.item, details: itemTypes.battery, note:"gives large power", isQuest:true)
	let grid4 = Event(newName: "grid", type: eventTypes.item, details: itemTypes.battery, note:"gives large power", isQuest:true)
	let matrix1 = Event(newName: "matrix I", type: eventTypes.item, details: itemTypes.battery, note:"gives large power", isQuest:true)
	let matrix2 = Event(newName: "matrix II", type: eventTypes.item, details: itemTypes.battery, note:"gives large power", isQuest:true)
	let matrix3 = Event(newName: "matrix III", type: eventTypes.item, details: itemTypes.battery, note:"gives large power", isQuest:true)
	let matrix4 = Event(newName: "matrix IV", type: eventTypes.item, details: itemTypes.battery, note:"gives large power", isQuest:true)
	
	// Misc
	let waste = Event(newName: "waste", type: eventTypes.item, details: itemTypes.waste, note:"useless junk")
	
	let loiqePortalKey = Event(newName: "loiqe key", type: eventTypes.item, details: itemTypes.card, note:"complete key", isQuest:true)
	
	let valenPortalKey = Event(newName: "valen key",  type: eventTypes.item, details: itemTypes.card, note:"complete key", isQuest:true)
	let valenPortalFragment1 = Event(newName: "Key fragment 1", type: eventTypes.item, details: itemTypes.part, note:"half a Portal key", isQuest:true)
	let valenPortalFragment2 = Event(newName: "Key fragment 2", type: eventTypes.item, details: itemTypes.part, note:"half a Portal key", isQuest:true)
	
	let senniPortalKey = Event(newName: "senni key", type: eventTypes.item, details: itemTypes.card, note:"complete key", isQuest:true)
	let senniPortalFragment1 = Event(newName: "Key fragment 1", type: eventTypes.item, details: itemTypes.part, note:"half a Portal key", isQuest:true)
	let senniPortalFragment2 = Event(newName: "Key fragment 2", type: eventTypes.item, details: itemTypes.part, note:"half a Portal key", isQuest:true)
	
	let usulPortalKey = Event(newName: "usul key", type: eventTypes.item, details: itemTypes.card, note:"complete key", isQuest:true)
	let usulPortalFragment1 = Event(newName: "Key fragment 1", type: eventTypes.item, details: itemTypes.part, note:"half a Portal key", isQuest:true)
	let usulPortalFragment2 = Event(newName: "Key fragment 2", type: eventTypes.item, details: itemTypes.part, note:"half a Portal key", isQuest:true)
	
	let warpDrive = Event(newName: "warpdrive", type: eventTypes.drive, details: itemTypes.panel, note:"local warpdrive", isQuest:true)
	
	// Records
	let record1 = Event(newName: "a record", type: eventTypes.item, details: itemTypes.record, note:"an old dusty vynil", isQuest:true)
	
}