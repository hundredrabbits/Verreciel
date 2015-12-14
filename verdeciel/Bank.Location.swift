import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationBank : Location
{
	init(name:String = "", system:Systems, at: CGPoint = CGPoint())
	{
		super.init(name: name, at:at)
		
		self.name = name
		self.system = system
		self.at = at
		self.note = ""
		self.mesh = structures.none()
		self.icon.replace(icons.bank())
		self.isComplete = true
	}
	
	override func panel() -> SCNNode!
	{
		return nil
	}
	
	override func listen(event: Event)
	{
		
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}