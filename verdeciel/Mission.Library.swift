
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MissionLibrary
{
	var active:Chapters = Chapters.tutorial
	var questlog:Dictionary<Chapters,Array<Mission>> = [Chapters:Array]()
	var currentMission:Dictionary<Chapters,Mission> = [Chapters:Mission]()
	
	init()
	{
		questlog[Chapters.tutorial] = []
		questlog[Chapters.cyanine] = []
		questlog[Chapters.vermil] = []
		addTutorial()
		addCyanine()
		addVermil()
		
		currentMission[.tutorial] = questlog[.tutorial]?.first
		currentMission[.cyanine] = questlog[.tutorial]?.first
		currentMission[.vermil] = questlog[.tutorial]?.first
	}
	
	func addTutorial()
	{
		var m:Mission!
		
		m = Mission(id:0, name: "Flight Lesson")
		m.quests = [
			Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }),
			Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_spawn && universe.loiqe_spawn.isKnown == true }, result: { mission.install() }),
			Quest(name:"Wait for arrival", predicate:{ universe.loiqe_landing.isKnown == true }, result: { cargo.install() }),
			Quest(name:"Route materia to cargo", predicate:{ cargo.contains(items.materia) }, result: { console.install() }),
			Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }),
			Quest(name:"Undock from Landing", predicate:{ capsule.dock != universe.loiqe_landing && universe.loiqe_landing.isKnown == true }, result: { radar.install() }),
			Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown == true }, result: { })
		]
		questlog[.tutorial]?.append(m)
		
		m = Mission(id:1, name: "A Portal Key")
		m.quests = [
			Quest(name:"Trade materia for fragment", location: universe.loiqe_city, predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { pilot.install() }),
			Quest(name:"Route radar to pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: {  }),
			Quest(name:"Collect second fragment", location: universe.loiqe_satellite, predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: { }),
			Quest(name:"Combine fragments at Horadric", location: universe.loiqe_horadric,  predicate:{ (cargo.contains(items.valenPortalKey) == true) }, result: { })
		]
		questlog[.tutorial]?.append(m)
		
		m = Mission(id:2, name: "Portal Lesson")
		m.quests = [
			Quest(name:"Unlock portal", location: universe.loiqe_portal, predicate:{ universe.loiqe_portal.rightKeyPort.isReceiving(items.valenPortalKey) == true }, result: { universe.unlock(.valen) }),
			Quest(name:"Align to portal", location: universe.loiqe_portal, predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }),
			Quest(name:"Power Thruster", location: universe.loiqe_portal, predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: {  }),
		]
		questlog[.tutorial]?.append(m)
		
		m = Mission(id:2, name: "Reach Valen")
		m.quests = [
			Quest(name:"Warp to Valen system", location: universe.loiqe_portal, predicate:{ universe.valen_portal.isKnown == true }, result: { universe.unlock(.valen) }),
			Quest(name:"Reach the bank", location: universe.valen_bank, predicate:{ universe.valen_bank.isKnown == true }, result: {  }),
			Quest(name:"Collect the loiqe key", location: universe.valen_bank, predicate:{ cargo.contains(items.loiqePortalKey) }, result: { })
		]
		questlog[.tutorial]?.append(m)
		
		m = Mission(id:2, name: "Install Radio")
		m.quests = [
			Quest(name:"Reach Station", location: universe.valen_station, predicate:{ universe.valen_station.isKnown == true }, result: { }),
			Quest(name:"Reach Harvest", location: universe.valen_harvest, predicate:{ universe.valen_harvest.isKnown == true }, result: { }),
			Quest(name:"Collect credits", location: universe.valen_harvest, predicate:{ cargo.contains(items.credits) }, result: { }),
			Quest(name:"Install radio", location: universe.valen_station, predicate:{ radio.isInstalled == true }, result: { })
		]
		questlog[.tutorial]?.append(m)
		
		
		
		
		
		
		
		
		
		m = Mission(id:3, name: "Extinguish the sun")
		m.quests = [
			Quest(name:"Reach station", predicate:{ universe.valen_station.isKnown == true }, result: { }),
			Quest(name:"Find credits", predicate:{ cargo.contains(items.credits.name!,type: items.credits.type) == true }, result: { }),
			Quest(name:"Install shield", predicate:{ universe.valen_station.isComplete == true }, result: { }),
			Quest(name:"Route cell to shield", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { }),
			Quest(name:"Reach Valen star", predicate:{ universe.valen.isKnown == true }, result: { }),
			Quest(name:"Extinguish the sun", predicate:{ universe.valen.isComplete == true }, result: { journey.install() ; exploration.install() ; progress.install() ; complete.install() ; universe.unlock(.cyanine) })
		]
		questlog[.tutorial]?.append(m)
		
		/*
		
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
		
		questlog[.tutorial]?.append(["Lost record" :
			[
				Quest(name:"Reach satellite", predicate:{ universe.valen_satellite.isKnown == true }, result: { }),
				Quest(name:"Collect record", predicate:{ cargo.contains(items.record1) }, result: { radio.install() }),
				Quest(name:"Route record to radio", predicate:{ radio.port.isReceiving(items.record1) }, result: { }),
			]
		])
		
		
		
		questlog[.tutorial]?.append(["Return to Loiqe" :
			[
				Quest(name:"Visit the bank", predicate:{ universe.valen_bank.isKnown == true }, result: { }),
				Quest(name:"Collect Loiqe Key", predicate:{ cargo.contains(items.loiqePortalKey) }, result: { })
			]
		])
		
		
//				Quest(name:"Collect cell at bank", predicate:{ cargo.contains(items.cell2) }, result: { }),
//		Quest(name:"Route cell to battery", predicate:{ battery.hasCell(items.cell2) }, result: { })
		
		
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
	
	func addCyanine()
	{
		var m:Mission!
		
		m = Mission(id:0,name: "--")
		m.quests = [
			Quest(name:"Unlock at Senni", predicate:{ universe.senni.isKnown == true }, result: { })
		]
		questlog[.tutorial]?.append(m)
	}
	
	func addVermil()
	{
		var m:Mission!
		
		m = Mission(id:0,name: "--")
		m.quests = [
			Quest(name:"Unlock at Usul", predicate:{ universe.usul.isKnown == true }, result: { })
		]
		questlog[.tutorial]?.append(m)
	}
	
	func refresh()
	{
		currentMission[active]?.validate()
		if currentMission[active]?.isCompleted == true {
			let nextMissionId = currentMission[active]!.id + 1
			currentMission[active] = questlog[active]![nextMissionId]
			print("\(nextMissionId) -> \(currentMission[active]?.name)")
			mission.update()
		}
	}
	
	func setActive(chapter:Chapters)
	{
		active = chapter
	}
	
}




