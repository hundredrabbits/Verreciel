//
//  LocationLibrary.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.
//
import UIKit
import QuartzCore
import SceneKit
import Foundation

class Loiqe
{
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		let location = LocationStar(name:"Loiqe")
		location.at = offset
		return location
	}
	
	func spawn() -> LocationSpawn
	{
		let location = LocationSpawn(name:"Awakening")
		location.at = CGPoint(x: offset.x, y: offset.y - 3)
		return location
	}
	
	func landing() -> LocationTrade
	{
		let location = LocationTrade(name: "Loiqe City", want:items.loiqeLicense, give:items.smallBattery)
		location.at = CGPoint(x: offset.x, y: offset.y - 2)
		return location
	}
	
	func city() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x, y: offset.y - 1)
		return location
	}
	
	func telescope() -> LocationTelescope
	{
		let location = LocationTelescope(name:"telescope")
		location.at = CGPoint(x: offset.x - 1, y: offset.y)
		return location
	}
	
	func waypoint() -> LocationStation
	{
		let location = LocationStation(name: "station")
		location.at = CGPoint(x: offset.x, y: offset.y + 1)
		return location
	}
	
	func beacon() -> LocationBeacon
	{
		let location = LocationBeacon(name:"loiqe beacon",message:"Are you absolutely sure that you are ~in space ...")
		location.at = CGPoint(x: offset.x, y: offset.y - 3)
		return location
	}
}

class Usul
{
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		let location = LocationStar(name:"Usul")
		location.at = offset
		return location
	}
	
	func city() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x, y: offset.y - 1)
		return location
	}
	
	func waypoint() -> LocationStation
	{
		let location = LocationStation(name: "station")
		location.at = CGPoint(x: offset.x + 1, y: offset.y)
		return location
	}
}

class Valen
{
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		let location = LocationStar(name:"Valen")
		location.at = offset
		return location
	}
	
	func city() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x, y: offset.y + 1)
		return location
	}
	
	func waypoint() -> LocationStation
	{
		let location = LocationStation(name: "station")
		location.at = CGPoint(x: offset.x - 1, y: offset.y)
		return location
	}
	
	func telescope() -> LocationTelescope
	{
		let location = LocationTelescope(name:"telescope")
		location.at = CGPoint(x: offset.x, y: offset.y - 1)
		return location
	}
}

class Venic
{
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		let location = LocationStar(name:"Venic")
		location.at = offset
		return location
	}
	
	func city() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x - 1, y: offset.y)
		return location
	}
	
	func waypoint() -> LocationStation
	{
		let location = LocationStation(name: "station")
		location.at = CGPoint(x: offset.x, y: offset.y + 1)
		return location
	}
}

class LocationLibrary
{
	let loiqe = Loiqe(offset: CGPoint(x: 0,y: -4))
	let usul  = Usul(offset: CGPoint(x: -4,y: 0))
	let venic = Venic(offset: CGPoint(x: 4,y: -4))
	let valen = Valen(offset: CGPoint(x: 4,y: 0))
	
	init()
	{
		
	}
	
	var falvetCity:Location!
	
	
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