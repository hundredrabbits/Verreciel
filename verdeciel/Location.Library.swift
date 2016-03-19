
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationLibrary
{
	let loiqe = Loiqe(offset: CGPoint(x: 0,y: -10))
	let usul  = Usul(offset: CGPoint(x: -10,y: 0))
	let valen = Valen(offset: CGPoint(x: 10,y: 0))
	let senni = Senni(offset: CGPoint(x: 0,y: 10))
	let falvet = Falvet(offset: CGPoint(x: 0,y: 0))
	
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
		return LocationHoradric(name:"Horadric",system:system, at: CGPoint(x: offset.x + 2, y: offset.y))
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal", system:system, at:CGPoint(x: offset.x, y: offset.y + 1), leftKey: items.usulPortalKey, rightKey: items.valenPortalKey, leftName:"Usul", rightName: "Valen")
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name: "satellite", system:system, at: CGPoint(x: offset.x + 1, y: offset.y), message:"Missing text here $will add soon$last line test", item: items.valenPortalFragment2)
	}
	
	func beacon() -> LocationBeacon
	{
		return LocationBeacon(name:"loiqe beacon",system:system, at: CGPoint(x: offset.x, y: offset.y - 3), message:"Are you absolutely sure that you are ~in space ...")
	}
	
	func port() -> LocationTrade
	{
		return LocationTrade(name: "Port", system:system, at: CGPoint(x: offset.x - 1, y: offset.y), want: items.alta, give: items.senniPortalFragment2, mapRequirement:items.map1)
	}
	
	func cargo() -> LocationSatellite
	{
		return LocationSatellite(name:"cargo",system:system, at:CGPoint(x: offset.x - 1, y: offset.y + 1), message:"Horadric cell$with cell$make array", item:items.cell2, mapRequirement:items.map1)
	}
	
	// Constellations
	
	func c_fog() -> LocationConstellation
	{
		return LocationConstellation(name: "fog", system:system, at: CGPoint(x:offset.x + 1.5, y: offset.y), structure: structures.c_fog())
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
		return LocationPortal(name: "portal",system:.usul, at:CGPoint(x: offset.x + 1, y: offset.y), leftKey: items.senniPortalKey, rightKey: items.loiqePortalKey, leftName:"Senni", rightName: "Loiqe")
	}
	
	func station() -> LocationStation
	{
		return LocationStation(name:"station",system:.usul, at: CGPoint(x: offset.x, y: offset.y - 1), requirement:items.credit, installation:{ map.install() }, installationName:"map")
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
	
	// North
	
	func bank() -> LocationBank
	{
		return LocationBank(name:"Bank",system:.valen, at: CGPoint(x: offset.x, y: offset.y + 1))
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:.valen, at:CGPoint(x: offset.x - 1, y: offset.y), leftKey: items.loiqePortalKey, rightKey: items.senniPortalKey, leftName:"Loiqe", rightName: "Senni")
	}
	
	func harvest() -> LocationHarvest
	{
		return LocationHarvest(name: "harvest",system:.valen, at:CGPoint(x: offset.x, y: offset.y + 2), grows: Item(name: items.credit.name!, type: items.credit.type, note:items.credit.note))
	}
	
	func station() -> LocationStation
	{
		return LocationStation(name:"station",system:.valen, at: CGPoint(x: offset.x + 1, y: offset.y + 1), requirement:items.credit, installation:{ radio.install() }, installationName:"Radio")
	}
	
	func cargo() -> LocationSatellite
	{
		return LocationSatellite(name:"cargo",system:.valen, at:CGPoint(x: offset.x + 1, y: offset.y + 2), message:"[misssing]", item:items.array2)
	}
	
	// South
	
	func port() -> LocationTrade
	{
		return LocationTrade(name: "port",system:.valen, at:CGPoint(x: offset.x + 1, y: offset.y), want:items.alta,give:items.usulPortalFragment2)
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name:"Satellite",system:.valen, at:CGPoint(x: offset.x, y: offset.y - 1), message:"horadric alta $with credit $for materia.", item:Item(name: items.materia.name!, type: items.materia.type, note:items.materia.note))
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
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:.senni, at:CGPoint(x: offset.x, y: offset.y - 1), leftKey: items.valenPortalKey, rightKey: items.usulPortalKey, leftName:"Valen", rightName: "Usul")
	}
	
	func station() -> LocationStation
	{
		return LocationStation(name:"station",system:.senni, at: CGPoint(x: offset.x + 1, y: offset.y), requirement:items.credit, installation:{ map.install() }, installationName:"Map")
	}
	
	func cargo() -> LocationSatellite
	{
		return LocationSatellite(name:"cargo",system:.senni, at:CGPoint(x: offset.x + 2, y: offset.y), message:"[misssing]", item:items.map1)
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name:"satellite",system:.senni, at:CGPoint(x: offset.x, y: offset.y + 1), message:"[misssing]", item:items.map2, mapRequirement: items.map1)
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