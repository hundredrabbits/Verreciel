
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
				intercom.refresh()
				
				if currentQuest.location != nil {
					if capsule.isDockedAtLocation(currentQuest.location) { helmet.addMessage(currentQuest.name) }
					else if capsule.system == currentQuest.location.system { helmet.addMessage(currentQuest.location.name!, color:red) }
					else{ helmet.addMessage("\(currentQuest.location.system)", color:cyan) }
				}
				else{
					helmet.addMessage(currentQuest.name)
				}
			}
		}
		isCompleted = true
		onComplete()
	}
	
	func onComplete()
	{
		helmet.addWarning(name, color:cyan, duration:3, flag:"mission")
		completion.refresh()
	}
	
	func complete()
	{
		isCompleted = true
		for quest in quests {
			quest.complete()
		}
	}
}