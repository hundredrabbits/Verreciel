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
	var loiqe:Array<Quest> = []
	
	init()
	{
		_tutorial()
		_loiqe()
	}
	
	func _tutorial()
	{
		tutorial.append(Quest(type:missions.panel, target: battery.thrusterPort.origin, requirement:requirements.isNotNil ))
	}
	
	func _loiqe()
	{
		loiqe.append(Quest(type:missions.visit, target: universe.falvet_service2.isKnown, requirement:requirements.isTrue ))
	}
	
	func _fixedUpdate()
	{
		tutorial = []
		tutorial.append(Quest(type:missions.panel, target: battery.thrusterPort.origin, requirement:requirements.isNotNil ))
		
		for currentQuest in tutorial {
			currentQuest.validate()
		}
	}
}