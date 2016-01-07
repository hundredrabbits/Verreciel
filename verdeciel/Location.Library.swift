//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

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
		let location = LocationStar(name:"Loiqe",system:.loiqe)
		location.at = offset
		return location
	}
	
	func spawn() -> LocationSpawn
	{
		let location = LocationSpawn(name:"Awakening",system:.loiqe)
		location.at = CGPoint(x: offset.x, y: offset.y - 3)
		return location
	}
	
	func landing() -> LocationSatellite
	{
		return LocationSatellite(name: "Loiqe Landings", system:.loiqe, at:CGPoint(x: offset.x, y: offset.y - 2), message:"Missing text$will add it soon$soon..", item:items.materia)
	}
	
	func city() -> LocationTrade
	{
		return LocationTrade(name: "Loiqe City", at: CGPoint(x: offset.x, y: offset.y - 1),system:.loiqe, want: items.materia, give: items.valenPortalFragment1)
	}
	
	func horadric() -> LocationHoradric
	{
		return LocationHoradric(name:"Horadric",system:.loiqe, at: CGPoint(x: offset.x - 1, y: offset.y))
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal", system:.loiqe, at:CGPoint(x: offset.x, y: offset.y + 1), key: nil, rightName: "Valen", leftName:"Usul")
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name: "satellite", system:.loiqe, at: CGPoint(x: offset.x - 2, y: offset.y), message:"Missing text here $will add soon.", item: items.valenPortalFragment2)
	}
	
	func beacon() -> LocationBeacon
	{
		let location = LocationBeacon(name:"loiqe beacon",system:.loiqe,message:"Are you absolutely sure that you are ~in space ...")
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
		let location = LocationStar(name:"Usul",system:.usul)
		location.at = offset
		return location
	}
	
	func city() -> Location
	{
		let location = Location(name:"Missing",system: .usul, at:CGPoint(x: offset.x, y: offset.y - 1))
		return location
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:.usul, at:CGPoint(x: offset.x + 1, y: offset.y), key: items.usulPortalKey, rightName: "Loiqe", leftName:"Senni")
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
		let location = LocationStar(name:"Valen",system:.valen)
		location.at = offset
		return location
	}
	
	func satellite() -> LocationSatellite
	{
		let location = LocationSatellite(name:"Satellite",system:.valen, message:"derelict music machine $time ghost sleep $home.", item:items.record1)
		location.at = CGPoint(x: offset.x, y: offset.y + 2)
		return location
	}
	
	func bank() -> LocationBank
	{
		let location = LocationBank(name:"Bank",system:.valen)
		location.at = CGPoint(x: offset.x, y: offset.y + 1)
		return location
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:.valen, at:CGPoint(x: offset.x - 1, y: offset.y), key: items.valenPortalKey, rightName: "Senni", leftName:"Loiqe")
	}
	
	func harvest() -> LocationHarvest
	{
		return LocationHarvest(name: "harvest",system:.valen, at:CGPoint(x: offset.x, y: offset.y - 1), grows: Item(name: items.credits.name!, type: items.credits.type, note:items.credits.note))
	}
	
	func station() -> LocationStation
	{
		let location = LocationStation(name:"station",system:.valen, requirement:items.credits, installation:{ battery.installShield() }, installationName:"Shield")
		location.at = CGPoint(x: offset.x + 1, y: offset.y)
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
		let location = LocationStar(name:"Venic",system:.venic)
		location.at = offset
		return location
	}
	
	func city() -> Location
	{
		let location = Location(name:"Missing",system:.venic, at:CGPoint(x: offset.x - 1, y: offset.y))
		return location
	}
	
	func waypoint() -> Location
	{
		let location = Location(name: "station",system:.venic, at:CGPoint(x: offset.x, y: offset.y + 1))
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
		let location = LocationStar(name:"Senni",system:.senni)
		location.at = offset
		return location
	}
	
	func city() -> Location
	{
		let location = Location(name:"Missing",system:.senni, at:CGPoint(x: offset.x - 1, y: offset.y))
		return location
	}
	
	func station() -> Location
	{
		let location = Location(name:"Missing",system:.senni, at:CGPoint(x: offset.x + 1, y: offset.y))
		return location
	}
	
	func service() -> Location
	{
		let location = Location(name:"Missing",system:.senni,at:CGPoint(x: offset.x, y: offset.y + 1))
		return location
	}
	
	func spawn() -> Location
	{
		let location = Location(name:"Missing",system:.senni,at:CGPoint(x: offset.x + 2, y: offset.y))
		return location
	}
	
	func telescope() -> Location
	{
		let location = Location(name:"Missing",system:.senni,at:CGPoint(x: offset.x, y: offset.y + 2))
		return location
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:.senni, at:CGPoint(x: offset.x, y: offset.y - 1), key: items.senniPortalKey, rightName: "Usul", leftName:"Valen")
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
		let location = LocationStar(name:"Falvet",system:.falvet)
		location.at = offset
		return location
	}
	
	func toUsul() -> Location
	{
		return Location(name:"Missing",system:.falvet, at: CGPoint(x: offset.x - 1.5, y: offset.y))
	}
	
	func toLoiqe() -> Location
	{
		return Location(name:"Passage",system:.falvet, at: CGPoint(x: offset.x, y: offset.y - 1.5))
	}
	
	func toValen() -> Location
	{
		return Location(name:"Missing",system:.falvet, at: CGPoint(x: offset.x + 1.5, y: offset.y))
	}
	
	func toSenni() -> Location
	{
		let location = Location(name:"Missing",system:.falvet,at:CGPoint(x: offset.x, y: offset.y + 1.5))
		return location
	}
	
	func service1() -> Location
	{
		let location = Location(name:"Missing",system:.falvet,at:CGPoint(x: offset.x + 1, y: offset.y + 1))
		return location
	}
	
	func service2() -> Location
	{
		let location = Location(name:"Missing",system:.falvet,at:CGPoint(x: offset.x - 1, y: offset.y + 1))
		return location
	}
	
	func service3() -> Location
	{
		let location = Location(name:"Missing",system:.falvet,at:CGPoint(x: offset.x + 1, y: offset.y - 1))
		return location
	}
	
	func service4() -> Location
	{
		let location = Location(name:"Missing",system:.falvet,at:CGPoint(x: offset.x - 1, y: offset.y - 1))
		return location
	}
}