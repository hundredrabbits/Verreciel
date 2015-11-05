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
		self.mesh = structures.placeholder
		self.interaction = "respawning"
		self.icon.replace(icons.none())
	}

	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()
		return newPanel
	}
	
	override func listen(event: Event)
	{
		
	}
	
	// MARK: Triggers -
	
	override func onSight()
	{
		icon.replace(icons.placeholder())
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}