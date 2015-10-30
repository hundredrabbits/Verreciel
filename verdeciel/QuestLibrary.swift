//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class QuestLibrary
{
	var tutorial:Array<Quest> = []
	var tutorialQuestId:Int = 0
	var falvet:Array<Quest> = []
	var falvetQuestId:Int = 0
	
	init()
	{
		_tutorial()
		_falvet()
		
		ui.addMessage(tutorial.first!.name)
	}

	func _tutorial()
	{
		// Capsule
		
		/*  1 */ tutorial.append( Quest(name:"Route cell to thruster", predicate:{ battery.isThrusterPowered() == true }, result: { thruster.install() }) )
		/*  2 */ tutorial.append( Quest(name:"Press undock", predicate:{ capsule.dock == nil }, result: { }) )
		/*  3 */ tutorial.append( Quest(name:"Press arrow to accelerate", predicate:{ thruster.speed > 0 }, result: { }) )
		/*  4 */ tutorial.append( Quest(name:"Please wait", predicate:{ universe.loiqe_landing.isKnown == true }, result: { radar.install() }) )
		/*  5 */ tutorial.append( Quest(name:"Undock from \(universe.loiqe_landing.name)", predicate:{ capsule.dock == nil }, result: { }) )
		/*  6 */ tutorial.append( Quest(name:"Dock at  \(universe.loiqe_city.name)", predicate:{ universe.loiqe_city.isKnown }, result: { cargo.install() ; mission.install() }) )
		/*  7 */ tutorial.append( Quest(name:"Route license to cargo", predicate:{ cargo.contains(items.loiqeLicense) }, result: { console.install() }) )
		/*  8 */ tutorial.append( Quest(name:"Route Cargo to Console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }) )
		/*  9 */ tutorial.append( Quest(name:"Route cell to battery", predicate:{ battery.cellPort2.isEnabled == true }, result: { pilot.install() }) )
		/* 10 */ tutorial.append( Quest(name:"Route radar to pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: { }) )
		/* 11 */ tutorial.append( Quest(name:"Reach horadric", predicate:{ universe.loiqe_horadric.isKnown }, result: { journey.install() }) )
		
		// Radio
		
		/*  9 */ tutorial.append( Quest(name:"Reach the loiqe waypoint", predicate:{ universe.loiqe_waypoint.isKnown }, result: { exploration.install() }) )
		/* 10 */ tutorial.append( Quest(name:"Trade license for antena", predicate:{ cargo.contains(items.radioPart1) }, result: { }) )
		/* 11 */ tutorial.append( Quest(name:"Reach cargo", predicate:{ universe.loiqe_cargo.isKnown == true }, result: { }) )
		/* 12 */ tutorial.append( Quest(name:"Route speaker to cargo", predicate:{ cargo.contains(items.radioPart1) && cargo.contains(items.radioPart2) }, result: { progress.install() }) )
		/* 13 */ tutorial.append( Quest(name:"Combine radio at horadric", predicate:{ capsule.dock == universe.loiqe_horadric }, result: { radio.display() }) )
		/* 14 */ tutorial.append( Quest(name:"Route radio below battery", predicate:{ radio.isInstalled == true }, result: { }) )
		/* 15 */ tutorial.append( Quest(name:"Route cell into radio", predicate:{ battery.isRadioPowered() == true }, result: { }) )
		/* 16 */ tutorial.append( Quest(name:"Go to the waypoint", predicate:{ capsule.dock != nil && capsule.dock == universe.loiqe_waypoint }, result: { }) )
		/* 17 */ tutorial.append( Quest(name:"Route radio into radar", predicate:{ radio.port.connection != nil && radio.port.connection == radar.port }, result: { }) )
		/* 18 */ tutorial.append( Quest(name:"Reach the connection", predicate:{ universe.falvet_toUsul.isKnown == true }, result: { }) )
		
		/* 13 */ tutorial.append( Quest(name:"Approach falvet", predicate:{ universe.falvet_toUsul.isKnown == true }, result: { }) )
	}
	
	func _falvet()
	{
		falvet.append( Quest(name:"--", predicate:{ capsule.dock != nil }, result: { }) )
		falvet.append( Quest(name:"Begin falvet", predicate:{ battery.thrusterPort.origin != nil }, result: { }) )
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
}