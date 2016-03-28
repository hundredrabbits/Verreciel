//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelMission : MainPanel
{
	var locationPanel:SCNNode!

	var questPanel:SCNNode!
	
	var quest1:SCNTrigger!
	var quest1Label = SCNLabel(text: "--", align:.left)
	var quest1Details = SCNLabel(text: "locked", scale:0.07, align:.left)
	var quest1Progress = SCNProgressBar(width: CGFloat(templates.leftMargin * Float(2.0)))
	var quest1Completion = SCNLabel(text: "", scale:0.07, align:.right, color: grey)
	
	var quest2:SCNTrigger!
	var quest2Label = SCNLabel(text: "--", align:.left)
	var quest2Details = SCNLabel(text: "locked", scale:0.07, align:.left)
	var quest2Progress = SCNProgressBar(width: CGFloat(templates.leftMargin * Float(2.0)))
	var quest2Completion = SCNLabel(text: "", scale:0.07, align:.right, color: grey)
	
	var quest3:SCNTrigger!
	var quest3Label = SCNLabel(text: "--", align:.left)
	var quest3Details = SCNLabel(text: "locked", scale:0.07, align:.left)
	var quest3Progress = SCNProgressBar(width: CGFloat(templates.leftMargin * Float(2.0)))
	var quest3Completion = SCNLabel(text: "", scale:0.07, align:.right, color: grey)
	
	var selector = SCNLabel(text: ">", align:.left)
	
	// MARK: Default -
	
	override init()
	{
		super.init()
		
		name = "mission"
		info = "[missing text]"
	
		locationPanel = Panel()
		mainNode.addChildNode(locationPanel)
	
		questPanel = SCNNode()
		questPanel.position = SCNVector3(0,0,0)
		
		// Quest1
		quest1 = SCNTrigger(host: self, size: CGSize(width: 3.1, height: 0.8), operation:1)
		quest1.position = SCNVector3(x: 0, y: 0.8, z: 0)
		questPanel.addChildNode(quest1)
		
		quest1Progress.position = SCNVector3(x: templates.leftMargin, y: -0.4, z: 0)
		quest1Progress.eulerAngles.y = Float( degToRad(180))
		quest1.addChildNode(quest1Progress)
		
		quest1Label.position = SCNVector3(x: templates.leftMargin, y: 0.15, z: 0)
		quest1.addChildNode(quest1Label)
		quest1Details.position = SCNVector3(x: templates.leftMargin, y: -0.15, z: 0)
		quest1.addChildNode(quest1Details)
		quest1Completion.position = SCNVector3(x: templates.rightMargin, y: -0.15, z: 0)
		quest1.addChildNode(quest1Completion)
		
		quest2 = SCNTrigger(host: self, size: CGSize(width: 3.1, height: 0.8), operation:2)
		quest2.position = SCNVector3(x: 0, y: 0, z: 0)
		questPanel.addChildNode(quest2)
		
		quest2Progress.position = SCNVector3(x: templates.leftMargin, y: -0.4, z: 0)
		quest2Progress.eulerAngles.y = Float( degToRad(180))
		quest2.addChildNode(quest2Progress)
		
		quest2Label.position = SCNVector3(x: templates.leftMargin, y: 0.15, z: 0)
		quest2.addChildNode(quest2Label)
		quest2Details.position = SCNVector3(x: templates.leftMargin, y: -0.15, z: 0)
		quest2.addChildNode(quest2Details)
		quest2Completion.position = SCNVector3(x: templates.rightMargin, y: -0.15, z: 0)
		quest2.addChildNode(quest2Completion)
		
		quest3 = SCNTrigger(host: self, size: CGSize(width: 3.1, height: 0.8), operation:3)
		quest3.position = SCNVector3(x: 0, y: -0.8, z: 0)
		questPanel.addChildNode(quest3)
		
		quest3Progress.position = SCNVector3(x: templates.leftMargin, y: -0.4, z: 0)
		quest3Progress.eulerAngles.y = Float( degToRad(180))
		quest3.addChildNode(quest3Progress)
		
		quest3Label.position = SCNVector3(x: templates.leftMargin, y: 0.15, z: 0)
		quest3.addChildNode(quest3Label)
		quest3Details.position = SCNVector3(x: templates.leftMargin, y: -0.15, z: 0)
		quest3.addChildNode(quest3Details)
		quest3Completion.position = SCNVector3(x: templates.rightMargin, y: -0.15, z: 0)
		quest3.addChildNode(quest3Completion)
		
		selector.position = SCNVector3(x: -templates.rightMargin - 0.25, y: 0, z: 0)
		questPanel.addChildNode(selector)
		
		mainNode.addChildNode(questPanel)
		
		port.input = Item.self
		port.output = Event.self
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(0,0,1),host:self))
		
		locationPanel.opacity = 0
	}
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		if capsule.isDocked && capsule.dock.isComplete != nil && capsule.dock.isComplete == false {
			locationPanel.update()
		}
	}
	
	override func touch(id: Int)
	{
		quest1Label.update(grey)
		quest2Label.update(grey)
		quest3Label.update(grey)
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.2)
		
		if id == 1 { selector.position = SCNVector3(selector.position.x,quest1.position.y,0) }
		if id == 2 { selector.position = SCNVector3(selector.position.x,quest2.position.y,0) }
		if id == 3 { selector.position = SCNVector3(selector.position.x,quest3.position.y,0) }
		
		SCNTransaction.setCompletionBlock({
			if id == 1 { quests.setActive(Chapters.primary) ; self.quest1Label.update(white) }
			if id == 2 { quests.setActive(Chapters.secondary) ; self.quest2Label.update(white) }
			if id == 3 { quests.setActive(Chapters.tertiary) ; self.quest3Label.update(white) }
		})
		SCNTransaction.commit()
		
		refresh()
	}
	
	override func refresh()
	{
		if( isInstalled == true ){
			if capsule.dock == nil { label.update("mission",color:white) }
			else if capsule.dock.isComplete == nil { label.update(capsule.dock.name!,color:white) }
			else if capsule.dock.isComplete == true { label.update(capsule.dock.name!,color:cyan) }
			else{ label.update(capsule.dock.name!,color:red) }
		}
		
		var currentMission:Mission!
		var questCount:Int!
		
		currentMission = quests.currentMission[.primary]!
		questCount = quests.questlog[.primary]!.count
		if currentMission.requirement() != nil && currentMission.requirement() == false {
			quest1Label.update("Locked", color:grey)
			quest1Details.update(currentMission.task, color:grey)
			quest1Completion.update("")
			quest1Progress.update(0)
		}
		else if currentMission.currentQuest != nil {
			quest1Label.update(quests.currentMission[.primary]!.name, color:white)
			quest1Details.update(quests.currentMission[.primary]!.currentQuest!.name, color:grey)
			quest1Completion.update("\(currentMission.id)/\(questCount)")
			quest1Progress.update( (CGFloat(currentMission.id)/CGFloat(questCount)) * 100 )
		}
		
		currentMission = quests.currentMission[.secondary]!
		questCount = quests.questlog[.secondary]!.count
		if currentMission.requirement() != nil && currentMission.requirement() == false {
			quest2Label.update("--", color:grey)
			quest2Details.update(currentMission.task, color:grey)
			quest2Completion.update("")
			quest2Progress.update(0)
		}
		else if currentMission.currentQuest != nil {
			quest2Label.update(quests.currentMission[.secondary]!.name, color:white)
			quest2Details.update(quests.currentMission[.secondary]!.currentQuest!.name, color:grey)
			quest2Completion.update("\(currentMission.id)/\(questCount)")
			quest2Progress.update( (CGFloat(currentMission.id)/CGFloat(questCount)) * 100 )
		}
		
		currentMission = quests.currentMission[.tertiary]!
		questCount = quests.questlog[.tertiary]!.count
		if currentMission.requirement() != nil && currentMission.requirement() == false {
			quest3Label.update("--", color:grey)
			quest3Details.update(currentMission.task, color:grey)
			quest3Completion.update("")
			quest3Progress.update(0)
		}
		else if currentMission.currentQuest != nil {
			quest3Label.update(quests.currentMission[.tertiary]!.name, color:white)
			quest3Details.update(quests.currentMission[.tertiary]!.currentQuest!.name, color:grey)
			quest3Completion.update("\(currentMission.id)/\(questCount)")
			quest3Progress.update( (CGFloat(currentMission.id)/CGFloat(questCount)) * 100 )
		}
		
		prompt()
	}
	
	func prompt()
	{
		let activeMission = quests.currentMission[quests.active]!
		let activeQuest = activeMission.currentQuest
		
		if activeQuest == nil { return }
		if activeMission.requirement() != nil && activeMission.requirement() == false { return }
		
		if activeQuest.location != nil && capsule.dock != activeQuest.location && capsule.system != activeQuest.location.system { helmet.addMessage("Reach the \(activeQuest.location.system) system", color:cyan) }
		else if activeQuest.location != nil && capsule.dock != activeQuest.location { helmet.addMessage("Reach \(activeQuest.location.system) \(activeQuest.location.name!)", color:red) }
		else { helmet.addMessage(activeQuest.name) }
	}
	
	// MARK: Ports -
	
	override func listen(event:Event)
	{
		
	}
	
	override func bang()
	{
		
	}
	
	// MARK: Custom -
	
	func complete()
	{
		// Animate
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		locationPanel.position = SCNVector3(0,0,-0.5)
		locationPanel.opacity = 0
		
		SCNTransaction.setCompletionBlock({

			self.questPanel.position = SCNVector3(0,0,-0.5)
			
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.5)
			
			self.questPanel.position = SCNVector3(0,0,0)
			self.questPanel.opacity = 1
			
			SCNTransaction.setCompletionBlock({
				capsule.dock.onComplete()
				self.refresh()
			})
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
	}
	
	func connectToLocation(location:Location)
	{
		locationPanel.empty()
		if location.panel() != nil { locationPanel.add(location.panel()) }
		
		// Animate
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		questPanel.position = SCNVector3(0,0,-0.5)
		questPanel.opacity = 0
		
		SCNTransaction.setCompletionBlock({
			
			self.locationPanel.position = SCNVector3(0,0,-0.5)
			self.label.update(capsule.dock.name!)
			
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.5)
			
			self.locationPanel.position = SCNVector3(0,0,0)
			self.locationPanel.opacity = 1
			self.refresh()
			
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
		
		port.addEvent(location)
	}
	
	func disconnectFromLocation()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		locationPanel.position = SCNVector3(0,0,-0.5)
		locationPanel.opacity = 0
		
		SCNTransaction.setCompletionBlock({
			
			self.questPanel.position = SCNVector3(0,0,-0.5)
			
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.5)
			
			self.questPanel.position = SCNVector3(0,0,0)
			self.questPanel.opacity = 1
			self.refresh()
			
			SCNTransaction.setCompletionBlock({
				self.locationPanel.empty()
			})
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
		
		port.removeEvent()
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		if debug.isActive == false { player.lookAt(deg: -180) }
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		
		touch(1)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}