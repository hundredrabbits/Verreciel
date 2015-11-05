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
	let playerCargo = Event(newName: "player cargo", size: 1, type: eventTypes.cargo, details: itemTypes.panel, note:"need description", isQuest:true)
	let starmap = Event(newName: "starmap", size: 1, type: eventTypes.map, details: itemTypes.panel, note:"need description", isQuest:true)
	
	// Quest items
	let materia = Event(newName: "materia", size: 1, type: eventTypes.item, details: itemTypes.card, note:"trade for loiqe key", isQuest:true)
	let cyanineKey = Event(newName: "Cyanine Key", size: 1, type: eventTypes.item, details: itemTypes.key, note:"unlocks the portal to cyanine", isQuest:true)
	
	let loiqePortal = Event(newName: "loiqe key", size: 1, type: eventTypes.item, details: itemTypes.card, note:"complete radio", isQuest:true)
	let loiqePortalFragment1 = Event(newName: "Portal fragment 1", size: 1, type: eventTypes.item, details: itemTypes.part, note:"half a Portal", isQuest:true)
	let loiqePortalFragment2 = Event(newName: "Portal fragment 2", size: 1, type: eventTypes.item, details: itemTypes.part, note:"half a Portal", isQuest:true)
	
	// Batteries
	let cell1  = Event(newName: "cell", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives little power")
	let cell2  = Event(newName: "cell", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives little power")
	let cell3  = Event(newName: "cell", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives little power")
	let cell4  = Event(newName: "cell", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives little power")
	let array1 = Event(newName: "array", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives medium power")
	let array2 = Event(newName: "array", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives medium power")
	let array3 = Event(newName: "array", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives medium power")
	let array4 = Event(newName: "array", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives medium power")
	let grid1 = Event(newName: "grid", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives large power")
	let grid2 = Event(newName: "grid", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives large power")
	let grid3 = Event(newName: "grid", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives large power")
	let grid4 = Event(newName: "grid", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives large power")
	let matrix1 = Event(newName: "matrix I", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives large power")
	let matrix2 = Event(newName: "matrix II", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives large power")
	let matrix3 = Event(newName: "matrix III", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives large power")
	let matrix4 = Event(newName: "matrix IV", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives large power")
	
	// Misc
	let waste = Event(newName: "waste", size: 3, type: eventTypes.item, details: itemTypes.waste, note:"useless junk")
}