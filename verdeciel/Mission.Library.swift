
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MissionLibrary
{
	var active:Chapters = Chapters.discovery
	var questlog:Dictionary<Chapters,Array<Mission>> = [Chapters:Array]()
	var currentMission:Dictionary<Chapters,Mission> = [Chapters:Mission]()
	
	init()
	{
		questlog[Chapters.discovery] = []
		questlog[Chapters.capsule] = []
		questlog[Chapters.exploration] = []
		
		create_discoveryMissions()
		create_capsuleMissions()
		create_explorationMissions()
		
		currentMission[.discovery] = questlog[.discovery]?.first
		currentMission[.capsule] = questlog[.capsule]?.first
		currentMission[.exploration] = questlog[.exploration]?.first
	}
	
	func create_discoveryMissions()
	{
		let c:Chapters = .discovery
		var m:Mission!
		
		// [Basic] Initial Tutorial
		
		m = Mission(id:(questlog[c]?.count)!, name: "Flight Lesson")
		m.quests = [
			Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_spawn && universe.loiqe_spawn.isKnown == true }, result: { }),
			Quest(name:"Accelerate with Thruster", predicate:{ capsule.dock == nil && thruster.speed > 0 || capsule.dock != nil }, result: { mission.install() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_harvest.isKnown == true }, result: { cargo.install() }),
			Quest(name:"Route materia to cargo", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.materia) }, result: { console.install() }),
			Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_harvest }, result: { radar.install() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_city.isKnown == true }, result: { }),
			Quest(name:"Select satellite on radar", location:universe.loiqe_city, predicate:{ radar.port.event != nil && radar.port.event == universe.loiqe_satellite }, result: { pilot.install() }),
			Quest(name:"Route Radar to Pilot", predicate:{ pilot.port.origin != nil && pilot.port.origin == radar.port }, result: { })
		]
		questlog[c]?.append(m)
		
		// [Location] Trade location tutorial
		
		m = Mission(id:(questlog[c]?.count)!, name: "Trade Lesson")
		m.predicate = { cargo.contains(items.valenPortalFragment1) == true }
		m.quests = [
			Quest(name:"Route materia to cargo", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.materia) || capsule.isDockedAtLocation(universe.loiqe_city) }, result: { }),
			Quest(name:"Trade materia for Fragment", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { progress.install() })
		]
		questlog[c]?.append(m)
		
		// [Location] Portal location tutorial
		
		m = Mission(id:(questlog[c]?.count)!, name: "Portal Lesson", task: "Build Valen Portal Key", requirement: { cargo.contains(items.valenPortalKey) == true })
		m.predicate = { universe.valen_portal.isKnown == true }
		m.quests = [
			Quest(name:"Route Key to Poral", location: universe.loiqe_portal, predicate:{ universe.loiqe_portal.rightKeyPort.isReceiving(items.valenPortalKey) == true }, result: { universe.unlock(.valen) }),
			Quest(name:"Align pilot to portal", location: universe.loiqe_portal, predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }),
			Quest(name:"Power Thruster with portal", location: universe.loiqe_portal, predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: { }),
		]
		questlog[c]?.append(m)
		
		// Console Inspect tutorials
		
		m = Mission(id:(questlog[c]?.count)!, name: "Inspect Lesson I", requirement: { radio.isInstalled == true })
		m.quests = [
			Quest(name:"Reach bank", location: universe.valen_bank, predicate:{ capsule.isDockedAtLocation(universe.valen_bank) }, result: { }),
			Quest(name:"Route item to console", location: universe.valen_bank, predicate:{ console.port.isReceivingEventOfTypeItem() }, result: {  })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Inspect Lesson II")
		m.quests = [
			Quest(name:"Reach bank", location: universe.valen_bank, predicate:{ capsule.isDockedAtLocation(universe.valen_bank) }, result: { }),
			Quest(name:"Route radar to console", location: universe.valen_bank, predicate:{ console.port.isReceivingEventOfTypeLocation() }, result: { })
		]
		questlog[c]?.append(m)
		
		// Cells->Array tutorial
		
		m = Mission(id:(questlog[c]?.count)!, name: "Cells Lesson")
		m.predicate = { cargo.contains(items.array1) == true || battery.contains(items.array1) }
		m.quests = [
			Quest(name:"Find first Cell", location: universe.valen_harvest, predicate:{ cargo.contains(items.cell1) || battery.contains(items.cell1) || universe.valen_bank.contains(items.cell1) }, result: { }),
			Quest(name:"Find second Cell", location: universe.valen_cargo, predicate:{ cargo.contains(items.cell2) || battery.contains(items.cell2) || universe.valen_bank.contains(items.cell2) }, result: { }),
			Quest(name:"Find last Cell", location: universe.loiqe_cargo, predicate:{ cargo.contains(items.cell3) || battery.contains(items.cell3) || universe.valen_bank.contains(items.cell3) }, result: { }),
			Quest(name:"Combine Cells", location: universe.loiqe_horadric, predicate:{ false }, result: { })
		]
		questlog[c]?.append(m)
		
		// Hatch tutorial
		
		m = Mission(id:(questlog[c]?.count)!, name: "Hatch Lesson")
		m.quests = [
			Quest(name:"Collect Credit", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.credit) }, result: { }),
			Quest(name:"Route credit to hatch", location: universe.valen_harvest, predicate:{ hatch.port.isReceivingItemOfType(.currency) }, result: {  })
		]
		questlog[c]?.append(m)
		
		// Array->Grid Tutorial
		
		m = Mission(id:(questlog[c]?.count)!, name: "Array Lesson")
		m.predicate = { cargo.contains(items.grid1) == true || battery.contains(items.grid1) }
		m.quests = [
			Quest(name:"Find first Array", location: universe.valen_harvest, predicate:{ cargo.contains(items.array1) || battery.contains(items.array1) || universe.valen_bank.contains(items.array1) }, result: { }),
			Quest(name:"Find second Array", location: universe.valen_harvest, predicate:{ cargo.contains(items.array2) || battery.contains(items.array2) || universe.valen_bank.contains(items.array2) }, result: { }),
			Quest(name:"Find last Array", location: universe.valen_harvest, predicate:{ cargo.contains(items.array3) || battery.contains(items.array3) || universe.valen_bank.contains(items.array3) }, result: { }),
			Quest(name:"Combine Arrays", location: universe.loiqe_horadric, predicate:{ false }, result: { })
		]
		questlog[c]?.append(m)
		
		// Materia->Alta
		
		m = Mission(id:(questlog[c]?.count)!, name: "Alta Lesson")
		m.predicate = { cargo.containsLike(items.alta) == true }
		m.quests = [
			Quest(name:"Find materia", location: universe.loiqe_harvest, predicate:{ cargo.containsLike(items.materia) }, result: { }),
			Quest(name:"Find second materia", location: universe.loiqe_harvest, predicate:{ cargo.containsCount(2,target: items.materia) }, result: { }),
			Quest(name:"Combine materias", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
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
	
	func create_capsuleMissions()
	{
		let c:Chapters = .capsule
		var m:Mission!
		
		// Radio
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Radio", task: "Reach Valen System", requirement: { universe.valen_portal.isKnown == true })
		m.predicate = { radio.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect credit", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.credit) }, result: { }),
			Quest(name:"Install radio", location: universe.valen_station, predicate:{ radio.isInstalled == true }, result: { })
		]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Radio Tutorial 1") // Input
		m.quests = [ Quest(name:"Power radio in battery panel", predicate:{ battery.isRadioPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route record to radio", predicate:{ radio.isPlaying() == true }, result: {  }) ]
		questlog[c]?.append(m)
		
		m = Mission(id:(questlog[c]?.count)!, name: "Radio Tutorial 2") // Output
		m.requirement = { universe.valen_cargo.isKnown == true }
		m.quests = [ Quest(name:"Power radio in battery panel", predicate:{ battery.isRadioPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route radio to radar", location: universe.valen_station, predicate:{ radar.port.origin != nil && radar.port.origin == radio.port }, result: {  }) ]
		m.quests = [ Quest(name:"Reach stealth location", predicate:{ false }, result: { progress.install() }) ]
		questlog[c]?.append(m)
		
		// Map
		
		m = Mission(id:(questlog[c]?.count)!, name: "Install Map")
		m.requirement = { universe.valen_portal.isKnown == true }
		m.predicate = { map.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.credit) }, result: { }),
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
			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.containsLike(items.credit) }, result: { }),
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
			Quest(name:"Collect \(items.uli.name!)", predicate:{ cargo.containsLike(items.uli) }, result: { }),
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
	
	func create_explorationMissions()
	{
		let c:Chapters = .exploration
		var m:Mission!
		
		// Loiqe
		
		m = Mission(id:(questlog[c]?.count)!, name: "Valen Portal Key", task: "Find valen portal fragment", requirement:{ cargo.contains(items.valenPortalFragment1) || cargo.contains(items.valenPortalFragment2) } )
		m.predicate = { cargo.contains(items.valenPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true || capsule.isDockedAtLocation(universe.loiqe_horadric) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.loiqe_satellite, predicate:{ cargo.contains(items.valenPortalFragment2) == true || capsule.isDockedAtLocation(universe.loiqe_horadric) == true }, result: {  }),
			Quest(name:"Combine fragments", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
		
		// Valen
		
		m = Mission(id:(questlog[c]?.count)!, name: "Senni Portal Key", task: "Find senni portal fragment", requirement:{ cargo.contains(items.senniPortalFragment1) || cargo.contains(items.senniPortalFragment2) } )
		m.requirement = { cargo.contains(items.valenPortalFragment1) || cargo.contains(items.valenPortalFragment2) }
		m.predicate = { cargo.contains(items.senniPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.valen_port, predicate:{ cargo.contains(items.senniPortalFragment1) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.loiqe_port, predicate:{ cargo.contains(items.senniPortalFragment2) == true }, result: {  }),
			Quest(name:"Combine fragments", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
		
		// Senni
		
		m = Mission(id:(questlog[c]?.count)!, name: "Usul Portal Key", task: "Find usul portal fragment", requirement:{ cargo.contains(items.usulPortalFragment1) || cargo.contains(items.usulPortalFragment2) } )
		m.predicate = { cargo.contains(items.usulPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.senni_port, predicate:{ cargo.contains(items.usulPortalFragment1) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.nevic_port, predicate:{ cargo.contains(items.usulPortalFragment2) == true }, result: {  }),
			Quest(name:"Combine fragments", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
		
		// Trans Portal
		
		m = Mission(id:(questlog[c]?.count)!, name: "Trans Portal Key")
		m.predicate = { cargo.contains(items.transPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire Loiqe Key", predicate:{ cargo.contains(items.loiqePortalKey) == true }, result: { }),
			Quest(name:"Aquire Valen Key", predicate:{ cargo.contains(items.valenPortalKey) == true }, result: { }),
			Quest(name:"Aquire Senni Key", predicate:{ cargo.contains(items.senniPortalKey) == true }, result: { }),
			Quest(name:"Aquire Usul Key", predicate:{ cargo.contains(items.usulPortalKey) == true }, result: { }),
			Quest(name:"Combine all keys", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[c]?.append(m)
	}
	
	func refresh()
	{
		currentMission[.discovery]?.validate()
		if currentMission[.discovery]?.isCompleted == true {
			let nextMissionId = currentMission[.discovery]!.id + 1
			currentMission[.discovery] = questlog[.discovery]![nextMissionId]
		}
		
		currentMission[.capsule]?.validate()
		if currentMission[.capsule]?.isCompleted == true {
			let nextMissionId = currentMission[.capsule]!.id + 1
			currentMission[.capsule] = questlog[.capsule]![nextMissionId]
		}
		
		currentMission[.exploration]?.validate()
		if currentMission[.exploration]?.isCompleted == true {
			let nextMissionId = currentMission[.exploration]!.id + 1
			currentMission[.exploration] = questlog[.exploration]![nextMissionId]
		}
		
		mission.update()
		
		if currentMission[active]?.requirement() == false {
			if active == .discovery { mission.touch(2) }
			else if active == .capsule { mission.touch(3) }
			else if active == .exploration { mission.touch(1) }
		}
	}
	
	func setActive(chapter:Chapters)
	{
		active = chapter
	}
}




