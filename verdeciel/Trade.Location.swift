import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationTrade : Location
{
	var wantPort:SCNPortSlot!
	var givePort:SCNPortSlot!
	
	var unlocked:Bool = false
	
	init(name:String = "",at: CGPoint = CGPoint(), system:Systems, want:Event,give:Event)
	{
		super.init(name: name,system:system, at: at)
		
		self.name = name
		self.type = .trade
		self.system = system
		self.at = at
		self.note = ""
		self.mesh = structures.trade()
		self.isComplete = false
		
		icon.replace(icons.unseen())
		
		wantPort = SCNPortSlot(host: self, input:Item.self, output: Item.self, placeholder:"\(want.name!)")
		wantPort.addRequirement(want)
		givePort = SCNPortSlot(host: self, input:Item.self, output: Item.self)
		givePort.addEvent(give)
	}
	
	// MARK: Panels -
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		// Want
		
		wantPort.position = SCNVector3(x: -1.5, y: 0.3, z: 0)
		wantPort.enable()
		wantPort.input = Item.self
		newPanel.addChildNode(wantPort)
		
		let tradeLabel = SCNLabel(text: "Give", color:white)
		tradeLabel.position = SCNVector3(x: 0.3, y: 0.4, z: 0)
		wantPort.addChildNode(tradeLabel)
		
		// Give
		let forLabel = SCNLabel(text: "Take", color:white)
		forLabel.position = SCNVector3(x: 0.3, y: 0.4, z: 0)
		givePort.addChildNode(forLabel)
		
		givePort.position = SCNVector3(x:-1.5, y: -0.7, z: 0)
		newPanel.addChildNode(givePort)
		
		givePort.disable()
		
		return newPanel
	}
	
	override func onDock()
	{
		mission.refresh()
	}
	
	override func onUploadComplete()
	{
		refresh()
	}
	
	override func onDisconnect()
	{
		refresh()
	}
	
	func refresh()
	{
		if wantPort.event != nil && wantPort.event == wantPort.requirement {
			givePort.enable()
		}
		else{
			givePort.disable()
		}
		
		if givePort.event == nil {
			mission.complete()
		}
		
		updateIcon()
	}
	
	override func onComplete()
	{
		super.onComplete()
		updateIcon()
	}
	
	// MARK: Mesh -
	
	override func animateMesh(mesh:SCNNode)
	{
		mesh.eulerAngles.y = Float(degToRad(CGFloat(time.elapsed * 0.1)))
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}