import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationPortal : Location
{
	var pilotPort:SCNPort!
	var thrusterPort:SCNPort!

	init(name:String, system:Systems, at: CGPoint)
	{
		super.init(name:name,system:system, at:at, type: .portal)
		
		pilotPort = SCNPort(host: self, input: nil, output: nil)
		thrusterPort = SCNPort(host: self, input: nil, output: nil)
		
		self.note = ""
		self.color = color
		self.structure = structures.portal()
		icon.replace(icons.portal())
	}
	
	// MARK: Panel - 
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		newPanel.addChildNode(pilotPort)
		newPanel.addChildNode(thrusterPort)
		
		thrusterPort.position = SCNVector3(0,-0.5,0)
		
		return newPanel
	}
	
	override func onConnect()
	{
		if mission.port.isReceivingItemOfType(.key) == false { return }
		if (mission.port.origin.event is Item) != true { return }
		
		let key = mission.port.origin.event as! Item
		let destination = universe.locationLike(key.location)
		
		print("! KEY      | Reading: \(key.name!) -> \(destination.name!)")
		
		pilotPort.addEvent(destination)
		pilotPort.enable()
		thrusterPort.addEvent(items.warpDrive)
		thrusterPort.enable()
	}
	
	override func animateMesh()
	{
		super.animateMesh()
		
		structure.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.1)))
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}