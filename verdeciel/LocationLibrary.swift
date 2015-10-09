//
//  LocationLibrary.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit

class LocationLibrary
{
	var loiqeCity:Location!
	var falvetCity:Location!
	
	// Loiqe
	
	func loiqe(at:CGPoint) -> LocationStar
	{
		let location = LocationStar(name:"Loiqe")
		location.at = at
		return location
	}
	
	func loiqeCity(at:CGPoint) -> LocationTrade
	{
		let location = LocationTrade(name: "Loiqe City", want:items.loiqeLicense, give:items.smallBattery)
		location.at = at
		loiqeCity = location
		return location
	}
	
	func loiqeRepair(at:CGPoint) -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = at
		return location
	}
	
	func loiqeBeacon(at:CGPoint) -> LocationBeacon
	{
		let location = LocationBeacon(name:"loiqe beacon",message:"Are you absolutely sure that you are ~in space ...")
		location.at = at
		return location
	}
	
	// Falvet
	
	func falvet(at:CGPoint) -> LocationStar
	{
		let location = LocationStar(name:"Falvet")
		location.at = at
		return location
	}
	
	func falvetCity(at:CGPoint) -> LocationTrade
	{
		let location = LocationTrade(name: "Falvet City", want:items.loiqeLicense, give:items.smallBattery)
		location.at = at
		falvetCity = location
		return location
	}
}