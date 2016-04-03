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
		super.init(name:name, system:system, at:at)
		
		self.mapRequirement = mapRequirement
		self.note = ""
		self.structure = structures.harvest()
		icon.replace(icons.harvest())
		
		self.grows = grows
		
		port = SCNPortSlot(host: self, input:Item.self, output:Item.self, hasDetails:true, align:.center)
		port.position = SCNVector3(0,-0.5,0)
		port.enable()
		
		generationTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.generate), userInfo: nil, repeats: true)
	}
	
	override func start()
	{
		super.start()
		port.addEvent(grows)
	}
	
	var generationTimer:NSTimer!
	var generationCountdown:Int = 0
	var generationRate:Int = 20
	
	func generate()
	{
		if port == nil { return }
		if panelLabel == nil { return }
		
		if progress != nil {
			progress.update(((CGFloat(generationCountdown)/CGFloat(generationRate)) * 100))
		}
		
		if generationCountdown < generationRate && port.hasEvent(grows) == false {
			generationCountdown += 1
			
		}
		else {
			refresh()
			generationCountdown = 0
			port.addEvent(grows)
		}
		
		if port.hasEvent(grows) == true {
			panelLabel.update("\(self.grows.name!) production$Ready")
		}
		else{
			panelLabel.update("\(self.grows.name!) production$Time Left \(generationRate-generationCountdown)")
		}
	}
	
	var progress:SCNProgressBar!
	var panelLabel:SCNLabel!
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		panelLabel = SCNLabel(text: "\(self.grows.name!) production$Time Left 543", align:.left)
		panelLabel.position = SCNVector3(-1.5,1,0)
		newPanel.addChildNode(panelLabel)
		
		progress = SCNProgressBar(width: 3, color: cyan)
		progress.position = SCNVector3(-1.5,0,0)
		progress.update(30)
		
		newPanel.addChildNode(progress)
		newPanel.addChildNode(port)
		
		return newPanel
	}
	
	override func onUploadComplete()
	{
		refresh()
	}

	override func refresh()
	{
		if port.hasEvent(grows) != true {
			structure.updateChildrenColors(grey)
			icon.updateChildrenColors(grey)
		}
		else{
			structure.updateChildrenColors(cyan)
			icon.updateChildrenColors(white)
		}
	}

	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		
		for mesh in structure.childNodes {
			mesh.eulerAngles.x = Float(degToRad(10))
		}
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		refresh()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		
		for mesh in structure.childNodes {
			mesh.eulerAngles.x = Float(degToRad(0))
		}
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		refresh()
	}
	
	// MARK: Mesh -
	
	override func animateMesh()
	{
		super.animateMesh()
		
		if port.hasEvent(grows) == false {
			structure.eulerAngles.y += Float(degToRad(0.15))
		}
		else{
			structure.eulerAngles.y += Float(degToRad(0.1))
		}
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}