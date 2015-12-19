
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Panel : SCNNode
{
	var isEnabled:Bool = false
	
	var root = SCNNode()
	
	override init()
	{
		super.init()
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
	var installTimer:NSTimer!
	var installPercentage:CGFloat = 0
	
	func install()
	{
		if isInstalled == true { return }
		onInstallationBegin()
		installTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("installProgress"), userInfo: nil, repeats: true)
	}
	
	func installProgress()
	{
		installPercentage += CGFloat(arc4random_uniform(60))/10
		
		if installPercentage > 100 {
			onInstallationComplete()
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
		installTimer.invalidate()
		isInstalled = true
	}
	
	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}