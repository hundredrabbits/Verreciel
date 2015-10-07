import UIKit
import QuartzCore
import SceneKit
import Foundation

class Location : Event
{
	var service = services.none
	
	init(name:String,at: CGPoint, service:services = services.none)
	{
		super.init(newName:name, at:at, type:eventTypes.location)

		self.at = at
		
		self.geometry = SCNPlane(width: 0.5, height: 0.5)
		self.geometry?.firstMaterial?.diffuse.contents = clear
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
	}
	
	func addService(service:services)
	{
		self.service = service
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}