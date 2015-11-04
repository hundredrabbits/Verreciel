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
	
	init(name:String = "",at: CGPoint = CGPoint(), want:Event,give:Event)
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		self.mesh = structures.trade
		
		icon.replace(icons.placeholder())
		
		wantPort = SCNPort(host: self)
		wantPort.event = want
		givePort = SCNPort(host: self)
		givePort.event = give
		
		self.interaction = "trading"
		
		self.interface = panel()
	}
	
	// MARK: Panels -
	
	override func panel() -> SCNNode
	{
		let newPanel = SCNNode()
		
		// Want
		let tradeWantLabel = SCNLabel(text: "Trade", color:grey)
		tradeWantLabel.position = SCNVector3(x: -1.5 + 0.3, y: 0.6, z: 0)
		newPanel.addChildNode(tradeWantLabel)
		
		wantPort.position = SCNVector3(x: -1.5, y: 0.3, z: 0)
		wantPort.addRequirement(wantPort.event)
		wantPort.enable()
		wantPort.input = eventTypes.item
		newPanel.addChildNode(wantPort)
		
		wantLabel = SCNLabel(text: wantPort.event.name!, color:white)
		wantLabel.position = SCNVector3(x: -1.5 + 0.3, y: 0.3, z: 0)
		wantPort.output = eventTypes.item
		newPanel.addChildNode(wantLabel)
		
		// Give
		let tradeGiveLabel = SCNLabel(text: "for", color:grey)
		tradeGiveLabel.position = SCNVector3(x: -1.5 + 0.3, y: -0.2, z: 0)
		newPanel.addChildNode(tradeGiveLabel)
		
		givePort.position = SCNVector3(x: -1.5, y: -0.5, z: 0)
		newPanel.addChildNode(givePort)
		
		giveLabel = SCNLabel(text: givePort.event.name!, color:grey)
		giveLabel.position = SCNVector3(x: -1.5 + 0.3, y: -0.5, z: 0)
		newPanel.addChildNode(giveLabel)
		
		givePort.disable()
		
		return newPanel
	}
	
	override func listen(event: Event)
	{
		if wantPort.origin == nil { return }
		update()
	}
	
	override func bang()
	{
		if givePort.connection == nil { print("No connection") ; return }
		if givePort.connection.host != cargo { print("Not routed to cargo") ; return }
		if givePort.event == nil { completeTrade() ; return }
		
		givePort.connection.host.listen(givePort.event)
		
		update()
	}
	
	override func update()
	{
		if givePort.event == nil { isComplete = true }
		
		if isKnown == false {
			icon.replace(icons.trade(grey))
		}
		else if isComplete == true {
			icon.replace(icons.trade(cyan))
		}
		else {
			icon.replace(icons.trade(red))
		}
		
		// 
		
		if givePort.event == nil {
			wantLabel.update("--", color:grey)
			giveLabel.update("--", color:grey)
			givePort.disable()
			wantPort.disable()
			return
		}
		if wantPort.origin != nil && wantPort.origin.event == wantPort.requirement {
			wantLabel.updateColor(white)
			giveLabel.updateColor(white)
			givePort.enable()
		}
		else{
			wantLabel.updateColor(grey)
			giveLabel.updateColor(grey)
			givePort.disable()
		}
	}

	func completeTrade()
	{
		if wantPort.origin != nil { wantPort.syphon() }
		if givePort.connection != nil {	givePort.disconnect() }
		
		givePort.event = nil
		update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}