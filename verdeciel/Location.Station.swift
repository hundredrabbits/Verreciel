import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStation : Location
{
	var requirement:Item!
	var installation:() -> Void
	var installationName:String!
	var port:SCNPortSlot!
	var button:SCNButton!
	
	init(name:String, system:Systems, at: CGPoint = CGPoint(), requirement:Item! = nil, installation:() -> Void, installationName:String)
	{
		self.installation = installation
		self.requirement = requirement
		self.installationName = installationName
		
		super.init(name:name,system:system, at:at)
		
		self.name = name
		self.type = .station
		self.system = system
		self.at = at
		self.note = ""
		self.structure = structures.placeholder()
		self.icon.replace(icons.station())
		self.isComplete = false
	}
	
	override func update()
	{
		updateIcon()
	}
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let requirementLabel = SCNLabel(text:"Exchange \(requirement.name!)$install the \(installationName).")
		requirementLabel.position = SCNVector3(templates.leftMargin,templates.topMargin-0.3,0)
		newPanel.addChildNode(requirementLabel)
		
		button = SCNButton(host: self, text: "install", operation:1)
		button.position = SCNVector3(0,-1,0)
		newPanel.addChildNode(button)
		
		port = SCNPortSlot(host: self, input: Event.self, output: Event.self)
		port.position = SCNVector3(0,-0.2,0)
		newPanel.addChildNode(port)
		
		let nameLabel = SCNLabel(text:"trade", color:red, align:alignment.right)
		nameLabel.position = SCNVector3(-0.3,0,0)
		port.addChildNode(nameLabel)
		
		button.disable("install")
		port.enable()
		
		return newPanel
	}
	
	override func onUploadComplete()
	{
		let trade = port.event as! Item
		if trade.name == self.requirement.name && trade.type == self.requirement.type { button.enable("install") }
	}
	
	override func touch(id: Int)
	{
		super.touch(id)
		if id == 1 { self.installation() ; mission.complete() }
	}
	
	override func complete()
	{
		super.complete()
		structure.empty()
		structure.add(structures.station(cyan))
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}