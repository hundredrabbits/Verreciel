
//  Created by Devine Lu Linvega on 2015-12-15.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class WidgetRadio : SCNNode
{
	var port:SCNPortSlot!
	var label:SCNLabel!
	
	override init()
	{
		super.init()
		
		name = "radio"
		
		port = SCNPortSlot(host: self, input: eventTypes.record, output: eventTypes.signal, align: .left)
		port.position = SCNVector3(0,-0.6,templates.radius)
		port.enable()
		
		label = SCNLabel(text:"radio", align:.right)
		label.position = SCNVector3(-0.3,0,0)
		port.addChildNode(label)
		
		addChildNode(port)
	}
	
	override func onUploadComplete()
	{
		playing()
	}
	
	var time:NSTimer!
	var seek:Int = 0
	
	func playing()
	{
		label.update("0:0\(seek)", color:red)
		time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("playing"), userInfo: nil, repeats: false)
		seek += 1
	}
	
	func install()
	{
		port.enable()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}