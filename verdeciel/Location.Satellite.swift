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
		super.init(name:name, system:system, at:at, icon:IconSatellite(), structure:StructureSatellite())
		
		self.isComplete = false
		self.mapRequirement = mapRequirement
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
		if isComplete == true { return nil }
		
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
		if port.event == nil { self.onComplete() }
	}
	
	override func onUploadComplete()
	{
		self.onComplete()
		structure.update()
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

class IconSatellite : Icon
{
	override init()
	{
		super.init()
		
		mesh.addChildNode(SCNLine(positions: [SCNVector3(x:0,y:size,z:0),  SCNVector3(x:size,y:0,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:-size,y:0,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0)],color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class StructureSatellite : Structure
{
	let nodes:Int = Int(arc4random_uniform(2)) + 3
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		var i = 0
		while i < nodes {
			
			let axis = SCNNode()
			axis.eulerAngles.y = (degToRad(CGFloat(i * (360/nodes))))
			
			root.addChildNode(axis)
			
			let shape = SCNHexa(size: 3, color: red)
			shape.position.x = 0
			axis.addChildNode(shape)
			
			let shape2 = SCNHexa(size: 3, color: red)
			shape2.eulerAngles.z = (degToRad(90))
			shape.addChildNode(shape2)
			
			let shape3 = SCNHexa(size: 3, color: red)
			shape3.eulerAngles.y = (degToRad(90))
			shape.addChildNode(shape3)
			
			let shape4 = SCNHexa(size: 3, color: red)
			shape4.eulerAngles.x = (degToRad(90))
			shape.addChildNode(shape4)
			
			i += 1
		}
	}
	
	override func onSight()
	{
		super.onSight()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes {
			for subnode in node.childNodes {
				subnode.position.x = 3
			}
		}
		
		SCNTransaction.commit()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes {
			for subnode in node.childNodes {
				subnode.position.x = 3
			}
		}
		
		SCNTransaction.commit()
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes {
			for subnode in node.childNodes {
				subnode.position.x = 0
			}
		}
		
		SCNTransaction.commit()
	}
	
	override func onComplete()
	{
		super.onComplete()
		
		update()
	}
	
	override func sightUpdate()
	{
		root.eulerAngles.y += (degToRad(0.1))
	}
	
	override func dockUpdate()
	{
		for node in root.childNodes {
			for subnode in node.childNodes {
				subnode.eulerAngles.z += (degToRad(0.25))
			}
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}