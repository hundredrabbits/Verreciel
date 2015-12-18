
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Panel : SCNNode
{
	var isEnabled:Bool = false
	
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
	
	var installTimer:NSTimer!
	var installPercentage:Float = 0
	
	func install()
	{
		onInstallationBegin()
		installTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("installProgress"), userInfo: nil, repeats: true)
	}
	
	func installProgress()
	{
		installPercentage += Float(arc4random_uniform(60))/10
		if installPercentage > 100 {
			onInstallationComplete()
			installPercentage = 0
		}
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