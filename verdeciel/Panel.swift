
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Panel : SCNNode
{
	var info:String = ""
	var isEnabled:Bool = false
	
	var root = SCNNode()
	
	override init()
	{
		super.init()
		addChildNode(root)
	}
	
	func refresh()
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
	
	// MARK: Installation -
	
	var isInstalled:Bool = false
	var installPercentage:CGFloat = 0
	
	func install()
	{
		if isInstalled == true { return }
		
		onInstallationBegin()
		
		self.installProgress()
	}
	
	func installProgress()
	{
		installPercentage += CGFloat(arc4random_uniform(60))/10
		
		if installPercentage > 100 {
			onInstallationComplete()
		}
		else{
			delay(0.05, block: { self.installProgress() })
		}
	}

	func onInstallationBegin()
	{
		print("+ PANEL    | Installing the \(name!)..")
	}
	
	func onInstallationComplete()
	{
		print("+ PANEL    | Installed the \(name!).")
		installPercentage = 0
		isInstalled = true
	}
	
	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}