//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Converter : SCNNode
{
	let interface = SCNNode()
	let label = SCNLabel(text: "", scale: 0.1, align: alignment.center)
	let details = SCNLabel(text: "", scale: 0.085, align: alignment.center)
	var port:SCNPort!
	let portInputLabel = SCNLabel(text: "", scale: 0.03, color:grey, align: alignment.right)
	let portOutputLabel = SCNLabel(text: "", scale: 0.03, color:grey, align: alignment.left)
	
	override init()
	{
		super.init()
		
		name = "converter"
		
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		port = SCNPort(host: self, input: eventTypes.generic, output: eventTypes.location)
		interface.addChildNode(port)
		
		label.position = SCNVector3(0,-0.5,0)
		interface.addChildNode(label)
		
		port.addChildNode(portInputLabel)
		port.addChildNode(portOutputLabel)
		portInputLabel.position = SCNVector3(-templates.margin * 0.5,0,0)
		portOutputLabel.position = SCNVector3(templates.margin * 0.5,0,0)
		
		portInputLabel.update("--")
		portOutputLabel.update("--")
		
		addChildNode(interface)
		self.eulerAngles.x = Float(degToRad(-templates.monitorsAngle))
	}
	
	override func fixedUpdate()
	{
		if isInstalling == true {
			installProgress += CGFloat(arc4random_uniform(100))/50
			installProgressBar.update(installProgress)
			installProgressBar.opacity = 1
			label.updateWithColor("Installing \(Int(installProgress))%", color: grey)
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
	
	func display()
	{
		print("ready for installation")
		port.enable()
		port.input = eventTypes.item
		port.requirement = items.radio
		label.updateWithColor("awaiting panel",color:grey)
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
		onInstallationBegin()
	}
	
	func installation()
	{
		installer = SCNNode()
		installer.addChildNode(SCNLine(nodeA: SCNVector3(-0.1,0.1,0), nodeB: SCNVector3(0.1,-0.1,0), color: grey))
		installer.addChildNode(SCNLine(nodeA: SCNVector3(-0.1,-0.1,0), nodeB: SCNVector3(0.1,0.1,0), color: grey))
		installer.position = SCNVector3(0,0,0)
		installProgressBar = SCNProgressBar(width: 1)
		installProgressBar.position = SCNVector3(-0.5,-0.5,0)
		installProgressBar.opacity = 0
		installer.addChildNode(installProgressBar)
		self.addChildNode(installer)
		
		label.updateWithColor("--", color: grey)
		self.opacity = 0
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
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		self.opacity = 1
		details.opacity = 1
		SCNTransaction.setCompletionBlock({ self.port.enable() ; self.onInstallationComplete() })
		SCNTransaction.commit()
	}
	
	func onInstallationBegin()
	{
		
	}
	
	func onInstallationComplete()
	{
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}