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
	// Quest items
	let loiqeLicense = Event(newName: "pilot license", size: 1, type: eventTypes.item, details: eventDetails.card, note:"required to undock from loiqe city", isQuest:true)
	
	let radio = Event(newName: "radio", size: 1, type: eventTypes.item, details: eventDetails.panel, note:"complete radio", isQuest:true)
	let radioAntena = Event(newName: "radio antena", size: 1, type: eventTypes.item, details: eventDetails.part, note:"piece of radio", isQuest:true)
	let radioSpeaker = Event(newName: "radio antena", size: 1, type: eventTypes.item, details: eventDetails.part, note:"piece of radio", isQuest:true)
	
	
	// Batteries
	let smallBattery = Event(newName: "cell", size: 25, type: eventTypes.item, details: eventDetails.battery, note:"gives a small amount of power")
	let mediumBattery = Event(newName: "cell", size: 50, type: eventTypes.item, details: eventDetails.battery, note:"gives battery power")
	
	// Misc
	let waste = Event(newName: "waste", size: 3, type: eventTypes.item, details: eventDetails.waste, note:"useless junk")
}