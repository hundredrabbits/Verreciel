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
		tutorial.append( Quest(name:"Connect thruster", predicate:{ battery.thrusterPort.origin != nil }, result: { thruster.install() }) )
		tutorial.append( Quest(name:"Reach the station", predicate:{ universe.loiqe_landing.isKnown == true }, result: { radar.install() }) )
		tutorial.append( Quest(name:"Undock from station", predicate:{ capsule.dock == nil }, result: { cargo.install() }) )
		tutorial.append( Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown }, result: { mission.install() }) )
		tutorial.append( Quest(name:"Upload to cargo", predicate:{ cargo.contains(items.loiqeLicense) }, result: { console.install() }) )
		tutorial.append( Quest(name:"Inspect cargo", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { hatch.install() }) )
		tutorial.append( Quest(name:"Connect cell to battery", predicate:{ cargo.contains(items.waste) == false }, result: { pilot.install() }) )
		tutorial.append( Quest(name:"Connect pilot", predicate:{ radar.port.connection == pilot.port }, result: { radiation.install() }) )
		tutorial.append( Quest(name:"Reach city", predicate:{ capsule.dock == universe.loiqe_telescope }, result: { monitor.install() }) )
		tutorial.append( Quest(name:"Load Radio pieces", predicate:{ cargo.contains(items.radioAntena) && cargo.contains(items.radioSpeaker) }, result: { }) )
		tutorial.append( Quest(name:"Visit combinator", predicate:{ capsule.dock == universe.loiqe_telescope }, result: { }) )
		tutorial.append( Quest(name:"Upload radio", predicate:{ cargo.contains(items.radio) }, result: { radio.install() }) )
		tutorial.append( Quest(name:"Reach falvet", predicate:{ capsule.dock == universe.falvet_toLoiqe }, result: { translator.install() }) )
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