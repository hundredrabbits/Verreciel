
//  Created by Devine Lu Linvega on 2015-09-21.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Panel : Empty
{
	var isEnabled:Bool = false
	
	var root = Empty()
	
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
		audio.playSound("beep1")
	}
	
	func onInstallationComplete()
	{
		installPercentage = 0
		isInstalled = true
		audio.playSound("beep2")
	}
	
	override func payload() -> ConsolePayload
	{
		return ConsolePayload(data:[
			ConsoleData(text: "Capsule", details: "Panel"),
			ConsoleData(text: details)
		])
	}
	
	required init?(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}