import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationClose : Location
{
	init(name:String, system:Systems, at: CGPoint, mapRequirement:Item! = nil)
	{
		super.init(name:name,system:system, at:at, icon:IconClose(), structure:StructureClose())
		
		self.isComplete = false
		self.mapRequirement = mapRequirement
	}
	
	override func onApproach()
	{
		if mapRequirement != nil && map.port.hasEvent(mapRequirement) == false { return }
		if universe.loiqe.isComplete != true || universe.valen.isComplete != true || universe.senni.isComplete != true || universe.usul.isComplete != true { return }
		
		space.startInstance(self)
		// Don't try to dock if there is already a target
		if radar.port.hasEvent() == true && radar.port.event == self || capsule.isFleeing == true {
			capsule.dock(self)
		}
		else if radar.port.hasEvent() == false {
			capsule.dock(self)
		}
		update()
	}

	
	// MARK: Panel -
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		return newPanel
	}
	
	override func onDock()
	{
		player.eject()
		onComplete()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(30)
		
		structure.opacity = 0
		
		SCNTransaction.commit()
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconClose : Icon
{
	override init()
	{
		super.init()
		
		label.hide()
		
		size = 0.05
		mesh.addChildNode(SCNLine(vertices: [SCNVector3(x:0,y:size,z:0),  SCNVector3(x:size,y:0,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:-size,y:0,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0)],color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class StructureClose : Structure
{
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let count:Float = 8
		var i:Float = 0
		while i < count {
			let pivot = Empty()
			pivot.eulerAngles.y = degToRad(i * Float(360/count))
			root.addChildNode(pivot)
			let shape = ShapeHexagon(size: 2, color:grey)
			shape.position.z = 3
			pivot.addChildNode(shape)
			i += 1
		}
	}
	
	override func morph()
	{
		super.morph()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(1.0)
		
		root.eulerAngles.y = degToRad(Float(morphTime) * 45)
		
		for node in root.childNodes {
			node.childNodes.first!.eulerAngles.z = degToRad(Float(morphTime) * 180)
			node.childNodes.first!.eulerAngles.x = degToRad(Float(morphTime) * (90))
			node.childNodes.first!.eulerAngles.y = degToRad(Float(morphTime) * (45))
		}
		
		SCNTransaction.commit()
	}
	
	override func onComplete()
	{
	
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}