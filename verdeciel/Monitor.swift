//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Monitor : SCNNode
{
	let label = SCNLabel(text: "", scale: 0.1, align: alignment.center)
	let details = SCNLabel(text: "", scale: 0.085, align: alignment.center)
	
	override init()
	{
		super.init()
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
		installer.position = SCNVector3(0,0,templates.radius)
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
		
		isInstalled = true
		installer.opacity = 0
		
		label.updateWithColor(name!, color: white)
		self.position = SCNVector3(0,0,templates.radius - 0.5)
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		self.opacity = 1
		self.position = SCNVector3(0,0,templates.radius)
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