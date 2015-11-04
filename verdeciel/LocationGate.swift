import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationGate : Location
{
	var wantPort:SCNPort!
	var wantLabel:SCNLabel!
	var isLocked:Bool = false
	
	init(name:String = "",at: CGPoint = CGPoint(), want:Event)
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		self.mesh = structures.gate
		icon.replace(icons.placeholder())
		
		wantPort = SCNPort(host: self)
		wantPort.addRequirement(want)
		wantLabel = SCNLabel(text: want.name!, color:white)
		
		self.interaction = "trading"

		self.interface = panel()
	}
	
	override func animateMesh(mesh:SCNNode)
	{
		mesh.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.25)))
	}
	
	// MARK: Panels -
	
	override func update()
	{
		wantLabel.update("--", color:grey)
		wantPort.disable()
	}
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()

		wantPort.position = SCNVector3(x: -1.5, y: 0.3, z: 0)
		newPanel.addChildNode(wantPort)
		
		wantLabel.position = SCNVector3(x: -1.5 + 0.3, y: 0.3, z: 0)
		newPanel.addChildNode(wantLabel)
		
		return newPanel
	}
	
	override func listen(event: Event)
	{
		if wantPort.origin == nil { return }
		update()
	}
	
	override func bang()
	{
		print("gate test")
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}