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
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}