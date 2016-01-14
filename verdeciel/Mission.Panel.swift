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
		
		// Decals

		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decalsNode.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
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
		if capsule.isDocked && capsule.dock.isComplete != nil && capsule.dock.isComplete == false {
			locationPanel.update()
		}
	}
	
	override func touch(id: Int)
	{
		
		quest1Details.update(grey)
		quest2Details.update(grey)
		quest3Details.update(grey)
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.2)
		
		if id == 1 { selector.position = SCNVector3(selector.position.x,quest1.position.y,0) }
		if id == 2 { selector.position = SCNVector3(selector.position.x,quest2.position.y,0) }
		if id == 3 { selector.position = SCNVector3(selector.position.x,quest3.position.y,0) }
		
		SCNTransaction.setCompletionBlock({
			if id == 1 { quests.setActive(Chapters.tutorial) ; self.quest1Details.update(white) }
			if id == 2 { quests.setActive(Chapters.cyanine) ; self.quest2Details.update(white) }
			if id == 3 { quests.setActive(Chapters.vermil) ; self.quest3Details.update(white) }
		})
		SCNTransaction.commit()
		
		refresh()
	}
	
	override func refresh()
	{
		if capsule.dock == nil { label.update(white) }
		else if capsule.dock.isComplete == nil { label.update(white) }
		else if capsule.dock.isComplete == true { label.update(cyan) }
		else{ label.update(red) }
		
		quest1Label.update(quests.currentMission[.tutorial]!.name)
		quest1Details.update(quests.currentMission[.tutorial]!.currentQuest!.name)
		let currentQuest = quests.currentMission[.tutorial]!.id
		let questCount = quests.questlog[.tutorial]!.count
		quest1Completion.update("\(currentQuest)/\(questCount)")
		quest1Progress.update( (CGFloat(currentQuest)/CGFloat(questCount)) * 100 )
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
				capsule.dock.isComplete = true
				capsule.dock.onComplete()
				self.refresh()
			})
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
	}
	
	func connectToLocation(location:Location)
	{
		if location.isComplete != nil && location.isComplete == true { label.update(name!) ; return }
		
		locationPanel.empty()
		locationPanel.add(location.panel())
		
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
	}
	
	func disconnectFromLocation()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		locationPanel.position = SCNVector3(0,0,-0.5)
		locationPanel.opacity = 0
		
		SCNTransaction.setCompletionBlock({
			
			self.questPanel.position = SCNVector3(0,0,-0.5)
			self.label.update(self.name!)
			
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
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		player.lookAt(deg: -180)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}