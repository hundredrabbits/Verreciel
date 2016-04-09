import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStar : Location
{
	var button:SCNButton!
	var masterPort:SCNPort!
	
	init(name:String, system:Systems, at: CGPoint = CGPoint(), color:UIColor = red)
	{
		super.init(name:name,system:system, at:at)
		
		self.note = ""
		self.color = color
		self.structure = structures.star()
		self.isComplete = false
		icon.replace(icons.star())
		label.update(name)
		
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
		if masterPort.isReceiving(items.masterKey) == true {
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
	
	override func complete()
	{
		super.complete()
		structure.empty()
		structure.add(structures.star(cyan))
	}
	
	override func touch(id: Int)
	{
		super.touch(id)
		if id == 1 { extinguish() }
	}
	
	func extinguish()
	{
		print("? STAR     | Extinguished \(name)!")
		isComplete = true
	}
	
	override func onDisconnect()
	{
	}
	
	override func details() -> String
	{
		if isComplete == true {
			return "active"
		}
		return "frozen"
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}