
//  Created by Devine Lu Linvega on 2015-12-14.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPortSlot : SCNPort
{
	var label:SCNLabel!
	
	init(host:SCNNode = SCNNode(), position:SCNVector3 = SCNVector3(), input:eventTypes = eventTypes.unknown, output:eventTypes = eventTypes.unknown, align:alignment = alignment.left)
	{
		super.init()
		
		self.input = input
		self.output = output
		
		self.geometry = SCNPlane(width: 0.3, height: 0.3)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
		
		label = SCNLabel(text:"empty",scale:0.1,color:grey,align:align)
		label.position = (align == .left) ? SCNVector3(0.3,0,0) : SCNVector3(-0.3,0,0)
		self.addChildNode(label)
		
		self.host = host
		
		setup()
		disable()
	}
	
	override func update()
	{
		if event != nil { label.update(event.name!,color:white) }
		else{ label.update("Empty",color:grey) }
	}
	
	// MARK: Upload -
	
	var upload:Event!
	var uploadTimer:NSTimer!
	var uploadPercentage:Float = 0
	
	override func onConnect()
	{
		// Input
		if origin != nil && origin.event != nil && event == nil {
			upload = origin.event
			uploadTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("uploadProgress"), userInfo: nil, repeats: true)
		}
		
		if connection != nil && event != nil { connection.host.listen(event) }
	}
	
	func uploadProgress()
	{
		if origin == nil { uploadCancel() ; return }
		
		uploadPercentage += Float(arc4random_uniform(30))/10
		if uploadPercentage > 100 {
			uploadComplete()
		}
		else{
			label.update("Upload \(Int(uploadPercentage))%", color:grey)
		}
	}
	
	func uploadComplete()
	{
		if (origin != nil) { addEvent(syphon()) }
		uploadTimer.invalidate()
		uploadPercentage = 0
		update()
	}
	
	func uploadCancel()
	{
		uploadTimer.invalidate()
		uploadPercentage = 0
		update()
	}

	required init(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}
