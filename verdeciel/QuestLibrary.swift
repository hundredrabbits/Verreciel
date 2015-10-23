//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class QuestLibrary
{
	var tutorial:Array<Quest> = []
	var tutorialLatest:Quest!
	var tutorialProgress:Int = 0
	
	var falvet:Array<Quest> = []
	var falvetLatest:Quest!
	var falvetProgress:Int = 0
	
	init()
	{
		_tutorial()
		_falvet()
	}

	func _tutorial()
	{
		/*  1 */ tutorial.append( Quest(name:"Connect thruster", predicate:{ battery.thrusterPort.origin != nil }, result: { thruster.install() }) )
		/*  2 */ tutorial.append( Quest(name:"Reach the station", predicate:{ universe.loiqe_landing.isKnown == true }, result: { radar.install() }) )
		/*  3 */ tutorial.append( Quest(name:"Undock from station", predicate:{ capsule.dock == nil }, result: { cargo.install() }) )
		/*  3 */ tutorial.append( Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown }, result: { mission.install() }) )
		/*  4 */ tutorial.append( Quest(name:"Upload to cargo", predicate:{ cargo.contains(items.loiqeLicense) }, result: { console.install() }) )
		/*  5 */ tutorial.append( Quest(name:"Inspect cargo", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }) )
		/*  6 */ tutorial.append( Quest(name:"Connect cell to battery", predicate:{ battery.cell2.isEnabled == true }, result: { pilot.install() }) )
		/*  7 */ tutorial.append( Quest(name:"Connect pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: { }) )
		/*  8 */ tutorial.append( Quest(name:"Reach telescope", predicate:{ universe.loiqe_telescope.isKnown }, result: { monitor.install() }) )
		/*  9 */ tutorial.append( Quest(name:"Reach falvet", predicate:{ capsule.dock == universe.falvet_toLoiqe }, result: { translator.install() }) )
		
		
		/*  9 */ tutorial.append( Quest(name:"Load Radio pieces", predicate:{ cargo.contains(items.radioAntena) && cargo.contains(items.radioSpeaker) }, result: { }) )
		/* 10 */ tutorial.append( Quest(name:"Visit combinator", predicate:{ capsule.dock == universe.loiqe_telescope }, result: { }) )
		/* 11 */ tutorial.append( Quest(name:"Upload radio", predicate:{ cargo.contains(items.radio) }, result: { radio.install() }) )
		
	}
	
	func _falvet()
	{
		falvet.append( Quest(name:"--", predicate:{ capsule.dock != nil }, result: { }) )
		falvet.append( Quest(name:"Begin falvet", predicate:{ battery.thrusterPort.origin != nil }, result: { }) )
	}
	
	func update()
	{
		tutorialProgress = 0
		for quest in tutorial {
			tutorialProgress += 1
			if quest.isCompleted == true { continue }
			tutorialLatest = quest
			quest.validate()
			break
		}
		
		for quest in falvet {
			if quest.isCompleted == true { continue }
			falvetLatest = quest
			quest.validate()
			break
		}
	}
}