import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationTrade : Location
{
	var wantPort:SCNPort!
	var wantLabel:SCNLabel!
	
	var givePort:SCNPort!
	var giveLabel:SCNLabel!
	
	var unlocked:Bool = false
	
	init(name:String = "",at: CGPoint = CGPoint(), system:Systems, want:Event,give:Event)
	{
		super.init(name: name,system:system, at: at)
		
		self.name = name
		self.system = system
		self.at = at
		self.note = ""
		self.mesh = structures.trade()
		
		icon.replace(icons.unseen())
		
		wantPort = SCNPort(host: self)
		wantPort.addRequirement(want)
		givePort = SCNPort(host: self)
		givePort.event = give
		wantLabel = SCNLabel(text: wantPort.requirement.name!, color:white)
		giveLabel = SCNLabel(text: givePort.event.name!, color:grey)
	}
	
	// MARK: Panels -
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		let spacingLeft:Float = 0.4
		
		// Want
		
		wantPort.position = SCNVector3(x: -1.5, y: 0.3, z: 0)
		wantPort.enable()
		wantPort.input = Item.self
		newPanel.addChildNode(wantPort)
		
		let tradeLabel = SCNLabel(text: "< Trade", color:grey)
		tradeLabel.position = SCNVector3(x: spacingLeft, y: spacingLeft, z: 0)
		wantPort.addChildNode(tradeLabel)
		
		wantLabel.position = SCNVector3(x: spacingLeft, y: 0, z: 0)
		wantPort.output = Item.self
		wantPort.addChildNode(wantLabel)
		
		// Give
		let forLabel = SCNLabel(text: "> For", color:grey)
		forLabel.position = SCNVector3(x: spacingLeft, y: spacingLeft, z: 0)
		givePort.addChildNode(forLabel)
		
		givePort.position = SCNVector3(x:-1.5, y: -0.7, z: 0)
		newPanel.addChildNode(givePort)
		
		giveLabel.position = SCNVector3(x: spacingLeft, y: 0, z: 0)
		givePort.addChildNode(giveLabel)
		
		givePort.disable()
		
		return newPanel
	}
	
	func panelUpdate()
	{
		if givePort.event == nil {
			wantLabel.update("--", color:grey)
			giveLabel.update("--", color:grey)
			givePort.disable()
			wantPort.disable()
		}
		else if wantPort.origin != nil && wantPort.origin.event == wantPort.requirement {
			wantLabel.update(wantPort.requirement.name!, color:cyan)
			giveLabel.update(givePort.event.name!, color:white)
			wantPort.enable()
			givePort.enable()
		}
		else{
			wantLabel.update(wantPort.requirement.name!, color:red)
			giveLabel.update(givePort.event.name!, color:grey)
			wantPort.enable()
			givePort.disable()
		}
	}
	
	// MARK: I/O -
	
	override func listen(event: Event)
	{
		if wantPort.origin == nil { return }
		update()
	}
	
	override func bang()
	{
		if givePort.connection == nil { print("No connection") ; return }
		if givePort.connection.host != cargo { print("Not routed to cargo") ; return }
		
		wantPort.addEvent(wantPort.syphon())
		givePort.connection.host.listen(givePort.event)

		update()
	}
	
	override func update()
	{
		if givePort.event == nil && isComplete == false { mission.complete() }
		panelUpdate()
		updateIcon()
	}
	
	override func updateIcon()
	{
		if isSeen == false			{ icon.replace(icons.trade(grey)) }
		else if isKnown == false	{ icon.replace(icons.trade(white)) }
		else if isComplete == true	{ icon.replace(icons.trade(cyan)) }
		else						{ icon.replace(icons.trade(red)) }
	}

	func completeTrade()
	{
		if wantPort.origin != nil { wantPort.syphon() }
		if givePort.connection != nil {	givePort.disconnect() }
		
		givePort.event = nil
		update()
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