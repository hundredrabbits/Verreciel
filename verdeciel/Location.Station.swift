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
	
	init(name:String, system:Systems, at: CGPoint = CGPoint(), requirement:Item! = nil, installation:() -> Void, installationName:String, mapRequirement:Item! = nil)
	{
		self.installation = installation
		self.requirement = requirement
		self.installationName = installationName
		
		super.init(name:name,system:system, at:at)
		
		self.mapRequirement = mapRequirement
		self.note = ""
		structure = StructureStation(host: self)
		icon = IconStation()
		self.isComplete = false
	}
	
	var tradeLabel:SCNLabel!
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		let requirementLabel = SCNLabel(text:"Exchange \(requirement.name!)$install the \(installationName).")
		requirementLabel.position = SCNVector3(templates.leftMargin,templates.topMargin-0.3,0)
		newPanel.addChildNode(requirementLabel)
		
		button = SCNButton(host: self, text: "install", operation:1)
		button.position = SCNVector3(0,-1,0)
		newPanel.addChildNode(button)
		
		port = SCNPortSlot(host: self)
		port.position = SCNVector3(0,-0.2,0)
		newPanel.addChildNode(port)
		
		tradeLabel = SCNLabel(text:"trade", color:grey, align:alignment.right)
		tradeLabel.position = SCNVector3(-0.3,0,0)
		port.addChildNode(tradeLabel)
		
		button.disable("install")
		port.enable()
		
		return newPanel
	}
	
	override func onUploadComplete()
	{
		if port.hasEvent() == false { tradeLabel.update(grey) ; return }
		
		let trade = port.event as! Item
		if trade.name == self.requirement.name && trade.type == self.requirement.type { button.enable("install") ; tradeLabel.update(cyan) }
		else{ tradeLabel.update(red) }
	}
	
	override func touch(id: Int)
	{
		super.touch(id)
		if id == 1 { self.installation() ; self.complete()  }
	}
	
	override func complete()
	{
		super.complete()
		
		structure.onComplete()
		intercom.complete()
	}
	
	override func details() -> String
	{
		return "\(installationName)"
	}
	
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconStation : Icon
{
	override init()
	{
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}


class StructureStation : Structure
{
	let nodes:Int = 4 + Int(arc4random_uniform(4))
	
	override init(host:Location)
	{
		super.init(host: host)
		
		root.position = SCNVector3(0,5,0)
		
		var i:Int = 0
		while i < nodes {
			let axis = SCNNode()
			axis.eulerAngles.y = (degToRad(CGFloat(Float(i) * Float(360/nodes))))
			
			let node = SCNHexa(size: 4, color: red)
			node.eulerAngles.x = (degToRad(90))
			let node1 = SCNHexa(size: 4, color: red)
			node1.eulerAngles.y = (degToRad(90))
			
			axis.addChildNode(node)
			node.addChildNode(node1)
			root.addChildNode(axis)
			i += 1
		}
		
		
	}
	
	override func onSight()
	{
		super.onSight()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.x = (degToRad(0))
		}
		
		SCNTransaction.commit()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.x = (degToRad(45))
		}
		
		SCNTransaction.commit()
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.x = (degToRad(45))
		}
		
		SCNTransaction.commit()
	}
	
	override func onComplete()
	{
		super.onComplete()
		
		updateChildrenColors(cyan)
	}
	
	override func sightUpdate()
	{
		root.eulerAngles.y += (degToRad(0.1))
	}
	
	override func dockUpdate()
	{
	}
	
	override func morph()
	{
		super.morph()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		let deg1 = 22.5 * (CGFloat(morphTime * 123) % 8) % 180
		let deg2 = 22.5 * (CGFloat(morphTime * 678) % 6) % 180
		
		for node in root.childNodes {
			for subnode in node.childNodes	{
				subnode.eulerAngles.z = (degToRad(deg1 - deg2))
				subnode.position.y = (2 - ((Float(morphTime) * 0.34) % 4)) * 0.6
			}
		}
		
		SCNTransaction.commit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}