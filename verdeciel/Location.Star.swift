import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStar : Location
{
	var button:SCNButton!
	var portA:SCNPort!
	var portB:SCNPort!
	var twin:Location!
	
	init(name:String, system:Systems, at: CGPoint = CGPoint(), color:UIColor = red)
	{
		super.init(name:name,system:system, at:at, type: .star)
		
		self.note = ""
		self.color = color
		self.structure = structures.star()
		self.type = LocationTypes.star
		self.isComplete = false
		icon.replace(icons.star())
		label.update(name)
		
		portA = SCNPort(host: self, input: Item.self, output: Item.self)
		portB = SCNPort(host: self, input: Item.self, output: Item.self)
	}
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let requirementLabel = SCNLabel(text:"Valen's melting core$welcomes you.$")
		requirementLabel.position = SCNVector3(templates.leftMargin,templates.topMargin-0.3,0)
		newPanel.addChildNode(requirementLabel)
		
		button = SCNButton(host: self, text: "install", operation:1, width:1.5)
		button.position = SCNVector3(0,-1,0)
		newPanel.addChildNode(button)
		
		portA.position = SCNVector3(-0.5,-0.3,0)
		portB.position = SCNVector3(0.5,-0.3,0)
		
		portA.enable()
		portB.enable()
		
		portA.connect(portB)
		
		newPanel.addChildNode(portA)
		newPanel.addChildNode(portB)
		
		button.enable("extinguish the sun")
		
		return newPanel
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
	
	override func complete()
	{
		super.complete()
		structure.empty()
		structure.add(structures.star(cyan))
	}
	
	override func touch(id: Int)
	{
		super.touch(id)
		if id == 1 {  }
	}
	
	override func onDisconnect()
	{
		if portB.origin != portA {
			self.complete()
			capsule.teleport(twin)
		}
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}