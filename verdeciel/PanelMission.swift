//
//  PanelBeacon.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelMission : Panel
{
	var content:Panel!

	var linesRoot:SCNNode!
	
	var quest1 = SCNLabel()
	var quest1Details = SCNLabel(text: "", align: alignment.right, color:grey)
	var quest2 = SCNLabel()
	var quest2Details = SCNLabel(text: "", align: alignment.right, color:grey)
	var quest3 = SCNLabel()
	var quest4 = SCNLabel()
	var quest5 = SCNLabel()
	
	var panelHead:SCNNode!
	
	// MARK: Default -
	
	override func setup()
	{
		name = "mission"
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		panelHead = SCNNode()
		port = SCNPort(host: self)
		port.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		label = SCNLabel(text: name!, scale: 0.1, align: alignment.center)
		label.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		panelHead.addChildNode(port)
		panelHead.addChildNode(label)
		addChildNode(panelHead)
		panelHead.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		// Decals
		
		decals.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.top,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.left + 0.2,templates.bottom,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.bottom + 0.2,0), nodeB: SCNVector3(templates.right - 0.2,templates.bottom,0), color: grey))
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.left,templates.top - 0.2,0), nodeB: SCNVector3(templates.left,templates.bottom + 0.2,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(templates.right,templates.top - 0.2,0), nodeB: SCNVector3(templates.right,templates.bottom + 0.2,0), color: grey))
		
		content = Panel()
		interface.addChildNode(content)
	
		linesRoot = SCNNode()
		linesRoot.position = SCNVector3(0,0,0)
		
		quest1.position = SCNVector3(x: templates.leftMargin, y: 0.8, z: 0)
		linesRoot.addChildNode(quest1)
		quest1Details.position = SCNVector3(x: templates.rightMargin, y: 0.8, z: 0)
		linesRoot.addChildNode(quest1Details)
		
		quest2.position = SCNVector3(x: templates.leftMargin, y: 0.4, z: 0)
		linesRoot.addChildNode(quest2)
		quest2Details.position = SCNVector3(x: templates.rightMargin, y: 0.4, z: 0)
		linesRoot.addChildNode(quest2Details)
		
		quest3.position = SCNVector3(x: templates.leftMargin, y: 0, z: 0)
		linesRoot.addChildNode(quest3)
		
		quest4.position = SCNVector3(x: templates.leftMargin, y: -0.4, z: 0)
		linesRoot.addChildNode(quest4)
		
		quest5.position = SCNVector3(x: templates.leftMargin, y: -0.8, z: 0)
		linesRoot.addChildNode(quest5)
		
		interface.addChildNode(linesRoot)
	}
	
	override func installedFixedUpdate()
	{
		if quests == nil { return }
		
		// Tutorial Quest Line
		if quests.tutorialLatest != nil {
			quest1.update((quests.tutorialLatest.name!))
			quest1Details.update("\(quests.tutorialProgress)/\(quests.tutorial.count)")
			
			ui.addMessage(quests.tutorialLatest.name!)
		} else {
			quest1.update("--")
		}
		
		// Falvet Quest Line
		if quests.falvetLatest != nil {
			quest2.update((quests.falvetLatest.name!))
			quest2Details.update("\(quests.falvetProgress)/\(quests.falvet.count)")
		} else {
			quest2.update("--")
		}
		
		quest2.update("--")
		quest3.update("--")
		quest4.update("--")
		quest5.update("--")
	}
	
	// MARK: Ports -
	
	override func listen(event:Event)
	{
		
	}
	
	override func bang()
	{
	}
	
	// MARK: Custom -
	
	func dock(location:Location)
	{
		content.addChildNode(location.interface)
		content.opacity = 0 // TODO: installation of custom panel
		linesRoot.opacity = 1
	}
	
	func undock()
	{
		content.empty()
		linesRoot.opacity = 1
	}
}