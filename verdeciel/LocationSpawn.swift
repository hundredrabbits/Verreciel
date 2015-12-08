import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationSpawn : Location
{
	init(name:String = "",at: CGPoint = CGPoint())
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		self.mesh = structures.none()
		self.interaction = "respawning"
		self.icon.replace(icons.spawn())
		self.isComplete = true
	}

	override func panel() -> SCNNode!
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