
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class MainPanel : Panel
{
	let label = SCNLabel(text: "", scale: 0.1, align: alignment.center)
	let details = SCNLabel(text: "", scale: 0.085, align: alignment.center)
	var port:SCNPort!
	let portInputLabel = SCNLabel(text: "", scale: 0.03, color:grey, align: alignment.right)
	let portOutputLabel = SCNLabel(text: "", scale: 0.03, color:grey, align: alignment.left)
	
	let header = SCNNode()
	let footer = SCNNode()
	
	var mainNode = SCNNode()
	var decalsNode = SCNNode()
	
	override init()
	{
		super.init()
		
		name = "unknown"
		root.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		root.addChildNode(mainNode)
		root.addChildNode(decalsNode)
		
		// Header
		port = SCNPort(host: self)
		port.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		label.position = SCNVector3(x: 0, y:0, z: templates.radius)
		header.addChildNode(port)
		header.addChildNode(label)
		addChildNode(header)
		header.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		// Footer
		details.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		footer.addChildNode(details)
		addChildNode(footer)
		footer.eulerAngles.x = Float(degToRad(-templates.titlesAngle))
		
		// Setup
		port.addChildNode(portInputLabel)
		port.addChildNode(portOutputLabel)
		portInputLabel.position = SCNVector3(-templates.margin * 0.5,0,0)
		portOutputLabel.position = SCNVector3(templates.margin * 0.5,0,0)
		
		// Start
		
		mainNode.opacity = 0
		decalsNode.opacity = 0
		footer.opacity = 0
		
		label.update("--", color:grey)
		
		start()
	}
	
	// MARK: Installation -
	
	var installNode:SCNNode = SCNNode()
	var installProgressBar = SCNProgressBar(width: 1)
	var installLabel = SCNLabel(text:"install", color:grey, align:.center)
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		ui.addWarning("Installing", duration: 3)
		
		installNode = SCNNode()
		installNode.position = SCNVector3(0,0,0)
		installProgressBar = SCNProgressBar(width: 1)
		installProgressBar.position = SCNVector3(-installProgressBar.width/2,-0.3,0)
		installProgressBar.opacity = 1
		installNode.addChildNode(installProgressBar)
		
		installNode.addChildNode(installLabel)
		
		root.addChildNode(installNode)
	}
	
	override func installProgress()
	{
		super.installProgress()
		
		installLabel.update("Install \(Int(installPercentage))%")
		installProgressBar.update(installPercentage)
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		
		mainNode.position = SCNVector3(0,0,-0.2)
		mainNode.opacity = 0
		decalsNode.position = SCNVector3(0,0,-0.4)
		decalsNode.opacity = 0
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.7)
		mainNode.position = SCNVector3(0,0,0)
		mainNode.opacity = 1
		decalsNode.position = SCNVector3(0,0,0)
		decalsNode.opacity = 1
		footer.opacity = 1
		SCNTransaction.commit()
		
		installNode.removeFromParentNode()
		
		port.enable()
		label.update(name!, color: white)
		
		portInputLabel.update(port.IO(port.input))
		portOutputLabel.update(port.IO(port.output))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}