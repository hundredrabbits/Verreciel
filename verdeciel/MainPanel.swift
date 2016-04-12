
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
	
	let header = SCNNode()
	let footer = SCNNode()
	
	var mainNode = SCNNode()
	var decals = SCNNode()
	
	override init()
	{
		super.init()
		
		name = "unknown"
		root.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		root.addChildNode(mainNode)
		root.addChildNode(decals)
		
		// Header
		port = SCNPort(host: self)
		port.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		label.position = SCNVector3(x: 0, y:0, z: templates.radius)
		header.addChildNode(port)
		header.addChildNode(label)
		addChildNode(header)
		header.eulerAngles.x += (degToRad(templates.titlesAngle))
		
		// Footer
		details.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		footer.addChildNode(details)
		addChildNode(footer)
		footer.eulerAngles.x = (degToRad(-templates.titlesAngle))
		
		// Decals
		
		let width:CGFloat = 1.65
		let height:CGFloat = 1.8
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(width + 0.2,height - 0.2,0), nodeB: SCNVector3(width,height,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(width + 0.2,-height + 0.2,0), nodeB: SCNVector3(width,-height,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(width + 0.2,height - 0.2,0), nodeB: SCNVector3(width + 0.2,-height + 0.2,0), color: grey))
		
		decals.addChildNode(SCNLine(nodeA: SCNVector3(-width - 0.2,height - 0.2,0), nodeB: SCNVector3(-width,height,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(-width - 0.2,-height + 0.2,0), nodeB: SCNVector3(-width,-height,0), color: grey))
		decals.addChildNode(SCNLine(nodeA: SCNVector3(-width - 0.2,height - 0.2,0), nodeB: SCNVector3(-width - 0.2,-height + 0.2,0), color: grey))
		
		// Start
		
		mainNode.opacity = 0
		decals.opacity = 0
		footer.opacity = 0
		
		label.update("--", color:grey)
	}
	
	override func whenStart()
	{
		super.whenStart()
		
		decals.opacity = 0
		mainNode.opacity = 0
		label.update("--", color: grey)
	}
	
	// MARK: Installation -
	
	var installNode:SCNNode = SCNNode()
	var installProgressBar = SCNProgressBar(width: 1)
	var installLabel = SCNLabel(text:"install", color:grey, align:.center)
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		helmet.addWarning("Installing", duration: 3, flag:"install")
		
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
		decals.position = SCNVector3(0,0,-0.4)
		decals.opacity = 0
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.7)
		mainNode.position = SCNVector3(0,0,0)
		mainNode.opacity = 1
		decals.position = SCNVector3(0,0,0)
		decals.opacity = 1
		footer.opacity = 1
		SCNTransaction.commit()
		
		installNode.removeFromParentNode()
		
		port.enable()
		label.update(name!, color: white)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}