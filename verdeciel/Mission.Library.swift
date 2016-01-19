
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
		var m:Mission!
		
		// Loiqe
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Flight Lesson")
		m.quests = [
			Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_spawn && universe.loiqe_spawn.isKnown == true }, result: { mission.install() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_landing.isKnown == true }, result: { cargo.install() }),
			Quest(name:"Route materia to cargo", predicate:{ cargo.contains(items.materia) }, result: { console.install() }),
			Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }),
			Quest(name:"Undock from Landing", predicate:{ capsule.dock != universe.loiqe_landing && universe.loiqe_landing.isKnown == true }, result: { radar.install() }),
			Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown == true }, result: { })
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Valen Portal Key")
		m.quests = [
			Quest(name:"Trade materia for fragment", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { pilot.install() }),
			Quest(name:"Route radar to pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: {  }),
			Quest(name:"Collect second fragment", location: universe.loiqe_satellite, predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: { }),
			Quest(name:"Combine fragments at Horadric", location: universe.loiqe_horadric,  predicate:{ (cargo.contains(items.valenPortalKey) == true) }, result: { })
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Portal Lesson")
		m.quests = [
			Quest(name:"Unlock portal", location: universe.loiqe_portal, predicate:{ universe.loiqe_portal.rightKeyPort.isReceiving(items.valenPortalKey) == true }, result: { universe.unlock(.valen) }),
			Quest(name:"Align to portal", location: universe.loiqe_portal, predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }),
			Quest(name:"Power Thruster", location: universe.loiqe_portal, predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: {  }),
		]
		questlog[.discovery]?.append(m)
		
		// Valen
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Reach Valen")
		m.quests = [
			Quest(name:"Warp to Valen system", location: universe.loiqe_portal, predicate:{ universe.valen_portal.isKnown == true }, result: { universe.unlock(.valen) })
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Senni Portal Key")
		m.predicate = { cargo.contains(items.senniPortalKey) == true }
		m.quests = [
			Quest(name:"Route Radio to Radar", location: universe.valen_station, predicate:{ radar.port.origin != nil && radar.port.origin == radio.port }, result: {  }),
			Quest(name:"Collect portal fragment", location: universe.valen_port, predicate:{ cargo.contains(items.senniPortalFragment1) }, result: { }),
			Quest(name:"Find Alta recipe", location: universe.valen_beacon, predicate:{ universe.valen_beacon.isKnown == true }, result: { }),
			Quest(name:"Locate stealth port", location: universe.loiqe_city, predicate:{ universe.loiqe_port.isKnown == true }, result: { }),
			Quest(name:"Trade alta for fragment", location: universe.loiqe_port, predicate:{ cargo.contains(items.senniPortalFragment2) }, result: { }),
			Quest(name:"Combine fragments at horadric", location: universe.loiqe_horadric, predicate:{ cargo.contains(items.senniPortalKey) }, result: { }),
		]
		questlog[.discovery]?.append(m)
		
		// Senni
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Reach Senni")
		m.quests = [
			Quest(name:"Warp to Senni system", location: universe.valen_portal, predicate:{ universe.senni_portal.isKnown == true }, result: { universe.unlock(.senni) })
		]
		questlog[.discovery]?.append(m)
		
		// Usul
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Reach Usul")
		m.quests = [
			Quest(name:"Warp to Usul system", location: universe.senni_portal, predicate:{ universe.usul_portal.isKnown == true }, result: { universe.unlock(.usul) })
		]
		questlog[.discovery]?.append(m)
		
		
		
		
		
		
		
		
		/*
		
		m = Mission(id:6, name: "Extinguish the sun")
		m.quests = [
			Quest(name:"Reach station", predicate:{ universe.valen_station.isKnown == true }, result: { }),
			Quest(name:"Find credits", predicate:{ cargo.contains(items.credits.name!,type: items.credits.type) == true }, result: { }),
			Quest(name:"Install shield", predicate:{ universe.valen_station.isComplete == true }, result: { }),
			Quest(name:"Route cell to shield", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { }),
			Quest(name:"Reach Valen star", predicate:{ universe.valen.isKnown == true }, result: { }),
			Quest(name:"Extinguish the sun", predicate:{ universe.valen.isComplete == true }, result: { journey.install() ; exploration.install() ; progress.install() ; complete.install() ; universe.unlock(.cyanine) })
		]
		questlog[.tutorial]?.append(m)
		
		missionPredicate = (cargo.contains(items.waste) == false && hatch.isInstalled == true )
		
		questlog[.tutorial]?.append(["The hatch" :
			[
				Quest(name:"Visit the bank", predicate:{ missionPredicate || universe.valen_bank.isKnown == true }, result: { }),
				Quest(name:"Collect Loiqe Key", predicate:{ missionPredicate || cargo.contains(items.loiqePortalKey) }, result: { }),
				Quest(name:"Collect Waste", predicate:{ missionPredicate || cargo.contains(items.waste) }, result: { hatch.install() }),
				Quest(name:"Route Waste to hatch", predicate:{ missionPredicate || hatch.port.isReceiving(items.waste) }, result: { }),
				Quest(name:"Jetison Waste", predicate:{ missionPredicate || cargo.contains(items.waste) == false }, result: { })
			]
		])
		
		questlog[.tutorial]?.append(["Venic" :
			[
				Quest(name:"Reach venic II", predicate:{ universe.cyanine_venic.isKnown == true }, result: { universe.unlock(.venic) }),
				Quest(name:"Cross to venic", predicate:{ universe.venic.isKnown == true }, result: {  }),
				Quest(name:"Reach satellite", predicate:{ universe.venic_satellite.isKnown == true }, result: {  }),
				Quest(name:"Find array", predicate:{ universe.venic_satellite.isComplete == true }, result: {  }),
				Quest(name:"Combine cells at Horadric", predicate:{ cargo.contains(items.array2) == true }, result: {  })
			]
		])
		questlog[.tutorial]?.append(["Create Venic Key" :
			[
				Quest(name:"Get fragment at", predicate:{ universe.cyanine_venic.isKnown == true }, result: { universe.unlock(.venic) })
			]
		])

*/
	}
	
	func create_capsuleMissions()
	{
		var m:Mission!
		
		// Radio
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Install Radio")
		m.predicate = { radio.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.contains("credits", type: .currency) }, result: { }),
			Quest(name:"Install radio", location: universe.valen_station, predicate:{ m.predicate() }, result: { })
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Radio Tutorial 1") // Input
		m.quests = [ Quest(name:"Power radio in battery panel", predicate:{ battery.isRadioPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route record to radio", predicate:{ radio.isPlaying == true }, result: {  }) ]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Radio Tutorial 2") // Output
		m.quests = [ Quest(name:"Power radio in battery panel", predicate:{ battery.isRadioPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route radio to radar", location: universe.valen_station, predicate:{ radar.port.origin != nil && radar.port.origin == radio.port }, result: {  }) ]
		questlog[.discovery]?.append(m)
		
		// Map
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Install Map")
		m.predicate = { map.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.contains("credits", type: .currency) }, result: { }),
			Quest(name:"Install map", location: universe.senni_station, predicate:{ m.predicate() }, result: { })
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Map Tutorial 1") // TODO: Add input tutorial
		m.quests = [ Quest(name:"Power map in battery panel", predicate:{ battery.isMapPowered() == true }, result: { }) ]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Map Tutorial 2") // Input
		m.quests = [ Quest(name:"Power map in battery panel", predicate:{ battery.isMapPowered() == true }, result: { }) ]
		m.quests = [ Quest(name:"Route map to helmet", predicate:{ player.port.origin != nil && player.port.origin == map.port }, result: {  }) ]
		questlog[.discovery]?.append(m)
		
		
		// Shield
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Install Shield")
		m.predicate = { shield.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.record1.name!)", location: universe.valen_bank, predicate:{ cargo.contains(items.record1) }, result: {  }),
			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.contains("credits", type: .currency) }, result: { }),
			Quest(name:"Install shield", location: universe.usul_station, predicate:{ m.predicate() }, result: { }),
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Shield Tutorial 1") // Input
		m.quests = [ Quest(name:"Power shield in battery panel", predicate:{ battery.isShieldPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route shape to shield", predicate:{ shield.isActive == true }, result: { }) ]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Shield Tutorial 2") // TODO: Add output tutorial
		m.quests = [ Quest(name:"Power shield in battery panel", predicate:{ battery.isShieldPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route shape to shield", predicate:{ shield.isActive == true }, result: { }) ]
		questlog[.discovery]?.append(m)
		
		// Enigma
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Install Enigma")
		m.predicate = { enigma.isInstalled == true }
		m.quests = [
			Quest(name:"Collect \(items.cypher1.name!)", location: universe.usul_satellite, predicate:{ cargo.contains(items.cypher1) }, result: {  }),
			Quest(name:"Collect \(items.uli.name!)", predicate:{ cargo.contains("uli", type: .currency) }, result: { }),
			Quest(name:"Install enigma", location: universe.usul_station, predicate:{ m.predicate() }, result: { }),
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Enigma Tutorial 1") // Input
		m.quests = [ Quest(name:"Power Enigma in battery panel", predicate:{ battery.isEnigmaPowered() == true }, result: {  }) ]
		m.quests = [ Quest(name:"Route cypher to Enigma", predicate:{ enigma.isActive == true }, result: { }) ]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.capsule]?.count)!, name: "Enigma Tutorial 2") // TODO: Add output tutorial
		m.quests = [ Quest(name:"Power Enigma in battery panel", predicate:{ battery.isEnigmaPowered() == true }, result: {  }) ]
		questlog[.discovery]?.append(m)
	}
	
	func create_explorationMissions()
	{
		var m:Mission!
		
		// Portal Keys
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Valen Portal Key")
		m.predicate = { cargo.contains(items.valenPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.loiqe_satellite, predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: {  }),
			Quest(name:"Combine fragments at Horadric", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Senni Portal Key")
		m.predicate = { cargo.contains(items.valenPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.valen_port, predicate:{ cargo.contains(items.senniPortalFragment1) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.loiqe_port, predicate:{ cargo.contains(items.senniPortalFragment2) == true }, result: {  }),
			Quest(name:"Combine fragments at Horadric", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Usul Portal Key")
		m.predicate = { cargo.contains(items.usulPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire fragment I", location: universe.senni_port, predicate:{ cargo.contains(items.usulPortalFragment1) == true }, result: { }),
			Quest(name:"Aquire fragment II", location: universe.venic_port, predicate:{ cargo.contains(items.usulPortalFragment2) == true }, result: {  }),
			Quest(name:"Combine fragments at Horadric", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[.discovery]?.append(m)
		
		m = Mission(id:(questlog[.discovery]?.count)!, name: "Trans Portal Key")
		m.predicate = { cargo.contains(items.transPortalKey) == true }
		m.quests = [
			Quest(name:"Aquire Loiqe Key", predicate:{ cargo.contains(items.loiqePortalKey) == true }, result: { }),
			Quest(name:"Aquire Valen Key", predicate:{ cargo.contains(items.valenPortalKey) == true }, result: { }),
			Quest(name:"Aquire Senni Key", predicate:{ cargo.contains(items.senniPortalKey) == true }, result: { }),
			Quest(name:"Aquire Usul Key", predicate:{ cargo.contains(items.usulPortalKey) == true }, result: { }),
			Quest(name:"Combine all keys at Horadric", location: universe.loiqe_horadric, predicate:{ m.predicate() }, result: { })
		]
		questlog[.discovery]?.append(m)
	}
	
	func refresh()
	{
		currentMission[active]?.validate()
		if currentMission[active]?.isCompleted == true {
			let nextMissionId = currentMission[active]!.id + 1
			currentMission[active] = questlog[active]![nextMissionId]
			mission.update()
		}
	}
	
	func setActive(chapter:Chapters)
	{
		active = chapter
	}
}




