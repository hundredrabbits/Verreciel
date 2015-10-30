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
	
	// Quest items
	let materia = Event(newName: "materia", size: 1, type: eventTypes.item, details: itemTypes.card, note:"trade for radio part", isQuest:true)
	let cyanineKey = Event(newName: "Cyanine Key", size: 1, type: eventTypes.item, details: itemTypes.key, note:"unlocks the portal to cyanine", isQuest:true)
	
	// Radio Quest
	let radio = Event(newName: "radio", size: 1, type: eventTypes.panel, details: itemTypes.panel, note:"complete radio", isQuest:true)
	let radioPart1 = Event(newName: "radio antena", size: 1, type: eventTypes.item, details: itemTypes.part, note:"piece of radio", isQuest:true)
	let radioPart2 = Event(newName: "radio speaker", size: 1, type: eventTypes.item, details: itemTypes.part, note:"piece of radio", isQuest:true)
	
	// Batteries
	let cell1 = Event(newName: "cell a", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives little power")
	let cell2 = Event(newName: "cell b", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives little power")
	let cell3 = Event(newName: "cell c", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives little power")
	let cell4 = Event(newName: "cell d", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives little power")
	let rack = Event(newName: "rack", size: 1, type: eventTypes.item, details: itemTypes.battery, note:"gives average power")
	
	// Misc
	let waste = Event(newName: "waste", size: 3, type: eventTypes.item, details: itemTypes.waste, note:"useless junk")
}