import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationBank : Location
{
	var port1:SCNPort!
	var port1Label:SCNLabel!
	var port2:SCNPort!
	var port2Label:SCNLabel!
	var port3:SCNPort!
	var port3Label:SCNLabel!
	var port4:SCNPort!
	var port4Label:SCNLabel!
	var port5:SCNPort!
	var port5Label:SCNLabel!
	var port6:SCNPort!
	var port6Label:SCNLabel!
	
	override init(name:String = "", system:Systems, at: CGPoint = CGPoint())
	{
		super.init(name: name,system:system, at:at)
	
		self.note = ""
		structure = StructureDefault()
		icon = IconBank()
		
		port1 = SCNPortSlot(host: self)
		port2 = SCNPortSlot(host: self)
		port3 = SCNPortSlot(host: self)
		port4 = SCNPortSlot(host: self)
		port5 = SCNPortSlot(host: self)
		port6 = SCNPortSlot(host: self)
		
		port1.enable()
		port2.enable()
		port3.enable()
		port4.enable()
		port5.enable()
		port6.enable()
	}
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		port1.position = SCNVector3(templates.leftMargin,templates.lineSpacing * 2.5,0)
		newPanel.addChildNode(port1)
		
		port2.position = SCNVector3(templates.leftMargin,templates.lineSpacing * 1.5,0)
		newPanel.addChildNode(port2)
		
		port3.position = SCNVector3(templates.leftMargin,templates.lineSpacing * 0.5,0)
		newPanel.addChildNode(port3)
		
		port4.position = SCNVector3(templates.leftMargin,-templates.lineSpacing * 0.5,0)
		newPanel.addChildNode(port4)
		
		port5.position = SCNVector3(templates.leftMargin,-templates.lineSpacing * 1.5,0)
		newPanel.addChildNode(port5)
		
		port6.position = SCNVector3(templates.leftMargin,-templates.lineSpacing * 2.5,0)
		newPanel.addChildNode(port6)
		
		return newPanel
	}
	
	func contains(item:Item) -> Bool
	{
		if port1.event != nil && port1.event == item { return true }
		if port2.event != nil && port2.event == item { return true }
		if port3.event != nil && port3.event == item { return true }
		if port4.event != nil && port4.event == item { return true }
		if port5.event != nil && port5.event == item { return true }
		if port6.event != nil && port6.event == item { return true }
		return false
	}
	
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		
		structure.opacity = 0
		
		var i = 0
		for mesh in structure.childNodes {
			mesh.eulerAngles.y = (degToRad((CGFloat(i) * 0.10)))
			i += 1
		}
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		refresh()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(2)
		
		structure.opacity = 1
		
		var i = 0
		for mesh in structure.childNodes {
			mesh.eulerAngles.y = 0
			i += 1
		}
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		refresh()
	}
	
	override func details() -> String
	{
		return "6 items" // TODO:
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconBank : Icon
{
	override init()
	{
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}