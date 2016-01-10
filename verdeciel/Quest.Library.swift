
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class QuestLibrary
{
	var active:Chapters = Chapters.tutorial
	var questlog:Dictionary<Chapters,Array<Dictionary<String,Array<Quest>>>> = [Chapters:Array]()
	var latest:Dictionary<Chapters,Array<Int>> = [Chapters:Array]()
	
	init()
	{
		latest[.tutorial] = [0,0]
		latest[.cyanine] = [0,0]
		latest[.vermil] = [0,0]
		
		questlog[Chapters.tutorial] = []
		questlog[Chapters.cyanine] = []
		questlog[Chapters.vermil] = []
		addTutorial()
		addCyanine()
		addVermil()
	}
	
	func addTutorial()
	{
		questlog[.tutorial]?.append(["Flight" :
			[
				Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }),
				Quest(name:"Undock with thruster", predicate:{ capsule.dock != universe.loiqe_spawn && universe.loiqe_spawn.isKnown == true }, result: { mission.install() }),
				Quest(name:"Wait for arrival", predicate:{ universe.loiqe_landing.isKnown == true }, result: { cargo.install() }),
				Quest(name:"Route materia to cargo", predicate:{ cargo.contains(items.materia) }, result: { console.install() }),
				Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }),
				Quest(name:"Undock from Landing", predicate:{ capsule.dock != universe.loiqe_landing && universe.loiqe_landing.isKnown == true }, result: { radar.install() }),
				Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown == true }, result: { })
			]
		])
		questlog[.tutorial]?.append(["A Portal Key" :
			[
				Quest(name:"Trade materia for fragment", predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { }),
				Quest(name:"Select horadric", predicate:{ radar.port.event != nil && radar.port.event == universe.loiqe_horadric }, result: { pilot.install() }),
				Quest(name:"Route radar to pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: {  }),
				Quest(name:"Reach Horadric", predicate:{ universe.loiqe_horadric.isKnown }, result: {  }),
				Quest(name:"Reach satellite", predicate:{ universe.loiqe_satellite.isKnown }, result: { }),
				Quest(name:"Collect second fragment", predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: { }),
				Quest(name:"Combine fragments at Horadric", predicate:{ cargo.contains(items.valenPortalKey) }, result: { })
			]
		])
		questlog[.tutorial]?.append(["Reach Valen" :
			[
				Quest(name:"Unlock portal", predicate:{ universe.loiqe_portal.rightKeyPort.isReceiving(items.valenPortalKey) == true }, result: {  }),
				Quest(name:"Align to portal", predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }),
				Quest(name:"Power Thruster", predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: {  }),
				Quest(name:"Warp to valen sector", predicate:{ capsule.isWarping == true }, result: { }),
				Quest(name:"Reach Valen system", predicate:{ universe.valen_portal.isKnown == true }, result: { universe.unlock(.valen) })
			]
		])
		questlog[.tutorial]?.append(["Valen" :
			[
				Quest(name:"Visit the bank", predicate:{ universe.valen_bank.isKnown == true }, result: { }),
				Quest(name:"Collect Loiqe Key", predicate:{ cargo.contains(items.loiqePortalKey) }, result: { }),
				Quest(name:"Collect Waste", predicate:{ cargo.contains(items.waste) }, result: { hatch.install() }),
				Quest(name:"Route Waste to hatch", predicate:{ hatch.port.isReceiving(items.waste) }, result: { }),
				Quest(name:"Jetison Waste", predicate:{ cargo.contains(items.waste) == false }, result: { }),
				Quest(name:"Reach satellite", predicate:{ universe.valen_satellite.isKnown == true }, result: { }),
				Quest(name:"Collect record", predicate:{ cargo.contains(items.record1) }, result: { radio.install() }),
				Quest(name:"Route record to radio", predicate:{ radio.port.isReceiving(items.record1) }, result: { }),
				Quest(name:"Collect cell at bank", predicate:{ cargo.contains(items.cell2) }, result: { }),
				Quest(name:"Route cell to battery", predicate:{ battery.hasCell(items.cell2) }, result: { })
			]
		])
		questlog[.tutorial]?.append(["Extinguish the sun" :
			[
				Quest(name:"Reach station", predicate:{ universe.valen_station.isKnown == true }, result: { }),
				Quest(name:"Find credits", predicate:{ cargo.contains(items.credits.name!,type: items.credits.type) == true }, result: { }),
				Quest(name:"Install shield", predicate:{ universe.valen_station.isComplete == true }, result: { }),
				Quest(name:"Route cell to shield", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { }),
				Quest(name:"Reach Valen star", predicate:{ universe.valen.isKnown == true }, result: { }),
				Quest(name:"Extinguish the sun", predicate:{ universe.valen.isComplete == true }, result: { journey.install() ; exploration.install() ; progress.install() ; complete.install() ; universe.unlock(.cyanine) })
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
	}
	
	func addCyanine()
	{
		questlog[.cyanine]?.append(["--" :
			[
				Quest(name:"Unlock at Venic", predicate:{ universe.cyanine_venic.isKnown == true }, result: { universe.unlock(.venic) })
			]
		])
	}
	
	func addVermil()
	{
		questlog[.vermil]?.append(["--" :
			[
				Quest(name:"Unlock at Usul", predicate:{ universe.cyanine_venic.isKnown == true }, result: { universe.unlock(.venic) })
			]
		])
	}
	
	func refresh()
	{
		validateChapter(active)
	}
	
	func validateChapter(chapter:Chapters)
	{
		var missionId = 0
		for mission in questlog[chapter]! {
			if missionId < latest[chapter]![0] { missionId += 1 ; continue}
			let questId = validateMission(mission)
			if questId == nil { missionId += 1 ; continue }
			
			if latest[chapter]![0] != missionId { latest[chapter]![0] = missionId ; missionUpdate() }
			if latest[chapter]![1] != questId { latest[chapter]![1] = questId ; questUpdate() }

			break
		}
	}
	
	func validateMission(mission:Dictionary<String, Array<Quest>>) -> Int!
	{
		var questId = 0
		for quest in mission.values.first! {
			quest.validate()
			if quest.isCompleted == false { return questId }
			questId += 1
		}
		return nil
	}
	
	func missionUpdate()
	{
		print("Mission Update")
		mission.refresh()
	}
	
	func questUpdate()
	{
		print("Quest Update")
		ui.addMessage(questWithId(active, missionId: latest[active]![0], questId: latest[active]![1]))
		mission.refresh()
	}
	
	func missionWithId(chapter:Chapters,missionId:Int) -> String
	{
		return questlog[chapter]![missionId].keys.first!
	}
	
	func questWithId(chapter:Chapters,missionId:Int,questId:Int) -> String
	{
		let mission = questlog[chapter]![missionId]
		return mission.values.first![questId].name
	}
	
	func questsWithId(chapter:Chapters,missionId:Int) -> Array<Quest>
	{
		return questlog[.tutorial]![missionId].values.first!
	}
	
	func setActive(chapter:Chapters)
	{
		active = chapter
	}
	
	func questCount(chapter:Chapters) -> Int
	{
		return 0
	}
}




