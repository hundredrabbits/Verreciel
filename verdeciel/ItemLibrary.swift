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
	let loiqeLicense = Event(newName: "pilot license", size: 1, type: eventTypes.item, details: eventDetails.card, note:"required to undock from loiqe city", quest:true)
	
	// Batteries
	let smallBattery = Event(newName: "small cell", size: 25, type: eventTypes.item, details: eventDetails.battery, note:"gives a small amount of power")
	let mediumBattery = Event(newName: "cell", size: 50, type: eventTypes.item, details: eventDetails.battery, note:"gives battery power")
}