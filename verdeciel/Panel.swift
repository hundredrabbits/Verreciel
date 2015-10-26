//
//  SCNNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Panel : SCNNode
{
	let label = SCNLabel(text: "", scale: 0.1, align: alignment.center)
	let details = SCNLabel(text: "", scale: 0.1, align: alignment.center)
	var port:SCNPort!
	let portInputLabel = SCNLabel(text: "", scale: 0.03, color:grey, align: alignment.right)
	let portOutputLabel = SCNLabel(text: "", scale: 0.03, color:grey, align: alignment.left)
	
	let header = SCNNode()
	let footer = SCNNode()
	
	var isEnabled:Bool = true
	var interface:SCNNode!
	var decals:SCNNode!
	
	override init()
	{
		super.init()
		
		initialSetup()
		setup()
		
		installation()
		start()
	}
	
	// MARK: Setup
	
	func initialSetup()
	{
		name = "unknown"
		
		interface = SCNNode()
		self.addChildNode(interface)
		decals = SCNNode()
		self.addChildNode(decals)
		
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		port = SCNPort(host: self)
		port.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		label.position = SCNVector3(x: 0, y:0, z: templates.radius)
		header.addChildNode(port)
		header.addChildNode(label)
		addChildNode(header)
		header.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		details.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		footer.addChildNode(details)
		addChildNode(footer)
		footer.eulerAngles.x = Float(degToRad(-templates.titlesAngle))
		
		port.addChildNode(portInputLabel)
		port.addChildNode(portOutputLabel)
		portInputLabel.position = SCNVector3(-templates.margin * 0.5,0,0)
		portOutputLabel.position = SCNVector3(templates.margin * 0.5,0,0)
		
		portInputLabel.update("--")
		portOutputLabel.update("--")
	}
	
	func setup()
	{
		
	}
	
	override func fixedUpdate()
	{
		if isInstalling == true {
			installProgress += CGFloat(arc4random_uniform(100))/50
			installProgressBar.update(installProgress)
//			label.updateWithColor("Installing \(Int(installProgress))%", color: grey)
			installProgressBar.opacity = 1
			if installProgress >= 100 {
				installed()
				installer.opacity = 0
				isInstalling = false
			}
		}
		
		if isInstalled == true {
			if port.hasEvent(port.output) == true { portOutputLabel.updateColor(white) } else { portOutputLabel.updateColor(grey) }
			installedFixedUpdate()
		}
	}
	
	func installedFixedUpdate()
	{
		
	}
	
	func enable()
	{
		isEnabled = true
	}
	
	func disable()
	{
		isEnabled = false
	}
	
	func updateInterface(interface:Panel)
	{
		// Empty node
		for node in self.childNodes {
			node.removeFromParentNode()
		}
		
		// Add
		for node in interface.childNodes {
			self.addChildNode(node)
		}
	}
	
	// MARK: Installation -

	var isInstalling:Bool = false
	var isInstalled:Bool = false
	var installer:SCNNode = SCNNode()
	var installProgress:CGFloat = 0
	var installProgressBar = SCNProgressBar(width: 1)
	
	func install()
	{
		isInstalling = true
	}
	
	func installation()
	{
		installer = SCNNode()
		installer.addChildNode(SCNLine(nodeA: SCNVector3(-0.1,0.1,0), nodeB: SCNVector3(0.1,-0.1,0), color: grey))
		installer.addChildNode(SCNLine(nodeA: SCNVector3(-0.1,-0.1,0), nodeB: SCNVector3(0.1,0.1,0), color: grey))
		installer.position = SCNVector3(0,0,templates.radius)
		installProgressBar = SCNProgressBar(width: 1)
		installProgressBar.position = SCNVector3(-0.5,-0.5,0)
		installProgressBar.opacity = 0
		installer.addChildNode(installProgressBar)
		self.addChildNode(installer)
		
		label.updateWithColor("--", color: grey)
		interface.opacity = 0
		decals.opacity = 0
		details.opacity = 0
	}
	
	func installed()
	{
		print("+ PANEL    | Installed the \(name!)")
		
		portInputLabel.update("\(port.input)")
		portOutputLabel.update("\(port.output)")
		
		isInstalled = true
		installer.opacity = 0
		
		label.updateWithColor(name!, color: white)
		decals.position = SCNVector3(0,0,templates.radius - 0.5)
		interface.position = SCNVector3(0,0,templates.radius + 1)
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		decals.opacity = 1
		decals.position = SCNVector3(0,0,templates.radius)
		interface.opacity = 1
		interface.position = SCNVector3(0,0,templates.radius)
		details.opacity = 1
		SCNTransaction.setCompletionBlock({ self.port.enable() })
		SCNTransaction.commit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}