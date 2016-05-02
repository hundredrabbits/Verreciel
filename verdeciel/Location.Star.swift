import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStar : Location
{
	var button:SCNButton!
	var masterPort:SCNPort!
	
	init(name:String, system:Systems, at: CGPoint = CGPoint())
	{
		super.init(name:name,system:system, at:at, icon:IconStar(), structure:StructureStar())
				
		self.isComplete = false
		
		self.isComplete = false
		masterPort = SCNPort(host: self)
	}
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let requirementLabel = SCNLabel(text:"Valen's melting core$welcomes you.$")
		requirementLabel.position = SCNVector3(templates.leftMargin,templates.topMargin-0.3,0)
		newPanel.addChildNode(requirementLabel)
		
		button = SCNButton(host: self, text: "install", operation:1, width:1)
		button.position = SCNVector3(0,-1,0)
		newPanel.addChildNode(button)
		
		masterPort.position = SCNVector3(-0,-0.3,0)
		
		masterPort.enable()
		
		newPanel.addChildNode(masterPort)
		
		button.disable("extinguish")
		
		return newPanel
	}
	
	override func onConnect()
	{
		if masterPort.isReceiving(items.endKey) == true {
			button.enable("extinguish")
		}
	}
	
	override func sightUpdate()
	{
		let radiation = (1 - (distance/0.7))/0.6
		
		if capsule.hasShield() == false {
			if radiation > 1 && capsule.isFleeing == false {
				capsule.flee()
			}
			capsule.radiation = radiation
		}
	}
	
	override func onApproach()
	{
		if capsule.hasShield() == true {
			super.onApproach()
		}
		else{
			space.startInstance(self)
		}
	}
	
	override func touch(id: Int)
	{
		super.touch(id)
		if id == 1 { extinguish() }
	}
	
	func extinguish()
	{
		print("? STAR     | Extinguished \(name)!")
		onComplete()
	}
	
	override func onDisconnect()
	{
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconStar : Icon
{
	override init()
	{
		super.init()
		
		mesh.addChildNode(SCNLine(vertices: [SCNVector3(x:0,y:size,z:0),  SCNVector3(x:size,y:0,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:-size,y:0,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:size * 2,y:0,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:-size * 2,y:0,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:0,y:size * 2,z:0), SCNVector3(x:0,y:-size,z:0),  SCNVector3(x:0,y:-size * 2,z:0), SCNVector3(x:size/2,y:size/2,z:0),  SCNVector3(x:size,y:size,z:0), SCNVector3(x:-size/2,y:size/2,z:0),  SCNVector3(x:-size,y:size,z:0), SCNVector3(x:size/2,y:-size/2,z:0),  SCNVector3(x:size,y:-size,z:0), SCNVector3(x:-size/2,y:-size/2,z:0),  SCNVector3(x:-size,y:-size,z:0)],color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class StructureStar : Structure
{
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		var i:Float = 0
		while i < 20 {
			let shape = ShapeOctogon(size: CGFloat(i * 0.3),color:red)
			shape.eulerAngles.y = degToRad(22.5)
			root.addChildNode(shape)
			i += 1
		}
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		var i:Float = 0
		for node in root.childNodes {
			node.eulerAngles.y = degToRad(i * (90/Float(root.childNodes.count)))
			i += 1
		}
		
		SCNTransaction.commit()
	}
	
	override func sightUpdate()
	{
		super.sightUpdate()
		
		root.eulerAngles.y += (degToRad(0.1))
	}
	
	override func onUndock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes {
			node.position.y = 0
			node.eulerAngles.y = 0
		}
		
		SCNTransaction.commit()
	}
	
	override func onComplete()
	{
		super.onComplete()
		
		root.updateChildrenColors(cyan)
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		var i:Float = 0
		for node in root.childNodes {
			node.position.y = -i * 0.05
			i += 1
			node.eulerAngles.y = 0
		}
		
		SCNTransaction.commit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}