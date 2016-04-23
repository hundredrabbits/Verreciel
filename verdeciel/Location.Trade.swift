import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationTrade : Location
{
	var wantPort:SCNPortSlot!
	var givePort:SCNPortSlot!
	
	init(name:String = "", system:Systems, at: CGPoint = CGPoint(), want:Event,give:Event, mapRequirement:Item! = nil)
	{
		super.init(name: name,system:system, at: at, icon:IconTrade(), structure:StructureTrade())
		
		details = give.name!
		
		self.isComplete = false
		self.mapRequirement = mapRequirement
		
		wantPort = SCNPortSlot(host: self)
		wantPort.addRequirement(want)
		wantPort.label.update("EMPTY", color:red)
		givePort = SCNPortSlot(host: self)
		givePort.addEvent(give)
	}
	
	override func whenStart()
	{
		super.whenStart()
		
		refresh()
	}
	
	// MARK: Panels -
	
	override func panel() -> Panel!
	{
		if isComplete == true { return nil }
		
		let newPanel = Panel()
		
		let text = SCNLabel(text: "Trading \(wantPort.requirement.name!)$For \(givePort.event.name!)", align:.left)
		text.position = SCNVector3(-1.5,1,0)
		newPanel.addChildNode(text)
		
		// Want
		
		wantPort.position = SCNVector3(x: -1.2, y: -0.6, z: 0)
		wantPort.enable()
		newPanel.addChildNode(wantPort)
		
		// Give
		givePort.position = SCNVector3(x:0, y: -0.5, z: 0)
		wantPort.addChildNode(givePort)
		
		wantPort.addChildNode(SCNLine(vertices: [SCNVector3(-0.125,0,0), SCNVector3(-0.3,0,0)], color: grey))
		wantPort.addChildNode(SCNLine(vertices: [SCNVector3(-0.3,0,0), SCNVector3(-0.3,-0.5,0)], color: grey))
		wantPort.addChildNode(SCNLine(vertices: [SCNVector3(-0.3,-0.5,0), SCNVector3(-0.125,-0.5,0)], color: grey))
		
		let wantLabel = SCNLabel(text: "Trade Table", color:grey)
		wantLabel.position = SCNVector3(x: -1.5, y: 0, z: 0)
		newPanel.addChildNode(wantLabel)
		
		givePort.disable()
		
		return newPanel
	}
	
	override func onUploadComplete()
	{
		refresh()
	}
	
	override func onDisconnect()
	{
		refresh()
	}
	
	var isTradeAccepted:Bool = false
	
	override func refresh()
	{
		if wantPort.event != nil && wantPort.event.name == wantPort.requirement.name {
			wantPort.disable()
			wantPort.label.update("Accepted",color:cyan)
			givePort.enable()
			givePort.label.update(white)
			isTradeAccepted = true
		}
		else if wantPort.event != nil && wantPort.event.name != wantPort.requirement.name {
			wantPort.enable()
			wantPort.label.update("Refused",color:red)
			givePort.disable()
			isTradeAccepted = false
		}
		else{
			wantPort.enable()
			wantPort.label.update("Empty",color:red)
			givePort.disable()
			isTradeAccepted = false
		}
		
		if givePort.event == nil {
			self.onComplete()
		}
	}

	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconTrade : Icon
{
	override init()
	{
		super.init()
		
		mesh.addChildNode(SCNLine(vertices: [SCNVector3(x:0,y:size,z:0),  SCNVector3(x:size,y:0,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:-size,y:0,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:0,y:-size,z:0)],color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
class StructureTrade : Structure
{
	let nodes:Int = 24
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let value1:Float = 3
		let value2:Float = 5
		
		var i = 0
		while i < nodes {
			
			let node = Empty()
			
			node.addChildNode(SCNLine(vertices: [SCNVector3(-value2,value1 * Float(i),0), SCNVector3(0,value1 * Float(i),value2), SCNVector3(0,value1 * Float(i),value2), SCNVector3(value2,value1 * Float(i),0), SCNVector3(value2,value1 * Float(i),0), SCNVector3(0,value1 * Float(i) + 2,-value2), SCNVector3(0,value1 * Float(i) + 2,-value2), SCNVector3(-value2,value1 * Float(i),0)], color: red))
			
			root.addChildNode(node)
			i += 1
		}
	}
	
	override func onSight()
	{
		super.onSight()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		var i = 0
		for node in root.childNodes	{
			node.eulerAngles.y = (degToRad(Float(i * (360/nodes))))
			i += 1
		}
		
		SCNTransaction.commit()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		var i = 0
		for node in root.childNodes	{
			node.eulerAngles.y = (degToRad(Float(i * (360/nodes))))
			i += 1
		}
		
		SCNTransaction.commit()
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.y = 0
		}
		
		SCNTransaction.commit()
	}
	
	override func onComplete()
	{
		super.onComplete()
	}
	
	override func sightUpdate()
	{
		root.eulerAngles.y += (degToRad(0.1))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}