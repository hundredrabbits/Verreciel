
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class QuestLibrary
{
	var tutorial:Array<Quest> = []
	var tutorialProgress:Int = 0
	var falvet:Array<Quest> = []
	var falvetProgress:Int = 0
	var senni:Array<Quest> = []
	var senniProgress:Int = 0
	var usul:Array<Quest> = []
	var usulProgress:Int = 0
	
	var updateTimer:NSTimer!
	
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
		tutorial.append( Quest(name:"Route cell to thruster", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { thruster.install() }) )
		tutorial.append( Quest(name:"Undock with thruster", predicate:{ capsule.dock == nil }, result: { mission.install() }) )
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
		tutorial.append( Quest(name:"Reach satellite", predicate:{ universe.loiqe_satellite.isKnown }, result: { }) )
		tutorial.append( Quest(name:"Collect second fragment", predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: { }) )
		tutorial.append( Quest(name:"Combine fragments at Horadric", predicate:{ cargo.contains(items.valenPortalKey) }, result: { }) )
		// Reach Valen
		tutorial.append( Quest(name:"Unlock portal", predicate:{ universe.loiqe_portal.rightKeyPort.isReceiving(items.valenPortalKey) == true }, result: {  }) )
		tutorial.append( Quest(name:"Align to portal", predicate:{ pilot.port.isReceiving(universe.valen_portal) == true }, result: {  }) )
		tutorial.append( Quest(name:"Power Thruster", predicate:{ thruster.port.isReceiving(items.warpDrive) == true }, result: {  }) )
		tutorial.append( Quest(name:"Warp to valen sector", predicate:{ capsule.isWarping == true }, result: { }) )
		tutorial.append( Quest(name:"Reach Valen system", predicate:{ universe.valen_portal.isKnown == true }, result: { universe.unlock(.valen) }) )
		// Start Valen(18)
		tutorial.append( Quest(name:"Visit the bank", predicate:{ universe.valen_bank.isKnown == true }, result: { }) )
		tutorial.append( Quest(name:"Collect Loiqe Key", predicate:{ cargo.contains(items.loiqePortalKey) }, result: { }) )
		tutorial.append( Quest(name:"Collect Waste", predicate:{ cargo.contains(items.waste) }, result: { hatch.install() }) )
		tutorial.append( Quest(name:"Route Waste to hatch", predicate:{ hatch.port.isReceiving(items.waste) }, result: { }) )
		tutorial.append( Quest(name:"Jetison Waste", predicate:{ cargo.contains(items.waste) == false }, result: { }) )
		tutorial.append( Quest(name:"Reach satellite", predicate:{ universe.valen_satellite.isKnown == true }, result: { }) )
		tutorial.append( Quest(name:"Collect record", predicate:{ cargo.contains(items.record1) }, result: { radio.install() }) )
		tutorial.append( Quest(name:"Route record to radio", predicate:{ radio.port.isReceiving(items.record1) }, result: { }) )
		tutorial.append( Quest(name:"Collect cell at bank", predicate:{ cargo.contains(items.cell2) }, result: { }) )
		tutorial.append( Quest(name:"Route cell to battery", predicate:{ battery.hasCell(items.cell2) }, result: { }) )
		// Valen Shut Off The Sun
		tutorial.append( Quest(name:"Reach station", predicate:{ universe.valen_station.isKnown == true }, result: { }) )
		tutorial.append( Quest(name:"Find credits", predicate:{ cargo.contains(items.credits.name!,type: items.credits.type) == true }, result: { }) )
		tutorial.append( Quest(name:"Install shield", predicate:{ universe.valen_station.isComplete == true }, result: { }) )
		tutorial.append( Quest(name:"Route cell to shield", predicate:{ battery.thrusterPort.isReceivingItemOfType(.battery) == true }, result: { }) )
		tutorial.append( Quest(name:"Reach Valen star", predicate:{ universe.valen.isKnown == true }, result: { }) )
		tutorial.append( Quest(name:"Extinguish the sun", predicate:{ universe.valen.isComplete == true }, result: { journey.install() ; exploration.install() ; progress.install() ; complete.install() }) )
		
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
	
	func refresh()
	{
		let latestTutorial = tutorial[tutorialProgress]
		latestTutorial.validate()
		
		if latestTutorial.isCompleted == true {
			tutorialProgress += 1
			ui.addMessage(tutorial[tutorialProgress].name)
		}
	}
	
	func skipTo(id:Int)
	{
		tutorialProgress = 0
		while tutorialProgress < id {
			tutorial[tutorialProgress].complete()
			tutorialProgress += 1
		}
		print(tutorialProgress)
		ui.addMessage(tutorial[tutorialProgress].name)
		refresh()
	}
}