
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MissionLibrary
{
	var active:Chapters = Chapters.primary
	var questlog:Dictionary<Chapters,Array<Mission>> = [Chapters:Array<Mission>]()
	var currentMission:Dictionary<Chapters,Mission> = [Chapters:Mission]()
	
	init()
	{
		questlog[Chapters.primary] = []
		questlog[Chapters.secondary] = []
		questlog[Chapters.tertiary] = []
		
		create_primaryMissions()
		create_secondaryMissions()
		create_tertiaryMissions()
		
		currentMission[.primary] = questlog[.primary]?.first
		currentMission[.secondary] = questlog[.secondary]?.first
		currentMission[.tertiary] = questlog[.tertiary]?.first
	}
	
	func create_primaryMissions()
	{
		let c:Chapters = .primary
		var m:Mission!
		
		// Loiqe
		
		m = Mission(id:(questlog[c]?.count)!, name: "Flight")
		m.quests = [
			Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_spawn && universe.loiqe_spawn.isKnown == true }, result: { }),
			Quest(name:"Accelerate with Thruster", predicate:{ capsule.dock == nil && thruster.speed > 0 || capsule.dock != nil }, result: { mission.install() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_harvest.isKnown == true }, result: { cargo.install() ; thruster.lock() }),
			Quest(name:"Route \(items.currency1.name!) to cargo", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.currency1) }, result: { console.install() ; thruster.unlock() }),
			Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_harvest }, result: { radar.install() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_city.isKnown == true }, result: { }),
			Quest(name:"Select satellite on radar", location:universe.loiqe_city, predicate:{ radar.port.event != nil && radar.port.event == universe.loiqe_satellite }, result: { pilot.install() }),
			Quest(name:"Route Radar to Pilot", predicate:{ pilot.port.origin != nil && pilot.port.origin == radar.port }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Trade Lesson")
		m.predicate = { cargo.contains(items.valenPortalFragment1) == true }
		m.quests = [
			Quest(name:"Route \(items.currency1.name!) to cargo", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.currency1) || capsule.isDockedAtLocation(universe.loiqe_city) }, result: { }),
			Quest(name:"Trade \(items.currency1.name!) for \(items.valenPortalFragment1.type!)", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { progress.install() })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Valen Portal Key")
		m.predicate = { cargo.contains(items.valenPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire \(items.valenPortalFragment1.name!)", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true || capsule.isDockedAtLocation(universe.loiqe_horadric) == true }, result: { }),
			Quest(name:"Aquire \(items.valenPortalFragment2.name!)", location: universe.loiqe_satellite, predicate:{ cargo.contains(items.valenPortalFragment2) == true || capsule.isDockedAtLocation(universe.loiqe_horadric) == true }, result: {  }),
			Quest(name:"Combine fragments", location: universe.loiqe_horadric, predicate:{ cargo.contains(items.valenPortalKey) == true }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Portal Lesson")
		m.predicate = { universe.valen_portal.isKnown == true }
		m.quests = [
			Quest(name:"Route Key to Poral", location: universe.loiqe_portal, predicate:{ universe.loiqe_portal.rightKeyPort.isReceiving(items.valenPortalKey) == true }, result: { universe.unlock(.valen) }),
			Quest(name:"Align pilot to portal", location: universe.loiqe_portal, predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }),
			Quest(name:"Power Thruster with portal", location: universe.loiqe_portal, predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: { }),
		]
		questlog[c]?.append(m)
		
		// Valen
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Radio") //TODO: should collect second cell?
		m.predicate = { radio.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect \(items.currency2.name!)", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.currency2) }, result: { }),
			Quest(name:"Install radio", location: universe.valen_station, predicate:{ radio.isInstalled == true }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Radio Lesson")
		m.quests = [
			Quest(name:"Collect second cell", location: universe.valen_cargo, predicate:{ battery.hasCell(items.cell2) }, result: {  }),
			Quest(name:"Power radio in battery panel", predicate:{ battery.isRadioPowered() == true }, result: {  }),
			Quest(name:"Route record to radio", predicate:{ radio.port.hasItemOfType(.record) }, result: {  })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Hatch Lesson")
		m.quests = [
			Quest(name:"Collect Waste", location: universe.valen_bank, predicate:{ cargo.containsLike(items.waste) }, result: { hatch.install() }),
			Quest(name:"Route waste to hatch", location: universe.valen_harvest, predicate:{ hatch.port.hasItemLike(items.waste) }, result: {  })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Senni Portal Key")
		m.predicate = { cargo.contains(items.senniPortalKey) }
		m.quests = [
			
			Quest(name:"Aquire \(items.currency2.name!)", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.currency2) }, result: { }),
			Quest(name:"Aquire \(items.currency1.name!)", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.currency1) }, result: { }),
			Quest(name:"Combine currencies", location: universe.loiqe_horadric, predicate:{ cargo.containsLike(items.currency3) }, result: { }),
			Quest(name:"Aquire \(items.senniPortalKey.name)", location: universe.valen_port, predicate:{ cargo.contains(items.senniPortalKey) }, result: { })
		]
		questlog[c]?.append(m)
		
		// Star interaction tutorial
		
		// enigma quest & tutorials - decypher radio signal quest
		
		m = Mission(id:(questlog[c]?.count)!, name: "Last Quest")
		m.quests = [
			Quest(name:"Unlock portal", location: universe.usul_portal, predicate:{ universe.usul_portal.isKnown == true }, result: { universe.unlock(.valen) })
		]
		questlog[c]?.append(m)
	}
	
	func create_secondaryMissions()
	{
		let c:Chapters = .secondary
		var m:Mission!
		
		m = Mission(id:(questlog[c]?.count)!, name: "Last Quest")
		m.quests = [
			Quest(name:"Unlock portal", location: universe.usul_portal, predicate:{ universe.usul_portal.isKnown == true }, result: { universe.unlock(.valen) })
		]
		questlog[c]?.append(m)
		
		// Map
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Map")
		m.requirement = { universe.valen_portal.isKnown == true }
		m.predicate = { map.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
//			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.credit) }, result: { }),
			Quest(name:"Install map", location: universe.senni_station, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Map Tutorial 1") // TODO: Add input tutorial
		m.quests = [ Quest(name:"Power map in battery panel", predicate:{ battery.isMapPowered() == true }, result: { }) ]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Map Tutorial 2") // Input
		m.quests = [ Quest(name:"Power map in battery panel", predicate:{ battery.isMapPowered() == true }, result: { }) ]
		m.quests = [ Quest(name:"Route map to helmet", predicate:{ player.port.origin != nil && player.port.origin == map.port }, result: {  }) ]
		m.quests = [ Quest(name:"--", predicate:{ true }, result: { exploration.install() }) ]
		questlog[c]?.append(m)
		
		// Shield
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Shield")
		m.requirement = { universe.senni_portal.isKnown == true }
		m.predicate = { shield.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
//			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.credit) }, result: { }),
			Quest(name:"Install shield", location: universe.usul_station, predicate:{ m.predicate() }, result: { }),
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Shield Tutorial 1") // Input
		m.quests = [ Quest(name:"Power shield in battery panel", predicate:{ battery.isShieldPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route shape to shield", predicate:{ shield.isActive == true }, result: { }) ]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Shield Tutorial 2") // TODO: Add output tutorial
		m.quests = [ Quest(name:"Power shield in battery panel", predicate:{ battery.isShieldPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route shape to shield", predicate:{ shield.isActive == true }, result: { }) ]
		m.quests = [ Quest(name:"--", predicate:{ true }, result: { journey.install() }) ]
		questlog[c]?.append(m)
		
		// Enigma
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Enigma")
		m.requirement = { universe.usul_portal.isKnown == true }
		m.predicate = { enigma.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.cypher1.name!)", location: universe.usul_satellite, predicate:{ cargo.contains(items.cypher1) }, result: {  }),
//			Quest(name:"Collect \(items.uli.name!)", predicate:{ cargo.containsLike(items.uli) }, result: { }),
			Quest(name:"Install enigma", location: universe.usul_station, predicate:{ m.predicate() }, result: { }),
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Enigma Tutorial 1") // Input
		m.quests = [ Quest(name:"Power Enigma in battery panel", predicate:{ battery.isEnigmaPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route cypher to Enigma", predicate:{ enigma.isActive == true }, result: { }) ]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Enigma Tutorial 2") // TODO: Add output tutorial
		m.quests = [ Quest(name:"Power Enigma in battery panel", predicate:{ battery.isEnigmaPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"--", predicate:{ true }, result: {  }) ]
		questlog[c]?.append(m)
	}
	
	func create_tertiaryMissions()
	{
		let c:Chapters = .tertiary
		var m:Mission!
		
		m = Mission(id:(questlog[c]?.count)!, name: "Usul Portal Key", task: "Find usul portal fragment", requirement:{ cargo.contains(items.usulPortalFragment1) || cargo.contains(items.usulPortalFragment2) } )
		m.predicate = { cargo.contains(items.usulPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.senni_portal, predicate:{ cargo.contains(items.usulPortalFragment1) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.senni_portal, predicate:{ cargo.contains(items.usulPortalFragment2) == true }, result: {  }),
			Quest(name:"Combine fragments", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
	}
	
	func refresh()
	{
		currentMission[.primary]?.validate()
		if currentMission[.primary]?.isCompleted == true {
			let nextMissionId = currentMission[.primary]!.id + 1
			currentMission[.primary] = questlog[.primary]![nextMissionId]
		}
		
		currentMission[.secondary]?.validate()
		if currentMission[.secondary]?.isCompleted == true {
			let nextMissionId = currentMission[.secondary]!.id + 1
			currentMission[.secondary] = questlog[.secondary]![nextMissionId]
		}
		
		currentMission[.tertiary]?.validate()
		if currentMission[.tertiary]?.isCompleted == true {
			let nextMissionId = currentMission[.tertiary]!.id + 1
			currentMission[.tertiary] = questlog[.tertiary]![nextMissionId]
		}
		
		mission.update()
		
		if currentMission[active]?.requirement() == false {
			if active == .primary { mission.touch(2) }
			else if active == .secondary { mission.touch(3) }
			else if active == .tertiary { mission.touch(1) }
		}
	}
	
	func setActive(chapter:Chapters)
	{
		active = chapter
	}
}