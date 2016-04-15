
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MissionCollection
{
	var story:Array<Mission> = Array<Mission>()
	
	init()
	{
		story = []
		build()
	}
	
	func build()
	{
		var m:Mission!
		
		// Loiqe
		
		m = Mission(id:(story.count), name: "")
		m.quests = [
			Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_spawn && universe.loiqe_spawn.isKnown == true }, result: { }),
			Quest(name:"Accelerate with Thruster", predicate:{ capsule.dock == nil && thruster.speed > 0 || capsule.dock != nil }, result: { intercom.install() ; thruster.lock() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_harvest.isKnown == true }, result: { cargo.install() ; thruster.lock() }),
			Quest(name:"Route \(items.currency1.name!) to cargo", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.currency1) }, result: { console.install() ; thruster.unlock() }),
			Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_harvest }, result: { radar.install() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_city.isKnown == true }, result: { battery.cellPort2.enable("empty",color:grey) ; battery.cellPort2.enable("empty",color:grey) }),
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Aquire Fragment")
		m.predicate = { cargo.contains(items.valenPortalFragment1) == true }
		m.quests = [
			Quest(name:"Route \(items.currency1.name!) to cargo", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.currency1) || capsule.isDockedAtLocation(universe.loiqe_city) }, result: { }),
			Quest(name:"Route \(items.currency1.name!) to trade table", location: universe.loiqe_city, predicate:{ universe.loiqe_city.isTradeAccepted == true }, result: { }),
			Quest(name:"Route \(items.valenPortalFragment1.name!) to cargo", predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { progress.install() }),
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Use radar")
		m.quests = [
			Quest(name:"Select satellite on radar", location:universe.loiqe_city, predicate:{ radar.port.event != nil && radar.port.event == universe.loiqe_satellite }, result: { pilot.install() ; thruster.unlock() }),
			Quest(name:"Route Radar to Pilot", predicate:{ pilot.port.origin != nil && pilot.port.origin == radar.port }, result: { })
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Combine fragments")
		m.predicate = { cargo.contains(items.valenPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire \(items.valenPortalFragment1.name!)", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true || capsule.isDockedAtLocation(universe.loiqe_horadric) == true }, result: { }),
			Quest(name:"Aquire \(items.valenPortalFragment2.name!)", location: universe.loiqe_satellite, predicate:{ cargo.contains(items.valenPortalFragment2) == true || capsule.isDockedAtLocation(universe.loiqe_horadric) == true }, result: {  }),
			Quest(name:"Combine fragments", location: universe.loiqe_horadric, predicate:{ cargo.contains(items.valenPortalKey) == true }, result: { })
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Portal Lesson")
		m.predicate = { universe.valen_portal.isKnown == true }
		m.quests = [
			Quest(name:"Route Key to Poral", location: universe.loiqe_portal, predicate:{ capsule.isDockedAtLocation(universe.loiqe_portal) && intercom.port.isReceiving(items.valenPortalKey) == true }, result: { }),
			Quest(name:"Align pilot to portal", location: universe.loiqe_portal, predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }),
			Quest(name:"Power Thruster with portal", location: universe.loiqe_portal, predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: { }),
		]
		story.append(m)
		
		// Go to Valen
		
		m = Mission(id:(story.count), name: "Install Radio")
		m.predicate = { radio.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect \(items.currency2.name!)", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.currency2) }, result: { }),
			Quest(name:"Install radio", location: universe.valen_station, predicate:{ radio.isInstalled == true }, result: { })
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Radio Lesson")
		m.quests = [
			Quest(name:"Collect second cell", location: universe.valen_cargo, predicate:{ battery.hasCell(items.battery1) || cargo.contains(items.battery2) }, result: {  }),
			Quest(name:"Install cell in battery", predicate:{ battery.hasCell(items.battery2) }, result: {  }),
			Quest(name:"Route cell to radio", predicate:{ battery.isRadioPowered() == true }, result: {  }),
			Quest(name:"Route record to radio", predicate:{ radio.port.hasItemOfType(.record) }, result: {  })
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Hatch Lesson")
		m.predicate = { hatch.count > 0 }
		m.quests = [
			Quest(name:"Collect Waste", location: universe.valen_bank, predicate:{ cargo.containsLike(items.waste) }, result: { hatch.install() }),
			Quest(name:"Route waste to hatch", predicate:{ hatch.port.hasItemLike(items.waste) }, result: {  }),
			Quest(name:"Jetison Waste", predicate:{ hatch.count > 0 }, result: {  })
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Loiqe Key")
		m.predicate = { cargo.containsLike(items.loiqePortalKey) }
		m.quests = [
			Quest(name:"Collect \(items.loiqePortalKey.name!)", location: universe.valen_bank, predicate:{ cargo.containsLike(items.loiqePortalKey) }, result: { })
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Craft \(items.currency4.name!)")
		m.predicate = { cargo.containsLike(items.currency4) }
		m.quests = [
			Quest(name:"Aquire \(items.currency2.name!)", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.currency2) }, result: { }),
			Quest(name:"Aquire \(items.currency1.name!)", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.currency1) }, result: { }),
			Quest(name:"Combine currencies", location: universe.loiqe_horadric, predicate:{ cargo.containsLike(items.currency4) }, result: { })
		]
		story.append(m)
		
		// Go to Valen(South)
		
		m = Mission(id:(story.count), name: "Senni Portal Key")
		m.predicate = { cargo.contains(items.senniPortalKey) }
		m.quests = [
			Quest(name:"Aquire \(items.currency4.name!)", predicate:{ cargo.containsLike(items.currency4) }, result: { }),
			Quest(name:"Trade \(items.currency4.name!) for \(items.senniPortalKey.name!)", location: universe.valen_port, predicate:{ cargo.contains(items.senniPortalKey) }, result: { })
		]
		story.append(m)
		
		// Go to Senni
		
		m = Mission(id:(story.count), name: "Reach Senni System")
		m.predicate = { universe.senni_portal.isKnown == true }
		m.quests = [
			Quest(name:"Reach Senni Portal", predicate:{ universe.senni_portal.isKnown == true }, result: { })
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Install Map")
		m.predicate = { map.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.map1.name!)", location: universe.senni_cargo, predicate:{ cargo.contains(items.map1) }, result: {  }),
			Quest(name:"Collect \(items.currency3.name!)", location: universe.senni_harvest, predicate:{ cargo.containsLike(items.currency3) }, result: { }),
			Quest(name:"Install map", location: universe.senni_station, predicate:{ map.isInstalled == true }, result: { })
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Map Lesson")
		m.quests = [
			Quest(name:"Power Map in battery", predicate:{ battery.isMapPowered() == true }, result: {  }),
			Quest(name:"Route fog to map", predicate:{ map.port.hasItemOfType(.map) }, result: {  }),
			Quest(name:"Collect first array", location: universe.senni_fog, predicate:{ battery.hasCell(items.battery3) || cargo.contains(items.battery3) }, result: {  }),
			Quest(name:"Install array in battery", predicate:{ battery.hasCell(items.battery3) }, result: {  }),
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Helmet Lesson")
		m.quests = [
			Quest(name:"Route map to helmet", predicate:{ player.port.isReceivingFromPanel(map) == true }, result: {  })
		]
		story.append(m)
		
		// Return to Loiqe
		
		m = Mission(id:(story.count), name: "Create \(items.currency5)")
		m.quests = [
			Quest(name:"Collect \(items.currency3)", location: universe.senni_harvest, predicate:{ cargo.containsLike(items.currency3) }, result: {  }),
			Quest(name:"Collect \(items.currency2)", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.currency2) }, result: {  }),
			Quest(name:"Combine currencies", predicate:{ cargo.containsLike(items.currency5) }, result: { }),
		]
		story.append(m)
		
		m = Mission(id:(story.count), name: "Usul Portal Key")
		m.predicate = { cargo.contains(items.usulPortalKey) }
		m.quests = [
			Quest(name:"Trade \(items.currency5)", location: universe.valen_fog, predicate:{ cargo.containsLike(items.usulPortalFragment1) }, result: {  }),
			Quest(name:"Trade \(items.currency4)", location: universe.loiqe_fog, predicate:{ cargo.containsLike(items.usulPortalFragment2) }, result: {  }),
			Quest(name:"Combine key fragments", location: universe.loiqe_horadric, predicate:{ cargo.contains(items.usulPortalKey) }, result: { }),
		]
		story.append(m)
		
		// Go to Usul
		
		m = Mission(id:(story.count), name: "Reach Usul System")
		m.predicate = { universe.usul_portal.isKnown == true }
		m.quests = [
			Quest(name:"Reach Usul Portal", location: universe.loiqe_portal, predicate:{ universe.usul_portal.isKnown == true }, result: { })
		]
		story.append(m)
		
		// Star interaction tutorial
		
		// enigma quest & tutorials - decypher radio signal quest
		
		m = Mission(id:(story.count), name: "Last Quest")
		m.quests = [
			Quest(name:"Unlock portal", location: universe.nevic, predicate:{ universe.nevic.isKnown == true }, result: { })
		]
		story.append(m)
	}
	
	// MARK: Tools -
	
	var currentMission:Mission = Mission(id:0, name: "--")
	
	func refresh()
	{
		currentMission.validate()
		if currentMission.isCompleted == true {
			updateCurrentMission()
			helmet.addWarning(currentMission.name, color:cyan, duration:3, flag:"mission")
		}
	}
	
	func updateCurrentMission()
	{
		for mission in story {
			if mission.isCompleted == false { currentMission = mission ; return }
		}
	}
}