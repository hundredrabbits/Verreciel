import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationTransit : Location
{
	init(name:String, system:Systems, at: CGPoint, mapRequirement:Item! = nil)
	{
		super.init(name:name,system:system, at:at, icon:IconTransit(), structure:StructureTransit())
		
		self.mapRequirement = mapRequirement
	}
	
	// MARK: Panel -
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()

		return newPanel
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconTransit : Icon
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

class StructureTransit : Structure
{
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let count:Float = 16
		var i:Float = 0
		while i < count {
			let pivot = Empty()
			pivot.eulerAngles.y = degToRad(i * Float(360/count))
			root.addChildNode(pivot)
			let shape = ShapeHexagon(size: 3, color:white)
			shape.position.z = 5
			pivot.addChildNode(shape)
			i += 1
		}
	}
	
	override func sightUpdate()
	{
		super.sightUpdate()
		
		for pivot in root.childNodes {
			pivot.childNodes.first!.eulerAngles.z = degToRad(sin(game.time * 0.005) * 22.5)
			pivot.childNodes.first!.eulerAngles.y = degToRad(sin(game.time * 0.0075) * 45)
		}
		
		root.eulerAngles.y += (degToRad(0.1))
	}
	
	override func morph()
	{
		super.morph()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes {
			node.childNodes.first!.position.y = (2 - ((Float(morphTime) * 0.4) % 4)) * 0.8
			node.childNodes.first!.position.z = (sin(game.time * 0.1) * 2)
			node.childNodes.first!.position.x = (sin(Float(morphTime) * 0.2) * 2)
		}
		
		SCNTransaction.commit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}