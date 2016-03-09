
//  Created by Devine Lu Linvega on 2015-12-15.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class WidgetRadio : Widget
{
	var isPlaying:Bool = false
	var time:NSTimer!
	var seek:Int = 0
	
	override init()
	{
		super.init()
		
		name = "radio"
		info = "[missing text]"
		
		label.update(name!)
	}
	
	override func onUploadComplete()
	{
		playing()
	}
	
	func playing()
	{
		label.update("0:0\(seek)", color:red)
		time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("playing"), userInfo: nil, repeats: false)
		seek += 1
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		
		battery.installRadio()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}