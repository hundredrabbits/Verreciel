import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationSpawn : Location
{
	override init(name:String = "",system:Systems,at: CGPoint = CGPoint())
	{
		super.init(name: name,system:system, at: at)
		
		self.name = name
		self.type = .spawn
		self.system = system
		self.at = at
		self.note = ""
		self.structure = structures.none()
		self.icon.replace(icons.spawn())
		self.isComplete = true
	}

	override func panel() -> Panel!
	{
		return nil
	}
	
	override func listen(event: Event)
	{
		
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