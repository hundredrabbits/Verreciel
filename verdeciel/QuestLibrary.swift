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

	func _tutorial()
	{
		tutorial.append( Quest(name:"Connect thruster", predicate:{ battery.thrusterPort.origin != nil }, result: { player.enterRadar() }))
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