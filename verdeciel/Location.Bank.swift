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
		super.init(name: name,system:system, at:at, icon:IconBank(), structure:StructureBank())
		
		self.details = "storage"
		
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
	
	func addItems(items:Array<Item>)
	{
		for item in items {
			if port1.hasItem() == false { port1.addEvent(item) }
			else if port2.hasItem() == false { port2.addEvent(item) }
			else if port3.hasItem() == false { port3.addEvent(item) }
			else if port4.hasItem() == false { port4.addEvent(item) }
			else if port5.hasItem() == false { port5.addEvent(item) }
			else if port6.hasItem() == false { port6.addEvent(item) }
		}
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
		SCNTransaction.setAnimationDuration(0.5)
		
		structure.hide()
		
		var i = 0
		for mesh in structure.childNodes {
			mesh.eulerAngles.y = (degToRad((Float(i) * 0.10)))
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
		SCNTransaction.setAnimationDuration(0.5)
		
		structure.show()
		
		var i = 0
		for mesh in structure.childNodes {
			mesh.eulerAngles.y = 0
			i += 1
		}
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		refresh()
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
		
		mesh.addChildNode(SCNLine(vertices: [SCNVector3(x:0,y:size,z:0),  SCNVector3(x:size,y:0,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:-size,y:0,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:size,y:0,z:0)],color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class StructureBank : Structure
{
	override init()
	{
		super.init()
		
		var i = 0
		while i < 7 {
			let rect = ShapeRect(size:CGSize(width:6,height:6), color:white)
			rect.position.y = Float((Float(i)) - 3.5)
			root.addChildNode(rect)
			i += 1
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}