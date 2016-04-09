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
		
		mainNode.addChildNode(questPanel)
		
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
		else{ return }
		
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
		
		if location.isPortEnabled == true { port.enable() }
		else{ port.disable() }
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
	
	override func onConnect()
	{
		if capsule.isDocked == true {
			capsule.dock.onConnect()
		}
	}
	
	override func onDisconnect()
	{
		if capsule.isDocked == true {
			capsule.dock.onDisconnect()
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}