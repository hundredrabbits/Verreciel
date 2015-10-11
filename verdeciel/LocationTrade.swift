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
	
	var want:Event!
	var give:Event!
	
	var unlocked:Bool = false
	
	init(name:String = "",at: CGPoint = CGPoint(), want:Event,give:Event)
	{
		super.init(name: name, at: at)
		
		self.at = at
		self.size = size
		self.note = ""
		
		self.want = want
		self.give = give
		
		self.interaction = "trading"
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		
		self.interface = panel()
	}

	override func sight()
	{
		isKnown = true
		sprite.empty()
		sprite.add(_sprite())
	}
	
	override func _sprite() -> SCNNode
	{
		var size:Float = 0.1
		let spriteNode = SCNNode()
		
		if isKnown == true {
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: white))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: white))
		}
		else{
			size = 0.05
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:-size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:0,y:size,z:0),nodeB: SCNVector3(x:-size,y:0,z:0),color: grey))
			spriteNode.addChildNode(SCNLine(nodeA: SCNVector3(x:size,y:0,z:0),nodeB: SCNVector3(x:0,y:-size,z:0),color: grey))
		}
		
		return spriteNode
	}
	
	override func mesh() -> SCNNode
	{
		let mesh = SCNNode()
		
		return mesh
	}
	
	override func panel() -> Panel
	{
		let newPanel = Panel()
		
		// Want
		let tradeWantLabel = SCNLabel(text: "Trade", color:grey)
		tradeWantLabel.position = SCNVector3(x: -1.5 + 0.3, y: 0.6, z: 0)
		newPanel.addChildNode(tradeWantLabel)
		
		wantPort = SCNPort(host: self, polarity: false)
		wantPort.position = SCNVector3(x: -1.5, y: 0.3, z: 0)
		newPanel.addChildNode(wantPort)
		
		wantLabel = SCNLabel(text: want.name!, color:grey)
		wantLabel.position = SCNVector3(x: -1.5 + 0.3, y: 0.3, z: 0)
		newPanel.addChildNode(wantLabel)
		
		// Give
		let tradeGiveLabel = SCNLabel(text: "for", color:grey)
		tradeGiveLabel.position = SCNVector3(x: -1.5 + 0.3, y: -0.2, z: 0)
		newPanel.addChildNode(tradeGiveLabel)
		
		givePort = SCNPort(host: self, polarity: true)
		givePort.position = SCNVector3(x: -1.5, y: -0.5, z: 0)
		newPanel.addChildNode(givePort)
		
		giveLabel = SCNLabel(text: give.name!, color:grey)
		giveLabel.position = SCNVector3(x: -1.5 + 0.3, y: -0.5, z: 0)
		newPanel.addChildNode(giveLabel)
		
		givePort.disable()
		
		return newPanel
	}
	
	override func listen(event: Event)
	{
		if event == want {
			wantLabel.updateColor(white)
			giveLabel.updateColor(white)
			givePort.enable()
		}
		else{
			wantLabel.updateColor(grey)
			givePort.disable()
		}
	}
	
	override func bang(param: Bool)
	{
		completeTrade()
		
		custom.statusLabel.update("complete")
		custom.update()
	}

	func completeTrade()
	{
		wantLabel.update("--")
		giveLabel.update("--")
		
		let command = wantPort.origin.host as! SCNCommand
		command.event.size -= 1
		command.update()
		
		givePort.connection.host.listen(give)
		givePort.disconnect()
		
		wantPort.disable()
		givePort.disable()
		
		want = nil
		give = nil
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}