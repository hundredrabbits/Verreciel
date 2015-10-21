//
//  ItemLibrary.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import Foundation

class QuestLibrary
{
	var tutorial:Array<Quest> = []
	var tutorialQuest:Quest!
	
	init()
	{
		_tutorial()
	}
	
	func someTest() -> Void
	{
	
	}

	func _tutorial()
	{
		let someTest = { player.enterRadar() }
		
		tutorial.append( Quest(type:missions.panel, predicate:{ battery.thrusterPort.origin != nil }, name:"Connect thruster", result:someTest) )
	}
	
	func _fixedUpdate()
	{
		for quest in tutorial {
			if quest.isCompleted == true { continue }
			tutorialQuest = quest
			quest.validate()
			break
		}
	}
}