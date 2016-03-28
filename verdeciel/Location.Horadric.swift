import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationHoradric : Location
{
	var inPort1:SCNPortSlot!
	var inPort2:SCNPortSlot!
	
	var outPort:SCNPortSlot!
	
	init(name:String = "", system:Systems, at: CGPoint = CGPoint(), mapRequirement:Item! = nil)
	{
		super.init(name: name,system:system, at: at, type: .horadric)
		
		self.note = ""
		self.mapRequirement = mapRequirement
		self.structure = structures.horadric()
		icon.replace(icons.horadric())
	}
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		inPort1 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align: .center, hasDetails: false, placeholder: "In")
		inPort2 = SCNPortSlot(host: self, input: Item.self, output: Item.self, align: .center, hasDetails: false, placeholder: "In")
		
		inPort1.label.position = SCNVector3(0,0.5,0)
		inPort2.label.position = SCNVector3(0,0.5,0)
		
		inPort1.enable()
		inPort2.enable()
		
		inPort1.position = SCNVector3(0.6,0.6,0)
		inPort2.position = SCNVector3(-0.6,0.6,0)
		
		outPort = SCNPortSlot(host: self, input: Item.self, output: Event.self, align: .center,placeholder: "")
		outPort.position = SCNVector3(0,-0.8,0)
		outPort.label.position = SCNVector3(0,-0.4,0)
		outPort.label.update("Out")
		
		newPanel.addChildNode(inPort1)
		newPanel.addChildNode(inPort2)
		newPanel.addChildNode(outPort)
		
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0.6,0.6 - 0.125,0), nodeB: SCNVector3(0.6,0.3 - 0.125,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(-0.6,0.6 - 0.125,0), nodeB: SCNVector3(-0.6,0.3 - 0.125,0), color: grey))
		
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,-0.2 - 0.125,0), nodeB: SCNVector3(0.6,0.3 - 0.125,0), color: grey))
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,-0.2 - 0.125,0), nodeB: SCNVector3(-0.6,0.3 - 0.125,0), color: grey))
		
		newPanel.addChildNode(SCNLine(nodeA: SCNVector3(0,-0.2 - 0.125,0), nodeB: SCNVector3(0,-0.8 + 0.125,0), color: grey))
		
		return newPanel
	}
	
	override func dockedUpdate()
	{
		if inPort1.isEnabled == true && inPort2.isEnabled == true {  }
		
		if combinationPercentage > 0 { self.structure.blink() }
	}
	
	override func onUploadComplete()
	{
		verifyRecipes()
	}
	
	var recipeValid:Recipe! = nil
	
	func verifyRecipes()
	{
		var ingredients:Array<Event> = []
		
		if inPort1.event != nil { ingredients.append(inPort1.event) }
		if inPort2.event != nil { ingredients.append(inPort2.event) }
		
		for recipe in recipes.horadric {
			if recipe.isValid(ingredients) == true {
				recipeValid = recipe
				combine(recipe)
				break
			}
			else{
				recipeValid = nil
			}
		}
		
		refresh()
	}
	
	override func refresh()
	{
		if outPort.hasEvent() == true {
			inPort1.disable()
			inPort2.disable()
			outPort.enable()
		}
		else{
			inPort1.enable()
			inPort2.enable()
			outPort.disable()
		}
		
		if recipeValid != nil {
			inPort1.label.update("IN", color: white)
			inPort2.label.update("IN", color: white)
			outPort.label.update(recipeValid.result.name!, color:cyan)
		}
		else if inPort1.event != nil && inPort2.event != nil {
			inPort1.label.update("IN", color: grey)
			inPort2.label.update("IN", color: grey)
			outPort.label.update("error", color:red)
		}
		else {
			if inPort1.event != nil { inPort1.label.update("IN", color: white) } else{ inPort1.label.update("IN", color: grey) }
			if inPort2.event != nil { inPort2.label.update("IN", color: white) } else{ inPort2.label.update("IN", color: grey) }
			outPort.label.update("Out", color:grey)
		}
	}
	
	// MARK: Combinatrix
	
	var combinationRecipe:Recipe!
	var combinationTimer:NSTimer!
	var combinationPercentage:CGFloat = 0
	
	func combine(recipe:Recipe)
	{
		inPort1.disable()
		inPort2.disable()
		inPort1.label.update(cyan)
		inPort2.label.update(cyan)
		
		combinationRecipe = recipe
		combineProgress()
	}
	
	func combineProgress()
	{
		combinationPercentage += CGFloat(arc4random_uniform(60))/30
		
		if combinationPercentage > 100 {
			onCombinationComplete()
			return
		}
		else{
			delay(0.05, block: { self.combineProgress() })
		}
		outPort.label.update("Assemblage \(Int(combinationPercentage))%", color:white)
	}
	
	func onCombinationComplete()
	{
		inPort1.removeEvent()
		inPort2.removeEvent()
		
		outPort.addEvent(combinationRecipe.result)
		
		self.structure.opacity = 1
		
		combinationPercentage = 0
		
		refresh()
	}

	func iconUpdate()
	{
		if isKnown == false {
			icon.replace(icons.trade(grey))
		}
		else {
			icon.replace(icons.trade(white))
		}
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
	
			structure.childNodes[0].eulerAngles.y += Float(degToRad(22.5))
			structure.childNodes[1].eulerAngles.y -= Float(degToRad(22.5))
			
			structure.childNodes[2].eulerAngles.z += Float(degToRad(45))
			structure.childNodes[3].eulerAngles.z -= Float(degToRad(45))
			
			structure.childNodes[4].eulerAngles.x += Float(degToRad(90))
			structure.childNodes[5].eulerAngles.x -= Float(degToRad(90))
		
			structure.eulerAngles.y += Float(degToRad(90))
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		
		structure.childNodes[0].eulerAngles.y = Float(degToRad(0))
		structure.childNodes[1].eulerAngles.y = Float(degToRad(0))
		
		structure.childNodes[2].eulerAngles.z = Float(degToRad(0))
		structure.childNodes[3].eulerAngles.z = Float(degToRad(0))
		
		structure.childNodes[4].eulerAngles.x = Float(degToRad(0))
		structure.childNodes[5].eulerAngles.x = Float(degToRad(0))
		
		structure.eulerAngles.y = Float(degToRad(0))
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
		
		retrieveItems()
	}
	
	func retrieveItems()
	{
		print("RETRIEVE ITEMS!")
	}
		
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}