import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationHarvest : Location
{
	var grows:Item!
	var port:SCNPortSlot!
	
	init(name:String = "",system:Systems,at:CGPoint = CGPoint(x: 0,y: 0), grows:Item, mapRequirement:Item! = nil)
	{
		super.init(name:name, system:system, at:at, icon:IconHarvest(), structure:StructureHarvest())
		
		self.mapRequirement = mapRequirement
		
		self.grows = grows
		
		self.details = "grows \(self.grows.name!)"
		
		port = SCNPortSlot(host: self, hasDetails:true, align:.center)
		port.enable()
		
		generationTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.generate), userInfo: nil, repeats: true)
	}
	
	override func whenStart()
	{
		super.whenStart()
		port.addEvent(grows)
	}
	
	var generationTimer:NSTimer!
	var generationCountdown:Int = 0
	var generationRate:Int = 20
	
	func generate()
	{
		if port == nil { return }
		if timeLeftLabel == nil { return }
		
		progressRadial.update((Float(generationCountdown)/Float(generationRate)) * 100)
		
		if generationCountdown < generationRate && port.hasEvent(grows) == false {
			generationCountdown += 1
		}
		else {
			refresh()
			generationCountdown = 0
			port.addEvent(grows)
			structure.update()
		}
		
		if port.hasEvent(grows) == true {
			timeLeftLabel.update("DONE")
		}
		else{
			timeLeftLabel.update("\(generationRate-generationCountdown)")
		}
	}
	
	var timeLeftLabel:SCNLabel!
	var progressRadial:SCNProgressRadial!
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		timeLeftLabel = SCNLabel(text: "\(self.grows.name!) production$Time Left 543", scale:0.2, align:.center)
		timeLeftLabel.position = SCNVector3(0,0.5,0)
		newPanel.addChildNode(timeLeftLabel)
		
		progressRadial = SCNProgressRadial(size:1.2, linesCount:52, color:cyan)
		newPanel.addChildNode(progressRadial)
		
		newPanel.addChildNode(port)
		
		return newPanel
	}
	
	override func onUploadComplete()
	{
		refresh()
		structure.update()
	}

	override func refresh()
	{
		if port.hasEvent(grows) != true {
			icon.mesh.updateChildrenColors(grey)
		}
		else{
			icon.mesh.updateChildrenColors(white)
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}


class IconHarvest : Icon
{		
	override init()
	{
		super.init()
		
		mesh.addChildNode(SCNLine(vertices: [SCNVector3(x:0,y:size,z:0),  SCNVector3(x:size,y:0,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:-size,y:0,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:-size,y:0,z:0)],color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class StructureHarvest : Structure
{
	let nodes:Int = 45
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let color:UIColor = cyan
		let value1:Float = 7
		
		var i = 0
		while i < nodes {
			let node = Empty()
			node.eulerAngles.y = (degToRad(Float(i) * (360/Float(nodes))))
			node.addChildNode(SCNLine(vertices: [SCNVector3(0,0,value1), SCNVector3(0,5,value1), SCNVector3(0,5,value1), SCNVector3(0.5,5.5,value1), SCNVector3(0,5,value1), SCNVector3(-0.5,5.5,value1)], color: color))
			root.addChildNode(node)
			i += 1
		}
	}
	
	override func update()
	{
		super.update()
		
		if (host as! LocationHarvest).port.hasEvent() != true {
			root.updateChildrenColors(grey)
		}
		else{
			root.updateChildrenColors(cyan)
		}
	}
	
	override func sightUpdate()
	{
		root.eulerAngles.y += (degToRad(0.1))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}