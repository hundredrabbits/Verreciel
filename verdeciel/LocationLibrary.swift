//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationLibrary
{
	let loiqe = Loiqe(offset: CGPoint(x: 0,y: -3.5))
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
	
	func landing() -> LocationCargo
	{
		return LocationCargo(name: "Loiqe Landings", at:CGPoint(x: offset.x, y: offset.y - 2), item: items.materia)
	}
	
	func city() -> LocationTrade
	{
		return LocationTrade(name: "Loiqe City", at: CGPoint(x: offset.x, y: offset.y - 1), want: items.materia, give: items.loiqeKeyFragment1)
	}
	
	func horadric() -> LocationHoradric
	{
		return LocationHoradric(name:"Horadric", at: CGPoint(x: offset.x - 1, y: offset.y))
	}
	
	func gate() -> LocationPortal
	{
		return LocationPortal(name: "gate", at:CGPoint(x: offset.x, y: offset.y + 1), destination: CGPoint(x: 0,y: 0) )
	}
	
	func cargo() -> LocationCargo
	{
		return LocationCargo(name: "cargo", at: CGPoint(x: offset.x - 2, y: offset.y), item: items.loiqeKeyFragment2)
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
	
	func city() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
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
	
	func city() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x, y: offset.y + 1)
		return location
	}
	
	func waypoint() -> LocationStation
	{
		let location = LocationStation(name: "station")
		location.at = CGPoint(x: offset.x - 1, y: offset.y)
		return location
	}
	
	func telescope() -> LocationStation
	{
		let location = LocationStation(name:"telescope")
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
	
	func city() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
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
	
	func city() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x - 1, y: offset.y)
		return location
	}
	
	func portal() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x + 1, y: offset.y)
		return location
	}
	
	func service() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x, y: offset.y + 1)
		return location
	}
	
	func spawn() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x + 2, y: offset.y)
		return location
	}
	
	func telescope() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
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
	
	func toUsul() -> LocationStation
	{
		return LocationStation(name:"Loiqe Repairs", at: CGPoint(x: offset.x - 1.5, y: offset.y))
	}
	
	func toLoiqe() -> LocationHoradric
	{
		return LocationHoradric(name:"Passage", at: CGPoint(x: offset.x, y: offset.y - 1.5))
	}
	
	func toValen() -> LocationStation
	{
		return LocationStation(name:"Loiqe Repairs", at: CGPoint(x: offset.x + 1.5, y: offset.y))
	}
	
	func toSenni() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x, y: offset.y + 1.5)
		return location
	}
	
	func service1() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x + 1, y: offset.y + 1)
		return location
	}
	
	func service2() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x - 1, y: offset.y + 1)
		return location
	}
	
	func service3() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x + 1, y: offset.y - 1)
		return location
	}
	
	func service4() -> LocationStation
	{
		let location = LocationStation(name:"Loiqe Repairs")
		location.at = CGPoint(x: offset.x - 1, y: offset.y - 1)
		return location
	}
}