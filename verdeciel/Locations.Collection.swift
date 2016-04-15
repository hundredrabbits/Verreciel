
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationCollection
{
	let loiqe = Loiqe(offset: CGPoint(x: 0,y: -5))
	let usul  = Usul(offset: CGPoint(x: -5,y: 0))
	let valen = Valen(offset: CGPoint(x: 5,y: 0))
	let senni = Senni(offset: CGPoint(x: 0,y: 5))
	let nevic = Nevic(offset: CGPoint(x: 0,y: 0))
	
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
		return LocationSpawn(name: "awakening", system: system, at:CGPoint(x: offset.x, y: offset.y - 2.75))
	}
	
	func harvest() -> LocationHarvest
	{
		return LocationHarvest(name: "Harvest", system: system, at:CGPoint(x: offset.x, y: offset.y - 2), grows: Item(like:items.currency1))
	}
	
	func city() -> LocationTrade
	{
		return LocationTrade(name: "City", system:system, at: CGPoint(x: offset.x, y: offset.y - 1), want: items.currency1, give: items.valenPortalFragment1)
	}
	
	func horadric() -> LocationHoradric
	{
		return LocationHoradric(name:"Horadric",system:system, at: CGPoint(x: offset.x + 2, y: offset.y))
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal", system:system, at:CGPoint(x: offset.x, y: offset.y + 1))
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name: "satellite", system:system, at: CGPoint(x: offset.x + 1, y: offset.y), message:"Missing text here $will add soon$last line test", item: items.valenPortalFragment2)
	}
	
	func beacon() -> LocationBeacon
	{
		return LocationBeacon(name:"loiqe beacon",system:system, at: CGPoint(x: offset.x, y: offset.y - 3), message:"Are you absolutely sure that you are ~in space ...")
	}
	
	// Fog
	
	func fog() -> LocationTrade
	{
		return LocationTrade(name: "fog",system:system, at:CGPoint(x: offset.x - 1, y: offset.y), want:items.currency5, give:items.usulPortalFragment1, mapRequirement: items.map1)
	}
	
	// Ghost
	
	func gateway() -> LocationGateway
	{
		return LocationGateway(name: "gateway", system: .nevic, at: CGPoint(x: offset.x,y: offset.y + 2), key: items.masterKey, mapRequirement: items.map2)
	}
	
	// Constellations
	
	func c_1() -> LocationConstellation
	{
		return LocationConstellation(name: "tunnel", system:system, at: CGPoint(x:offset.x, y: offset.y - 1.5), structure: ConstellationTunnel())
	}
}

class Usul
{
	var system:Systems = .usul
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
		return LocationPortal(name: "portal",system:system, at:CGPoint(x: offset.x + 1, y: offset.y))
	}
	
	func station() -> LocationStation
	{
		return LocationStation(name:"station",system:system, at: CGPoint(x: offset.x + 2, y: offset.y - 1), requirement:items.currency4, installation:{ shield.install() }, installationName:"shield", mapRequirement:items.map2)
	}
	
	func wreck() -> LocationSatellite
	{
		return LocationSatellite(name:"Wreck",system:system, at:CGPoint(x: offset.x + 2, y: offset.y), message:"[missing]", item:items.map2, mapRequirement:items.map1)
	}
	
	func cargo() -> LocationStation
	{
		return LocationStation(name:"cargo",system:system, at: CGPoint(x: offset.x + 2, y: offset.y + 1), requirement:items.currency4, installation:{ shield.install() }, installationName:"shield", mapRequirement:items.map2)
	}
	
	func silence() -> LocationTrade
	{
		return LocationTrade(name: "silence", system: .usul, at: CGPoint(x: offset.x + 3, y: offset.y), want: items.currency6, give: items.shield1, mapRequirement: items.map2)
	}
}

class Valen
{
	var system:Systems = .valen
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		return LocationStar(name:"Valen",system:system, at: offset)
	}
	
	// North
	
	func bank() -> LocationBank
	{
		return LocationBank(name:"Bank",system:system, at: CGPoint(x: offset.x, y: offset.y + 1))
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:system, at:CGPoint(x: offset.x - 1, y: offset.y))
	}
	
	func harvest() -> LocationHarvest
	{
		return LocationHarvest(name: "harvest",system:system, at:CGPoint(x: offset.x, y: offset.y + 2), grows: Item(like:items.currency2))
	}
	
	func station() -> LocationStation
	{
		return LocationStation(name:"station",system:system, at: CGPoint(x: offset.x + 1, y: offset.y + 1), requirement:items.currency2, installation:{ radio.install() }, installationName:"Radio")
	}
	
	func cargo() -> LocationSatellite
	{
		return LocationSatellite(name:"cargo",system:system, at:CGPoint(x: offset.x + 1, y: offset.y + 2), message:"[misssing]", item:items.battery2)
	}
	
	// South
	
	func port() -> LocationTrade
	{
		return LocationTrade(name: "port",system:system, at:CGPoint(x: offset.x + 1, y: offset.y), want:items.currency4, give:items.senniPortalKey)
	}
	
	func fog() -> LocationTrade
	{
		return LocationTrade(name: "fog",system:system, at:CGPoint(x: offset.x, y: offset.y - 1), want:items.currency5, give:items.usulPortalFragment1, mapRequirement: items.map1)
	}
}

class Senni
{
	var system:Systems = .senni
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		return LocationStar(name:"Senni",system:system,at:offset)
	}
	
	func portal() -> LocationPortal
	{
		return LocationPortal(name: "portal",system:system, at:CGPoint(x: offset.x, y: offset.y - 1))
	}
	
	func cargo() -> LocationSatellite
	{
		return LocationSatellite(name:"cargo",system:system, at:CGPoint(x: offset.x - 1, y: offset.y), message:"[misssing]", item:items.map1)
	}
	
	func harvest() -> LocationHarvest
	{
		return LocationHarvest(name: "harvest",system:system, at:CGPoint(x: offset.x, y: offset.y + 1), grows: Item(like:items.currency3))
	}
	
	func station() -> LocationStation
	{
		return LocationStation(name:"station",system:system, at: CGPoint(x: offset.x + 1, y: offset.y), requirement:items.currency3, installation:{ map.install() }, installationName:"Map")
	}
	
	//
	
	func horadric() -> LocationHoradric
	{
		return LocationHoradric(name:"Horadric",system:system, at: CGPoint(x: offset.x, y: offset.y + 2), mapRequirement: items.map1)
	}
	
	func fog() -> LocationSatellite
	{
		return LocationSatellite(name:"fog",system:system, at:CGPoint(x: offset.x + 2, y: offset.y), message:"[misssing]", item:items.battery3, mapRequirement: items.map1)
	}
}

class Nevic
{
	var system:Systems = .nevic
	var offset:CGPoint!
	
	init(offset:CGPoint)
	{
		self.offset = offset
	}
	
	func star() -> LocationStar
	{
		return LocationStar(name:"Nevic",system:.nevic,at:offset)
	}
	
	func satellite() -> LocationSatellite
	{
		return LocationSatellite(name: "satellite", system: .nevic, at: CGPoint(x: offset.x,y: offset.y + 1), message: "[missing]", item: items.map3)
	}
	
	func gateway() -> LocationGateway
	{
		return LocationGateway(name: "gateway", system: .nevic, at: CGPoint(x: offset.x,y: offset.y - 1), key: items.masterKey, mapRequirement: items.map2)
	}
}