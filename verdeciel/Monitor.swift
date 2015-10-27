//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Monitor : SCNNode
{
	let label = SCNLabel(text: "", scale: 0.08, align: alignment.center)
	let details = SCNLabel(text: "", scale: 0.04, align: alignment.center, color: grey)
	let interface = SCNNode()
	
	override init()
	{
		super.init()
		
		name = "journey"
		
		addChildNode(interface)
		interface.position = SCNVector3(0,0,templates.radius)
		
		label.update("0")
		label.position = SCNVector3(0,0,0)
		interface.addChildNode(label)
		
		details.update(name!)
		details.position = SCNVector3(0,0.2,0)
		interface.addChildNode(details)
		
		label.opacity = 0
		details.opacity = 0
		
		installation()
		setup()
	}
	
	func setup()
	{
		
	}
	
	override func fixedUpdate()
	{
		if isInstalling == true {
			installProgress += CGFloat(arc4random_uniform(100))/50
			installProgressBar.update(installProgress)
			installProgressBar.opacity = 1
			if installProgress >= 100 {
				installed()
				installer.opacity = 0
				isInstalling = false
			}
		}
		
		if isInstalled == true {
			installedFixedUpdate()
		}
	}
	
	func installedFixedUpdate()
	{
		
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
		installer.addChildNode(SCNLine(nodeA: SCNVector3(-0.1,0.1 + 0.1,0), nodeB: SCNVector3(0.1,-0.1 + 0.1,0), color: grey))
		installer.addChildNode(SCNLine(nodeA: SCNVector3(-0.1,-0.1 + 0.1,0), nodeB: SCNVector3(0.1,0.1 + 0.1,0), color: grey))
		installer.position = SCNVector3(0,0,0)
		installProgressBar = SCNProgressBar(width: 0.5)
		installProgressBar.position = SCNVector3(-0.25,-0.2,0)
		installProgressBar.opacity = 0
		installer.addChildNode(installProgressBar)
		interface.addChildNode(installer)
	}
	
	func installed()
	{
		print("+ PANEL    | Installed the \(name!)")
		
		isInstalled = true
		installer.opacity = 0
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		label.opacity = 1
		details.opacity = 1
		SCNTransaction.setCompletionBlock({ self.onInstallationComplete() })
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