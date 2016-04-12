import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationSpawn : Location
{
	override init(name:String = "",system:Systems,at: CGPoint = CGPoint())
	{
		super.init(name: name,system:system, at: at)
		
		self.note = ""
		structure = Structure()
		icon = IconSpawn()
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
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}