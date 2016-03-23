
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
	var placeholder:String!
	
	init(host:SCNNode = SCNNode(), input:Event.Type, output:Event.Type, align:alignment! = .left, hasDetails:Bool = false, placeholder:String = "Empty")
	{
		super.init(host:host, input:input, output:output)
		
		self.placeholder = placeholder
		self.hasDetails = hasDetails
		self.input = input
		self.output = output
		
		self.geometry = SCNPlane(width: 0.3, height: 0.3)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		trigger = SCNTrigger(host: self, size: CGSize(width: 1, height: 1))
		trigger.position = SCNVector3(0,0,-0.1)
		self.addChildNode(trigger)
		
		label = SCNLabel(text:placeholder,scale:0.1,color:grey,align:align)
		self.addChildNode(label)
		
		details = SCNLabel(text:"",scale:0.075,color:grey,align:align)
		self.addChildNode(details)
		
		self.host = host
		
		if align == nil { label.opacity = 0 ; details.opacity = 0 }
		else if align == alignment.left { label.position = SCNVector3(0.3,0,0) ; details.position = SCNVector3(0.3,-0.3,0) }
		else if align == alignment.right { label.position = SCNVector3(-0.3,0,0) ; details.position = SCNVector3(-0.3,-0.3,0) }
		else if align == alignment.center { label.position = SCNVector3(0,-0.5,0) ; details.position = SCNVector3(0,-0.8,0) }
		
		setup()
		disable()
	}
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		if isEnabled == false {
			sprite_input.updateChildrenColors(clear)
		}
		else if event != nil {
			sprite_input.updateChildrenColors(clear)
		}
		else{
			sprite_input.updateChildrenColors(grey)
		}
	}
	
	func refresh()
	{
		details.opacity = (hasDetails == true) ? 1 : 0
		
		if event != nil {
			label.update(event.name!)
			details.update(event.note)
		}
		else{
			label.update(placeholder)
			details.update("--")
		}
		
		if isEnabled == false { label.update(grey) }
		else if requirement != nil && event != nil && requirement.name == event.name { label.update(cyan) }
		else if requirement != nil && event != nil && requirement.name != event.name { label.update(red) }
		else if event != nil { label.update(white) }
		else{ label.update(grey) }
	}
	
	override func removeEvent()
	{
		super.removeEvent()
		refresh()
	}
	
	override func onConnect()
	{
		// Input
		if origin != nil && origin.event != nil && event == nil {
			upload(origin.event as! Item)
		}
		if connection != nil && event != nil { connection.host.listen(event) }
	}
	
	override func onDisconnect()
	{
		super.onDisconnect()
		host.onDisconnect()
	}
	
	override func addEvent(event:Event)
	{
		super.addEvent(event)
		refresh()
	}
	
	// MARK: Upload -
	
	var upload:Event!
	var uploadTimer:NSTimer!
	var uploadPercentage:Float = 0
	
	func upload(item:Item)
	{
		upload = item
		uploadTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(self.uploadProgress), userInfo: nil, repeats: true)
	}
	
	func uploadProgress()
	{
		if origin == nil { uploadCancel() ; return }
		
		uploadPercentage += Float(arc4random_uniform(60))/10
		if uploadPercentage > 100 {
			origin.wire.isUploading = false
			uploadComplete()
			
		}
		else{
			origin.wire.isUploading = true
			label.update("\(Int(uploadPercentage))%", color:grey)
		}
	}
	
	func uploadComplete()
	{
		if (origin != nil) { addEvent(syphon()) }
		uploadTimer.invalidate()
		uploadPercentage = 0
		refresh()
		
		host.onUploadComplete()
	}
	
	func uploadCancel()
	{
		uploadTimer.invalidate()
		uploadPercentage = 0
		refresh()
	}

	required init(coder aDecoder: NSCoder)
	{
	    fatalError("init(coder:) has not been implemented")
	}
}
