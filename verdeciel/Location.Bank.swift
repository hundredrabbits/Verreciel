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
	
	init(name:String = "", system:Systems, at: CGPoint = CGPoint())
	{
		super.init(name: name,system:system, at:at, type: .bank)
	
		self.note = ""
		self.structure = structures.none()
		self.icon.replace(icons.bank())
		
		port1 = SCNPortSlot(host: self, input: Event.self, output: Event.self)
		port2 = SCNPortSlot(host: self, input: Event.self, output: Event.self)
		port3 = SCNPortSlot(host: self, input: Event.self, output: Event.self)
		port4 = SCNPortSlot(host: self, input: Event.self, output: Event.self)
		port5 = SCNPortSlot(host: self, input: Event.self, output: Event.self)
		port6 = SCNPortSlot(host: self, input: Event.self, output: Event.self)
		
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
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}