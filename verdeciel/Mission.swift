
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
	
	init(id:Int,name:String)
	{
		self.id = id
		self.name = name
	}
	
	func validate()
	{
		if currentQuest == nil { currentQuest = quests.first }
		
		if predicate() != nil && predicate() == true { complete() }
		
		for quest in quests {
			quest.validate()
			if quest.isCompleted == false {
				currentQuest = quest
				if currentQuest.location != nil && capsule.dock != currentQuest.location && capsule.system != currentQuest.location.system { ui.addMessage("Reach the \(currentQuest.location.system) system", color:cyan) }
				else if currentQuest.location != nil && capsule.dock != currentQuest.location { ui.addMessage("Reach \(currentQuest.location.system) \(currentQuest.location.name!)", color:red) }
				else{ ui.addMessage(currentQuest.name) }
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