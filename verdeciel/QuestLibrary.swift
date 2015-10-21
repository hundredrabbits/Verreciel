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
	
	var quest1:Quest!
	
	init()
	{
		_tutorial()
	}

	func _tutorial()
	{
		tutorial.append( Quest(type:missions.panel, predicate:{ battery.thrusterPort.origin != nil }) )
	}
	
	func _fixedUpdate()
	{
		for quest in tutorial {
			quest.validate()
		}
	}
}