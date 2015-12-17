import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationStation : Location
{
	init(name:String, system:Systems, at: CGPoint = CGPoint(), color:UIColor = red)
	{
		super.init(name:name, at:at)
		
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
		
		let requirementLabel = SCNLabel(text:"Requirement")
		requirementLabel.position = SCNVector3(templates.leftMargin,templates.topMargin-0.3,0)
		newPanel.addChildNode(requirementLabel)
		
		let nameLabel = SCNLabel(text:"credits", color:red, align:alignment.right)
		nameLabel.position = SCNVector3(templates.rightMargin,templates.topMargin-0.3,0)
		newPanel.addChildNode(nameLabel)
		
		let button = SCNButton(host: self, text: "test", operation:0)
		newPanel.addChildNode(button)
		
		return newPanel
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