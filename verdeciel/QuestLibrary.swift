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
	
	// MARK: Tutorial -
	
	func _tutorial()
	{
		_tutorialPart1()

		tutorial.append( Quest(name:"Reach falvet system", predicate:{ universe.falvet_toLoiqe.isKnown == true }, result: { }) )
		tutorial.append( Quest(name:"Approach falvet", predicate:{ universe.falvet_toUsul.isKnown == true }, result: { }) )
	}
	
	func _tutorialPart1()
	{
		tutorial.append( Quest(name:"Route cell to thruster", predicate:{ battery.isThrusterPowered() == true }, result: { thruster.install() }) )
		tutorial.append( Quest(name:"Press undock on thruster", predicate:{ capsule.dock == nil }, result: { }) )
		tutorial.append( Quest(name:"Press arrow to accelerate", predicate:{ thruster.speed > 0 }, result: { mission.install() }) )
		tutorial.append( Quest(name:"Wait for arrival", predicate:{ universe.loiqe_landing.isKnown == true }, result: { cargo.install() }) )
		tutorial.append( Quest(name:"Route materia to cargo", predicate:{ cargo.contains(items.materia) }, result: { console.install() }) )
		tutorial.append( Quest(name:"Route cargo to console", predicate:{ cargo.port.connection != nil && cargo.port.connection == console.port }, result: { }) )
		tutorial.append( Quest(name:"Undock from Landing", predicate:{ capsule.dock == nil }, result: { radar.install() }) )
		tutorial.append( Quest(name:"Dock at city", predicate:{ universe.loiqe_city.isKnown }, result: {  }) )
		tutorial.append( Quest(name:"Trade materia for fragment", predicate:{ cargo.contains(items.valenPortalFragment1) == true }, result: { }) )
		tutorial.append( Quest(name:"Press horadric on radar", predicate:{ radar.port.event != nil && radar.port.event == universe.loiqe_horadric }, result: { pilot.install() }) )
		tutorial.append( Quest(name:"Route radar to pilot", predicate:{ radar.port.connection != nil && radar.port.connection == pilot.port }, result: {  }) )
		tutorial.append( Quest(name:"Reach Horadric", predicate:{ universe.loiqe_horadric.isKnown }, result: {  }) )
		tutorial.append( Quest(name:"Reach the cargo", predicate:{ universe.loiqe_cargo.isKnown }, result: {  }) )
		tutorial.append( Quest(name:"Collect second fragment", predicate:{ cargo.contains(items.valenPortalFragment2) == true }, result: { exploration.install() }) )
		tutorial.append( Quest(name:"Combine fragments at Horadric", predicate:{ cargo.contains(items.valenPortalKey) }, result: { journey.install() }) )
		tutorial.append( Quest(name:"Unlock loiqe gate", predicate:{ universe.loiqe_portal.isComplete == true }, result: { progress.install() }) )
	}
	
	// MARK: Tutorial -
	
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