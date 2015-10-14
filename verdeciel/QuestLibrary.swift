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
	var loiqe:Array<Quest> = []
	var falvet:Array<Quest> = []
	
	init()
	{
		_loiqe()
		_falvet()
	}
	
	func _loiqe()
	{
		loiqe.append(Quest(type:missions.visit, event: universe.loiqe_city))
		loiqe.append(Quest(type:missions.fetch, event: universe.loiqe_city))
		loiqe.append(Quest(type:missions.trade, event: universe.loiqe_city))
	}
	
	func _falvet()
	{
		falvet.append(Quest(type:missions.visit, event: universe.falvet_service2 ))
	}
}