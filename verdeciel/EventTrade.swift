import UIKit
import QuartzCore
import SceneKit
import Foundation

class eventTrade : Event
{
	var wantPort:SCNPort!
	var wantLabel:SCNLabel!
	
	var givePort:SCNPort!
	var giveLabel:SCNLabel!
	
	var want:Event!
	var give:Event!
	
	init(name:String = "",at: CGPoint = CGPoint(), want:Event,give:Event)
	{
		super.init(newName:name, at:at, type:eventTypes.station)
		
		self.at = at
		self.size = size
		self.note = ""
		
		self.want = want
		self.give = give
		
		self.addChildNode(sprite)
		self.addChildNode(trigger)
		self.addChildNode(trigger)
		
		self.interface = panel()
	}
	
	override func createSprite() -> SCNNode
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
		let radius:Float = 4
		let distance:Float = 4
		
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(-radius,distance,0), nodeB: SCNVector3(0,distance,radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,distance,radius), nodeB: SCNVector3(radius,distance,0), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(radius,distance,0), nodeB: SCNVector3(0,distance,-radius), color: white))
		mesh.addChildNode(SCNLine(nodeA: SCNVector3(0,distance,-radius), nodeB: SCNVector3(-radius,distance,0), color: white))
		
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
		
		return newPanel
	}
	
	override func listen(event: Event)
	{
		if event == want {
			wantLabel.updateColor(white)
			giveLabel.updateColor(white)
			custom.undockButtonLabel.opacity = 1
		}
		else{
			wantLabel.updateColor(grey)
		}
		print(event.name!)
	}
	
	override func bang(param: Bool)
	{
		wantLabel.update("--")
		giveLabel.update("--")
		
		givePort.connection.host.listen(give)
		givePort.disconnect()
	}
	
	override func collide()
	{
		capsule.dock(self)
	}
	
	override func sight()
	{
		updateSprite()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}