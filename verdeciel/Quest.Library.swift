
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class QuestLibrary
{
	var tutorial:Array<Quest> = []
	var tutorialQuestId:Int = 0
	var falvet:Array<Quest> = []
	var falvetQuestId:Int = 0
	var senni:Array<Quest> = []
	var senniQuestId:Int = 0
	var usul:Array<Quest> = []
	var usulQuestId:Int = 0
	
	init()
	{
		_tutorial()
		_falvet()
		_senni()
		_usul()
		
		ui.addMessage(tutorial.first!.name)
		universe.unlock(.loiqe)
	}
	
	// MARK: Tutorial -
	
	func _tutorial()
	{
		// Start Loiqe
		tutorial.append( Quest(name:"Route cell to thruster", predicate:{ battery.isThrusterPowered() == true }, result: { thruster.install() }) )
		tutorial.append( Quest(name:"Undock with thruster", predicate:{ capsule.dock == nil }, result: { }) )
		tutorial.append( Quest(name:"Press arrow to accelerate", predicate:{ thruster.speed > 0 }, result: { mission.install() }) )
		tutorial.append( Quest(name:"Wait for arrival", predicate:{ universe.loiqe_landing.isKnown == true }, result: { cargo.install() }) )
		tutorial.append( Quest(name:"Route materia to cargo", predicate:{ cargo.contains(items.materia) }, result: { console.install() }) )
		tutorial.append( Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }) )
		tutorial.append( Quest(name:"Undock from Landing", predicate:{ capsule.dock == nil }, result: { radar.install() }) )
		tutorial.append( Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown }, result: {  }) )
		// Create Portal Key
		tutorial.append( Quest(name:"Trade materia for fragment", predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { }) )
		tutorial.append( Quest(name:"Select horadric", predicate:{ radar.port.event != nil && radar.port.event == universe.loiqe_horadric }, result: { pilot.install() }) )
		tutorial.append( Quest(name:"Route radar to pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: {  }) )
		tutorial.append( Quest(name:"Reach Horadric", predicate:{ universe.loiqe_horadric.isKnown }, result: {  }) )
		tutorial.append( Quest(name:"Reach the cargo", predicate:{ universe.loiqe_cargo.isKnown }, result: { progress.install() }) )
		tutorial.append( Quest(name:"Collect second fragment", predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: { exploration.install() }) )
		tutorial.append( Quest(name:"Combine fragments at Horadric", predicate:{ cargo.contains(items.valenPortalKey) }, result: { journey.install() }) )
		// Reach Valen
		tutorial.append( Quest(name:"Unlock portal", predicate:{ universe.loiqe_portal.rightKeyPort.isReceiving(items.valenPortalKey) == true }, result: {  }) )
		tutorial.append( Quest(name:"Align to portal", predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }) )
		tutorial.append( Quest(name:"Power Thruster", predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: {  }) )
		tutorial.append( Quest(name:"Warp to valen sector", predicate:{ capsule.isWarping == true }, result: { }) )
		tutorial.append( Quest(name:"Reach Valen", predicate:{ universe.valen_portal.isKnown == true }, result: { universe.unlock(.valen) }) )
		// Start Valen
		tutorial.append( Quest(name:"Visit the bank", predicate:{ universe.valen_bank.isKnown == true }, result: { }) )
		tutorial.append( Quest(name:"Collect Loiqe Key", predicate:{ cargo.contains(items.loiqePortalKey) }, result: { }) )
		tutorial.append( Quest(name:"Collect Waste", predicate:{ cargo.contains(items.waste) }, result: { hatch.install() }) )
		tutorial.append( Quest(name:"Route Waste to hatch", predicate:{ !cargo.contains(items.waste) }, result: { }) )
		tutorial.append( Quest(name:"Reach capsule", predicate:{ universe.valen_capsule.isKnown == true }, result: { }) )
//		tutorial.append( Quest(name:"Collect record I", predicate:{ cargo.contains(items.record1) }, result: { radio.install() }) )
//		tutorial.append( Quest(name:"Route record to radio", predicate:{ radio.port.isReceiving(items.record1) }, result: { }) )
//		tutorial.append( Quest(name:"Collect cell", predicate:{ cargo.contains(items.cell2) }, result: { }) )
//		tutorial.append( Quest(name:"Route cell to battery", predicate:{ battery.hasCell(items.cell2) }, result: { battery.installShield() }) )
		
		// Exit
		tutorial.append( Quest(name:"END QUEST", predicate:{ universe.usul_city.isKnown == true }, result: { }) )
	}
	
	func _falvet()
	{
		falvet.append( Quest(name:"Locked", predicate:{ capsule.dock != nil }, result: { }) )
		falvet.append( Quest(name:"Begin falvet", predicate:{ battery.thrusterPort.origin != nil }, result: { }) )
		
		falvet.append( Quest(name:"END QUEST", predicate:{ universe.usul_city.isKnown == true }, result: { }) )
	}
	
	func _senni()
	{
		senni.append( Quest(name:"Locked", predicate:{ capsule.dock != nil }, result: { }) )
		senni.append( Quest(name:"Begin falvet", predicate:{ battery.thrusterPort.origin != nil }, result: { }) )
		
		senni.append( Quest(name:"END QUEST", predicate:{ universe.usul_city.isKnown == true }, result: { }) )
	}
	
	func _usul()
	{
		usul.append( Quest(name:"Locked", predicate:{ capsule.dock != nil }, result: { }) )
		usul.append( Quest(name:"Begin falvet", predicate:{ battery.thrusterPort.origin != nil }, result: { }) )
		
		usul.append( Quest(name:"END QUEST", predicate:{ universe.usul_city.isKnown == true }, result: { }) )
	}
	
	func update()
	{
		let latestTutorial = tutorial[tutorialQuestId]
		latestTutorial.validate()
		
		if latestTutorial.isCompleted == true {
			tutorialQuestId += 1
			ui.addMessage(tutorial[tutorialQuestId].name)
		}
		if falvet[falvetQuestId].isCompleted == true {
			falvetQuestId += 1
		}
	}
	
	func skipTo(id:Int)
	{
		tutorialQuestId = 0
		while tutorialQuestId < id {
			tutorial[tutorialQuestId].complete()
			tutorialQuestId += 1
		}
		ui.addMessage(tutorial[tutorialQuestId].name)
		update()
	}
}