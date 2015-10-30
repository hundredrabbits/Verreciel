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

class LocationLibrary
{
	let loiqe = Loiqe(offset: CGPoint(x: 0,y: -4))
	let usul  = Usul(offset: CGPoint(x: -4,y: 0))
	let venic = Venic(offset: CGPoint(x: 4,y: -4))
	let valen = Valen(offset: CGPoint(x: 4,y: 0))
	let senni = Senni(offset: CGPoint(x: 0,y: 4))
	let falvet = Falvet(offset: CGPoint(x: 0,y: 0))
	
	init()
	{
	}
}

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
	
	func landing() -> LocationBeacon
	{
		return LocationBeacon(name: "Loiqe Landings", at:CGPoint(x: offset.x, y: offset.y - 2), message: "Nothing for you here.")
	}
	
	func city() -> LocationCargo
	{
		let location = LocationCargo(name:"Loiqe City", item: items.materia)
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x, y: offset.y - 1)
		location.note = "The city of loiqe is$granting you a$pilot license."
		return location
	}
	
	func horadric() -> LocationHoradric
	{
		return LocationHoradric(name:"Horadric", at: CGPoint(x: offset.x - 1, y: offset.y))
	}
	
	func waypoint() -> LocationTrade
	{
		return LocationTrade(name: "waypoint", at: CGPoint(x: offset.x, y: offset.y + 1), want: items.materia, give: items.radioPart1)
	}
	
	func cargo() -> LocationCargo
	{
		return LocationCargo(name: "cargo", at: CGPoint(x: offset.x + 1, y: offset.y + 1), item: items.radioPart2)
	}
	
	func connection() -> LocationBeacon
	{
		let location = LocationBeacon(name: "passage", at: CGPoint(x: offset.x, y: offset.y + 2), message: "something")
		location.isRadioQuest = true
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

class Senni
{
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		let location = LocationStar(name:"Senni")
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
	
	func portal() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x + 1, y: offset.y)
		return location
	}
	
	func service() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x, y: offset.y + 1)
		return location
	}
	
	func spawn() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x + 2, y: offset.y)
		return location
	}
	
	func telescope() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x, y: offset.y + 2)
		return location
	}
	
	func waypoint() -> LocationStation
	{
		let location = LocationStation(name: "station")
		location.at = CGPoint(x: offset.x, y: offset.y - 1)
		return location
	}
}

class Falvet
{
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		let location = LocationStar(name:"Falvet")
		location.at = offset
		return location
	}
	
	func toUsul() -> LocationRepair
	{
		return LocationRepair(name:"Loiqe Repairs", at: CGPoint(x: offset.x - 1.5, y: offset.y))
	}
	
	func toLoiqe() -> LocationHoradric
	{
		return LocationHoradric(name:"Horadric", at: CGPoint(x: offset.x, y: offset.y - 1.5))
	}
	
	func toValen() -> LocationRepair
	{
		return LocationRepair(name:"Loiqe Repairs", at: CGPoint(x: offset.x + 1.5, y: offset.y))
	}
	
	func toSenni() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x, y: offset.y + 1.5)
		return location
	}
	
	func service1() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x + 1, y: offset.y + 1)
		return location
	}
	
	func service2() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x - 1, y: offset.y + 1)
		return location
	}
	
	func service3() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x + 1, y: offset.y - 1)
		return location
	}
	
	func service4() -> LocationRepair
	{
		let location = LocationRepair(name:"Loiqe Repairs")
		location.addService(services.hull)
		location.at = CGPoint(x: offset.x - 1, y: offset.y - 1)
		return location
	}
}