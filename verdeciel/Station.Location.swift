import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStation : Location
{
	var requirement:Event!
	var installation:() -> Void
	var installationName:String!
	var port:SCNPortSlot!
	var button:SCNButton!
	
	init(name:String, system:Systems, at: CGPoint = CGPoint(), requirement:Event! = nil, installation:() -> Void, installationName:String)
	{
		self.installation = installation
		self.requirement = requirement
		self.installationName = installationName
		
		super.init(name:name,system:system, at:at)
		
		self.name = name
		self.system = system
		self.at = at
		self.note = ""
		self.mesh = structures.station()
		
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
		
		button = SCNButton(host: self, text: "install", operation:0)
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
		if port.event == self.requirement { button.enable("install") }
	}
	
	override func touch(id: Int)
	{
		if id == 0 { self.installation() }
	}
	
	// MARK: Icon -
	
	override func updateIcon()
	{
		if isSeen == false			{ icon.replace(icons.station(grey)) }
		else if isKnown == false	{ icon.replace(icons.station(white)) }
		else if isComplete == true	{ icon.replace(icons.station(cyan)) }
		else						{ icon.replace(icons.station(red)) }
	}
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}