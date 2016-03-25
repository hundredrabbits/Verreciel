
//  Created by Devine Lu Linvega on 2016-01-14.
//  Copyright © 2016 XXIIVV. All rights reserved.

import Foundation

class Mission
{
	var id:Int = 0
	var name:String = "Unknown"
	var isCompleted:Bool = false
	
	var quests:Array<Quest> = []
	var currentQuest:Quest!
	
	var predicate:() -> Bool! = { return nil }
	var requirement:() -> Bool! = { return nil }
	var task:String = "[Missing]"
	
	init(id:Int,name:String, task:String = "", requirement:() -> Bool = { return true } )
	{
		self.id = id
		self.name = name
		self.task = task
		self.requirement = requirement
	}
	
	func validate()
	{
		if currentQuest == nil { currentQuest = quests.first }
		if predicate() != nil && predicate() == true { complete() }
		
		for quest in quests {
			quest.validate()
			if quest.isCompleted == false {
				currentQuest = quest
				mission.refresh()
				return
			}
		}
		isCompleted = true
	}
	
	func complete()
	{
		isCompleted = true
		for quest in quests {
			quest.complete()
		}
	}
}