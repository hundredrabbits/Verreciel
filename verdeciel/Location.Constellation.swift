
//  Created by Devine Lu Linvega on 2016-02-17.
//  Copyright © 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationConstellation : Location
{
	init(name:String = "", system:Systems, at:CGPoint = CGPoint(x: 0,y: 0), structure:Structure, isTargetable:Bool = false)
	{
		super.init(name:name, system:system, at:at, icon:IconConstellation(), structure:structure)
		
		self.isTargetable = false
	}
	
	override func onApproach()
	{
		super.onApproach()

		space.startInstance(self)
		update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconConstellation : Icon
{
	override init()
	{
		super.init()
		size = 0.02
		mesh.addChildNode(SCNLine(vertices: [SCNVector3(x:0,y:size,z:0),  SCNVector3(x:size,y:0,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:0,y:-size,z:0),  SCNVector3(x:-size,y:0,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:0,y:size,z:0)],color: color))
		label.hide()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class StructureTunnel : Structure
{
	override init()
	{
		super.init()
		
		let hex1 = ShapeHexa(size: 6, color: grey)
		hex1.position = SCNVector3(0,0,2)
		root.addChildNode(hex1)
		let hex2 = ShapeHexa(size: 6, color: grey)
		hex2.position = SCNVector3(0,0,0)
		root.addChildNode(hex2)
		let hex3 = ShapeHexa(size: 6, color: grey)
		hex3.position = SCNVector3(0,0,-2)
		root.addChildNode(hex3)
		let hex4 = ShapeHexa(size: 6, color: grey)
		hex4.position = SCNVector3(0,0,4)
		root.addChildNode(hex4)
		let hex5 = ShapeHexa(size: 6, color: grey)
		hex5.position = SCNVector3(0,0,-4)
		root.addChildNode(hex5)
		
		root.eulerAngles.x = degToRad(90)
		root.eulerAngles.y = degToRad(90)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class StructureDoor : Structure
{
	override init()
	{
		super.init()
		
		root.addChildNode(ShapeDiamond(size: 5, color:grey))
		root.addChildNode(ShapeDiamond(size: 3, color:grey))
		root.addChildNode(ShapeDiamond(size: 1, color:grey))
	}
	
	override func sightUpdate()
	{
		super.sightUpdate()
		
		root.eulerAngles.y += 0.001
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
