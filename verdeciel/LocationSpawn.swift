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
		self.icon = icons.placeholder
		
		self.interaction = "respawning"
		
		self.interface = panel()
	}
	
	override func collide()
	{
		
	}
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()
		return newPanel
	}
	
	override func listen(event: Event)
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}