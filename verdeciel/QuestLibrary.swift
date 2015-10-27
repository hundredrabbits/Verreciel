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
		
		/*  1 */ tutorial.append( Quest(name:"Connect cell to thruster", predicate:{ battery.thrusterPort.origin != nil }, result: { thruster.install() }) )
		/*  2 */ tutorial.append( Quest(name:"Reach the station", predicate:{ universe.loiqe_landing.isKnown == true }, result: { radar.install() }) )
		/*  3 */ tutorial.append( Quest(name:"Undock from station", predicate:{ capsule.dock == nil }, result: { cargo.install() }) )
		/*  3 */ tutorial.append( Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown }, result: { mission.install() }) )
		/*  4 */ tutorial.append( Quest(name:"Upload license to cargo", predicate:{ cargo.contains(items.loiqeLicense) }, result: { console.install() }) )
		/*  5 */ tutorial.append( Quest(name:"Route Cargo to Console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }) )
		/*  6 */ tutorial.append( Quest(name:"Route cell to battery", predicate:{ battery.cell2.isEnabled == true }, result: { pilot.install() }) )
		/*  7 */ tutorial.append( Quest(name:"Route radar to pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: { }) )
		/*  8 */ tutorial.append( Quest(name:"Reach telescope", predicate:{ universe.loiqe_telescope.isKnown }, result: { journey.install() }) )
		
		// Radio
		
		/*  1 */ tutorial.append( Quest(name:"Reach falvet from loiqe", predicate:{ universe.falvet_toLoiqe.isKnown }, result: { exploration.install() }) )
		/*  2 */ tutorial.append( Quest(name:"Trade license for antena", predicate:{ cargo.contains(items.radioAntena) }, result: { }) )
		/*  3 */ tutorial.append( Quest(name:"Grab speaker from cargo", predicate:{ cargo.contains(items.radioSpeaker) }, result: { }) )
		/*  4 */ tutorial.append( Quest(name:"Reach Horadric", predicate:{ cargo.contains(items.radioAntena) && cargo.contains(items.radioSpeaker) }, result: { progress.install() }) )
		/*  5 */ tutorial.append( Quest(name:"Combine antena and speaker", predicate:{ cargo.contains(items.radio) }, result: { radio.install() }) )
		
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
			ui.addMessage(falvet[falvetQuestId].name)
		}
		
	}
}