//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelIntercom : MainPanel
{
	var locationPanel:Empty!
	
	var defaultPanel:Empty!
	
	var systemLabel:SCNLabel!
	var distanceLabel:SCNLabel!
	var typeLabel:SCNLabel!
	var statusLabel:SCNLabel!
	var detailLabel:SCNLabel!
	
	var systemValueLabel:SCNLabel!
	var distanceValueLabel:SCNLabel!
	var typeValueLabel:SCNLabel!
	var statusValueLabel:SCNLabel!
	var detailValueLabel:SCNLabel!

	var selector = SCNLabel(text: ">", align:.left)
	
	// MARK: Default -
	
	override init()
	{
		super.init()
		
		name = "mission"
		details = "displays informations"
	
		locationPanel = Panel()
		mainNode.addChildNode(locationPanel)
		
		defaultPanel = Empty()
		defaultPanel.position = SCNVector3(0,0,0)
		
		systemLabel = SCNLabel(text: "system", align: .right, color: grey)
		defaultPanel.addChildNode(systemLabel)
		systemValueLabel = SCNLabel(text: "Loiqe", align: .left, color: white)
		defaultPanel.addChildNode(systemValueLabel)
		
		systemLabel.position = SCNVector3(-0.1,1 - 0.2,0)
		systemValueLabel.position = SCNVector3(0.1,1 - 0.2,0)
		
		distanceLabel = SCNLabel(text: "distance", align: .right, color: grey)
		defaultPanel.addChildNode(distanceLabel)
		distanceValueLabel = SCNLabel(text: "324.4", align: .left, color: white)
		defaultPanel.addChildNode(distanceValueLabel)
		
		distanceLabel.position = SCNVector3(-0.1,1 - 0.6,0)
		distanceValueLabel.position = SCNVector3(0.1,1 - 0.6,0)
		
		typeLabel = SCNLabel(text: "type", align: .right, color: grey)
		defaultPanel.addChildNode(typeLabel)
		typeValueLabel = SCNLabel(text: "harvest", align: .left, color: white)
		defaultPanel.addChildNode(typeValueLabel)
		
		typeLabel.position = SCNVector3(-0.1,1 - 1.0,0)
		typeValueLabel.position = SCNVector3(0.1,1 - 1.0,0)
		
		statusLabel = SCNLabel(text: "status", align: .right, color: grey)
		defaultPanel.addChildNode(statusLabel)
		statusValueLabel = SCNLabel(text: "completed", align: .left, color: white)
		defaultPanel.addChildNode(statusValueLabel)
		
		statusLabel.position = SCNVector3(-0.1,1 - 1.4,0)
		statusValueLabel.position = SCNVector3(0.1,1 - 1.4,0)
		
		detailLabel = SCNLabel(text: "details", scale:0.075, align: .right, color: grey)
		defaultPanel.addChildNode(detailLabel)
		detailValueLabel = SCNLabel(text: "key", scale:0.075, align: .left, color: white)
		defaultPanel.addChildNode(detailValueLabel)
		
		detailLabel.position = SCNVector3(-0.1,1 - 1.8,0)
		detailValueLabel.position = SCNVector3(0.1,1 - 1.8,0)
		
		mainNode.addChildNode(defaultPanel)
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(0,0,1),host:self))
		
		locationPanel.hide()
	}
	
	override func whenRenderer()
	{
		super.whenRenderer()
		
		if capsule.isDocked && capsule.dock.isComplete != nil && capsule.dock.isComplete == false {
			locationPanel.update()
		}
		else if capsule.dock != nil || radar.port.hasEvent() == true {
			let target = (radar.port.hasEvent() == true ) ? radar.port.event as! Location : capsule.dock
			
			systemValueLabel.update("\(target.system)")
			distanceLabel.update("Distance")
			distanceValueLabel.update( (capsule.isDockedAtLocation(target) ? "docked" : "\(String(format: "%.2f",target.distance * 19))") )
			typeLabel.update("type")
			typeValueLabel.update("\(target.name!)")
			detailValueLabel.update(target.details)
			
			if target.isComplete == nil { statusValueLabel.update("--", color:white) }
			else if target.isComplete == true { statusValueLabel.update("complete", color:cyan) }
			else if target.isComplete == false { statusValueLabel.update("quest", color:red) }
		}
		else {
			systemValueLabel.update("\(capsule.system)")
			distanceLabel.update("Position")
			distanceValueLabel.update("\(Int(capsule.at.x)),\(Int(capsule.at.y))")
			typeValueLabel.update("--")
			statusValueLabel.update("in flight", color:white)
			detailValueLabel.update("--")
		}
	}
	
	override func touch(id: Int)
	{
		refresh()
		audio.playSound("click3")
	}
	
	override func refresh()
	{
		if( isInstalled == true ){
			if capsule.dock == nil { nameLabel.update("mission",color:white) }
			else if capsule.dock.isComplete == nil { nameLabel.update(capsule.dock.name!,color:white) }
			else if capsule.dock.isComplete == true { nameLabel.update(capsule.dock.name!,color:cyan) }
			else{ nameLabel.update(capsule.dock.name!,color:red) }
		}
	}
	
	// MARK: Custom -
	
	func complete()
	{
		// Animate
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		locationPanel.position = SCNVector3(0,0,-0.5)
		locationPanel.hide()
		
		SCNTransaction.setCompletionBlock({

			self.defaultPanel.position = SCNVector3(0,0,-0.5)
			
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.5)
			
			self.defaultPanel.position = SCNVector3(0,0,0)
			self.defaultPanel.show()
			
			SCNTransaction.setCompletionBlock({
				self.refresh()
			})
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
	}
	
	func connectToLocation(location:Location)
	{
		locationPanel.empty()
		if location.panel() != nil { locationPanel.addChildNode(location.panel()) }
		else{ return }
		
		// Animate
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		defaultPanel.position = SCNVector3(0,0,-0.5)
		defaultPanel.hide()
		
		SCNTransaction.setCompletionBlock({
			
			self.locationPanel.position = SCNVector3(0,0,-0.5)
			self.nameLabel.update(capsule.dock.name!)
			
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.5)
			
			self.locationPanel.position = SCNVector3(0,0,0)
			self.locationPanel.show()
			self.refresh()
			
			SCNTransaction.commit()
		})
		SCNTransaction.commit()
		
		port.addEvent(location)
		
		if location.isPortEnabled == true { self.port.enable() }
		else{ self.port.disable() }
	}
	
	func disconnectFromLocation()
	{
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		locationPanel.position = SCNVector3(0,0,-0.5)
		locationPanel.hide()
		
		SCNTransaction.setCompletionBlock({
			
			self.defaultPanel.position = SCNVector3(0,0,-0.5)
			
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.5)
			
			self.defaultPanel.position = SCNVector3(0,0,0)
			self.defaultPanel.show()
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
		
		player.lookAt(deg: -180)
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
