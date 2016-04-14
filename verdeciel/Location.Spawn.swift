import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationSpawn : Location
{
	init(name:String = "",system:Systems,at: CGPoint = CGPoint())
	{
		super.init(name: name,system:system, at: at, icon:IconSpawn(), structure:Structure())
	}

	override func panel() -> Panel!
	{
		return nil
	}

	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconSpawn : Icon
{
	override init()
	{
		super.init()
		
		mesh.addChildNode(SCNLine(positions: [SCNVector3(x:-size/2,y:size/2,z:0),  SCNVector3(x:size/2,y:size/2,z:0), SCNVector3(x:-size/2,y:-size/2,z:0),  SCNVector3(x:size/2,y:-size/2,z:0)],color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}