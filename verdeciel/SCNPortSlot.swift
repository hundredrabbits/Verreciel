
//  Created by Devine Lu Linvega on 2015-12-14.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNPortSlot : SCNPort
{
	var hasDetails:Bool = false
	var label:SCNLabel!
	var details:SCNLabel!
	
	init(host:SCNNode = SCNNode(), position:SCNVector3 = SCNVector3(), input:eventTypes = eventTypes.unknown, output:eventTypes = eventTypes.unknown, align:alignment! = alignment.left, hasDetails:Bool = false)
	{
		super.init()
		
		self.hasDetails = hasDetails
		self.input = input
		self.output = output
		
		self.geometry = SCNPlane(width: 0.3, height: 0.3)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
		
		label = SCNLabel(text:"empty",scale:0.1,color:grey,align:align)
		self.addChildNode(label)
		
		details = SCNLabel(text:"",scale:0.075,color:grey,align:align)
		self.addChildNode(details)
		
		self.host = host
		
		if align == nil { label.opacity = 0 ; details.opacity = 0 }
		else if align == alignment.left { label.position = SCNVector3(0.3,0,0) ; details.position = SCNVector3(0.3,-0.3,0) }
		else if align == alignment.right { label.position = SCNVector3(-0.3,0,0) ; details.position = SCNVector3(-0.3,-0.3,0) }
		else if align == alignment.center { label.position = SCNVector3(0,-0.4,0) ; details.position = SCNVector3(0,-0.3,0) }
		
		setup()
		disable()
	}
	
	override func update()
	{
		details.opacity = (hasDetails == true) ? 1 : 0
		
		if event != nil {
			label.update(event.name!,color:white)
			details.update(event.note)
		}
		else{
			label.update("Empty",color:grey)
			details.update("--")
		}
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
		
		host.onUploadComplete()
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
