//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelIntercom : MainPanel
{
	var locationPanel:SCNNode!
	
	var defaultPanel:SCNNode!
	
	var systemLabel:SCNLabel!
	var distanceLabel:SCNLabel!
	var typeLabel:SCNLabel!
	var statusLabel:SCNLabel!
	var detailsLabel:SCNLabel!
	
	var systemValueLabel:SCNLabel!
	var distanceValueLabel:SCNLabel!
	var typeValueLabel:SCNLabel!
	var statusValueLabel:SCNLabel!
	var detailsValueLabel:SCNLabel!

	var selector = SCNLabel(text: ">", align:.left)
	
	// MARK: Default -
	
	override init()
	{
		super.init()
		
		name = "mission"
		info = "[missing text]"
	
		locationPanel = Panel()
		mainNode.addChildNode(locationPanel)
		
		defaultPanel = SCNNode()
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
		
		detailsLabel = SCNLabel(text: "details", align: .right, color: grey)
		defaultPanel.addChildNode(detailsLabel)
		detailsValueLabel = SCNLabel(text: "key", align: .left, color: white)
		defaultPanel.addChildNode(detailsValueLabel)
		
		detailsLabel.position = SCNVector3(-0.1,1 - 1.8,0)
		detailsValueLabel.position = SCNVector3(0.1,1 - 1.8,0)
		
		mainNode.addChildNode(defaultPanel)
		
		footer.addChildNode(SCNHandle(destination: SCNVector3(0,0,1),host:self))
		
		locationPanel.opacity = 0
	}
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
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
			detailsValueLabel.update(target.details())
			
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
			detailsValueLabel.update("--")
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

			self.defaultPanel.position = SCNVector3(0,0,-0.5)
			
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.5)
			
			self.defaultPanel.position = SCNVector3(0,0,0)
			self.defaultPanel.opacity = 1
			
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
		
		defaultPanel.position = SCNVector3(0,0,-0.5)
		defaultPanel.opacity = 0
		
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
			
			self.defaultPanel.position = SCNVector3(0,0,-0.5)
			
			SCNTransaction.begin()
			SCNTransaction.setAnimationDuration(0.5)
			
			self.defaultPanel.position = SCNVector3(0,0,0)
			self.defaultPanel.opacity = 1
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
		port.disable()
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