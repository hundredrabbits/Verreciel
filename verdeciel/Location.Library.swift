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
	let cyanine = Cyanine(offset: CGPoint(x: 200,y: 200))
	
	init()
	{
	}
}

class Loiqe
{
	var system:Systems = .loiqe
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		let location = LocationStar(name:"Loiqe",system:system)
		location.at = offset
		return location
	}
	
	func spawn() -> LocationSpawn
	{
		return LocationSpawn(name:"Awakening",system:system, at:CGPoint(x: offset.x, y: offset.y - 2.75))
	}
	
	func harvest() -> LocationHarvest
	{
		return LocationHarvest(name: "Harvest", system: system, at:CGPoint(x: offset.x, y: offset.y - 2), grows: Item(name: items.materia.name!, type: items.materia.type, note: items.materia.note))
	}
	
	func city() -> LocationTrade
	{
		return LocationTrade(name: "City", system:system, at: CGPoint(x: offset.x, y: offset.y - 1), want: items.materia, give: items.valenPortalFragment1)
	}
	
	func horadric() -> LocationHoradric
	{
		return LocationHoradric(name:"Horadric",system:system, at: CGPoint(x: offset.x - 1, y: offset.y))
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal", system:system, at:CGPoint(x: offset.x, y: offset.y + 1), key: nil, rightName: "Valen", leftName:"Usul")
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name: "satellite", system:system, at: CGPoint(x: offset.x + 1, y: offset.y), message:"Missing text here $will add soon.", item: items.valenPortalFragment2)
	}
	
	func beacon() -> LocationBeacon
	{
		return LocationBeacon(name:"loiqe beacon",system:system, at: CGPoint(x: offset.x, y: offset.y - 3), message:"Are you absolutely sure that you are ~in space ...")
	}
	
	func port() -> LocationTrade
	{
		return LocationTrade(name: "Port", system:system, at: CGPoint(x: offset.x + 2, y: offset.y), want: items.alta, give: items.senniPortalFragment2, stealth:true)
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
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:.usul, at:CGPoint(x: offset.x + 1, y: offset.y), key: items.usulPortalKey, rightName: "Loiqe", leftName:"Senni")
	}
	
	func station() -> LocationStation
	{
		return LocationStation(name:"station",system:.usul, at: CGPoint(x: offset.x, y: offset.y - 1), requirement:items.ingot, installation:{ map.install() }, installationName:"map")
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name:"Satellite",system:.usul, at:CGPoint(x: offset.x, y: offset.y - 2), message:"[missing]", item:items.cypher1)
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
		return LocationStar(name:"Valen",system:.valen, at: offset)
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name:"Satellite",system:.valen, at:CGPoint(x: offset.x, y: offset.y + 2), message:"derelict music machine $time ghost sleep $home.", item:items.record1)
	}
	
	func bank() -> LocationBank
	{
		return LocationBank(name:"Bank",system:.valen, at: CGPoint(x: offset.x, y: offset.y + 1))
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:.valen, at:CGPoint(x: offset.x - 1, y: offset.y), key: items.valenPortalKey, rightName: "Senni", leftName:"Loiqe")
	}
	
	func harvest() -> LocationHarvest
	{
		return LocationHarvest(name: "harvest",system:.valen, at:CGPoint(x: offset.x, y: offset.y - 2), grows: Item(name: items.credits.name!, type: items.credits.type, note:items.credits.note))
	}
	
	func station() -> LocationStation
	{
		return LocationStation(name:"station",system:.valen, at: CGPoint(x: offset.x, y: offset.y - 1), requirement:items.credits, installation:{ battery.installShield() }, installationName:"Shield")
	}
	
	func port() -> LocationTrade
	{
		return LocationTrade(name: "port",system:.venic, at:CGPoint(x: offset.x + 1, y: offset.y + 2), want:items.alta,give:items.senniPortalFragment1)
	}
	
	func beacon() -> LocationBeacon
	{
		return LocationBeacon(name: "beacon", system: .venic, at:CGPoint(x: offset.x + 1, y: offset.y), message: "Combine 2 credits$create 1 alta")
	}
}

class Venic
{
	var offset:CGPoint!
	var system:Systems = .venic
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		return LocationStar(name:"Venic",system:system, at:offset)
	}
	
	func station() -> LocationStation
	{
		return LocationStation(name:"station",system:system, at:CGPoint(x: offset.x, y: offset.y - 1), requirement:items.alta, installation:{ map.install() }, installationName:"Map")
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name: "satellite",system:system, at:CGPoint(x: offset.x - 1, y: offset.y), message:"Missing",item:items.array2)
	}
	
	func city() -> LocationTrade
	{
		return LocationTrade(name: "city",system:system, at:CGPoint(x: offset.x - 2, y: offset.y), want:items.credits,give:items.senniPortalFragment1)
	}
	
	func beacon() -> LocationBeacon
	{
		return LocationBeacon(name: "beacon",system:system, at:CGPoint(x: offset.x + 2, y: offset.y), message:"Missing")
	}
	
	func cargo() -> LocationSatellite
	{
		return LocationSatellite(name: "cargo",system:system, at:CGPoint(x: offset.x + 1, y: offset.y), message:"Missing",item:items.cell3)
	}
	
	func port() -> LocationTrade
	{
		return LocationTrade(name: "Port", system:system, at: CGPoint(x: offset.x, y: offset.y + 2), want: items.alta, give: items.senniPortalFragment2, stealth:true)
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
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:.senni, at:CGPoint(x: offset.x, y: offset.y - 1), key: items.senniPortalKey, rightName: "Usul", leftName:"Valen")
	}
	
	func port() -> LocationTrade
	{
		return LocationTrade(name: "Port", system:.senni, at: CGPoint(x: offset.x, y: offset.y + 2), want: items.alta, give: items.senniPortalFragment2, stealth:true)
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

class Cyanine
{
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		let location = LocationStar(name:"Cyanine",system:.cyanine)
		location.at = offset
		return location
	}
	
	func valen() -> LocationStar
	{
		let location = LocationStar(name:"Valen II",system:.cyanine)
		location.at = CGPoint(x: offset.x + 1, y: offset.y)
		return location
	}
	
	func venic() -> LocationStar
	{
		let location = LocationStar(name:"Venic II",system:.cyanine)
		location.at = CGPoint(x: offset.x + 1, y: offset.y - 1)
		return location
	}
	
	func senni() -> LocationStar
	{
		let location = LocationStar(name:"Senni II",system:.cyanine)
		location.at = CGPoint(x: offset.x, y: offset.y + 1)
		return location
	}
	
	func loiqe() -> LocationStar
	{
		let location = LocationStar(name:"Loiqe II",system:.cyanine)
		location.at = CGPoint(x: offset.x, y: offset.y - 1)
		return location
	}
	
	func usul() -> LocationStar
	{
		let location = LocationStar(name:"Usul II",system:.cyanine)
		location.at = CGPoint(x: offset.x - 1, y: offset.y)
		return location
	}

}