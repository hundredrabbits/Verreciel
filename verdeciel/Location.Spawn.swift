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
		structure = StructureDefault()
		self.icon.replace(icons.none())
	}

	override func panel() -> Panel!
	{
		return nil
	}
	
	// MARK: Triggers -
	
	override func onSight()
	{
		icon.replace(icons.spawn())
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}