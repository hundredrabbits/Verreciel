import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationSatellite : Location
{
	var port:SCNPortSlot!
	var message:String!

	init(name:String, system:Systems, at: CGPoint = CGPoint(), message:String,item:Event!, mapRequirement:Item! = nil)
	{
		super.init(name:name, system:system, at:at)
		
		self.note = ""
		structure = StructureSatellite()
		self.isComplete = false
		self.mapRequirement = mapRequirement
		
		icon.replace(icons.satellite())
		
		self.message = message
		
		port = SCNPortSlot(host: self, hasDetails:true, align:.center)
		port.position = SCNVector3(0,-0.4,0)
		port.addEvent(item)
		port.enable()
		
		update()
	}
	
	// MARK: Panel
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let text = SCNLabel(text: self.message, align:.left)
		text.position = SCNVector3(-1.5,1,0)
		newPanel.addChildNode(text)
		
		newPanel.addChildNode(port)
	
		return newPanel
	}
	
	override func onDock()
	{
		super.onDock()
		port.refresh()
	}
	
	override func update()
	{
		if port.event == nil { self.complete() }
		updateIcon()
	}
	
	override func complete()
	{
		super.complete()
		structure.onComplete()
		intercom.complete()
	}
	
	override func onUploadComplete()
	{
		self.complete()
	}
	
	override func details() -> String
	{
		if port.hasItem() == true {
			return "\(port.event.name!)"
		}
		return "empty"
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}