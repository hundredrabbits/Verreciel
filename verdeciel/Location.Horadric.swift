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
		super.init(name: name,system:system, at: at, icon:IconHoradric(), structure:StructureHoradric())
		
		self.mapRequirement = mapRequirement
	}
	
	override func panel() -> Panel!
	{
		let newPanel = Panel()
		
		inPort1 = SCNPortSlot(host: self, align: .center, hasDetails: false, placeholder: "In")
		inPort2 = SCNPortSlot(host: self, align: .center, hasDetails: false, placeholder: "In")
		
		inPort1.label.position = SCNVector3(0,0.5,0)
		inPort2.label.position = SCNVector3(0,0.5,0)
		
		inPort1.enable()
		inPort2.enable()
		
		inPort1.position = SCNVector3(0.6,0.6,0)
		inPort2.position = SCNVector3(-0.6,0.6,0)
		
		outPort = SCNPortSlot(host: self, align: .center,placeholder: "")
		outPort.position = SCNVector3(0,-0.8,0)
		outPort.label.position = SCNVector3(0,-0.4,0)
		outPort.label.update("Out")
		
		newPanel.addChildNode(inPort1)
		newPanel.addChildNode(inPort2)
		newPanel.addChildNode(outPort)
		
		newPanel.addChildNode(SCNLine(vertices: [SCNVector3(0.6,0.6 - 0.125,0), SCNVector3(0.6,0.3 - 0.125,0)], color: grey))
		newPanel.addChildNode(SCNLine(vertices: [SCNVector3(-0.6,0.6 - 0.125,0), SCNVector3(-0.6,0.3 - 0.125,0)], color: grey))
		
		newPanel.addChildNode(SCNLine(vertices: [SCNVector3(0,-0.2 - 0.125,0), SCNVector3(0.6,0.3 - 0.125,0)], color: grey))
		newPanel.addChildNode(SCNLine(vertices: [SCNVector3(0,-0.2 - 0.125,0), SCNVector3(-0.6,0.3 - 0.125,0)], color: grey))
		
		newPanel.addChildNode(SCNLine(vertices: [SCNVector3(0,-0.2 - 0.125,0), SCNVector3(0,-0.8 + 0.125,0)], color: grey))
		
		storage = [inPort1,inPort2,outPort]
		
		return newPanel
	}
	
	override func dockUpdate()
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
			inPort1.disable()
			inPort2.disable()
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
		inPort1.label.update(grey)
		inPort2.label.update(grey)
		
		outPort.addEvent(combinationRecipe.result)
		
		self.structure.opacity = 1
		
		combinationPercentage = 0
		
		refresh()
	}
		
	// MARK: Defaults -
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class IconHoradric : Icon
{
	override init()
	{
		super.init()
		
		mesh.addChildNode(SCNLine(vertices: [SCNVector3(x:0,y:size,z:0),  SCNVector3(x:size,y:0,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:-size,y:0,z:0), SCNVector3(x:size,y:0,z:0),  SCNVector3(x:0,y:-size,z:0), SCNVector3(x:-size,y:0,z:0),  SCNVector3(x:size,y:0,z:0), SCNVector3(x:0,y:size,z:0),  SCNVector3(x:0,y:-size,z:0)],color: color))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}

class StructureHoradric : Structure
{
	let nodes:Int = Int(arc4random_uniform(10)) + 4
	let radius:CGFloat = 5
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,0,0)
		
		let cube1 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube1)
		cube1.line9.color(clear)
		cube1.line10.color(clear)
		cube1.line11.color(clear)
		cube1.line12.color(clear)
		
		let cube2 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube2)
		cube2.line9.color(clear)
		cube2.line10.color(clear)
		cube2.line11.color(clear)
		cube2.line12.color(clear)
		
		let cube3 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube3)
		cube3.line9.color(clear)
		cube3.line10.color(clear)
		cube3.line11.color(clear)
		cube3.line12.color(clear)
		
		let cube4 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube4)
		cube4.line9.color(clear)
		cube4.line10.color(clear)
		cube4.line11.color(clear)
		cube4.line12.color(clear)
		
		let cube5 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube5)
		cube5.line9.color(clear)
		cube5.line10.color(clear)
		cube5.line11.color(clear)
		cube5.line12.color(clear)
		
		let cube6 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube6)
		cube6.line9.color(clear)
		cube6.line10.color(clear)
		cube6.line11.color(clear)
		cube6.line12.color(clear)
	}
	
	override func onSight()
	{
		super.onSight()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		
		root.childNodes[0].eulerAngles.y = (degToRad(0))
		root.childNodes[1].eulerAngles.y = (degToRad(0))
		
		root.childNodes[2].eulerAngles.z = (degToRad(0))
		root.childNodes[3].eulerAngles.z = (degToRad(0))
		
		root.childNodes[4].eulerAngles.x = (degToRad(0))
		root.childNodes[5].eulerAngles.x = (degToRad(0))
		
		eulerAngles.y = (degToRad(0))
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		
		root.childNodes[0].eulerAngles.y += (degToRad(22.5))
		root.childNodes[1].eulerAngles.y -= (degToRad(22.5))
		
		root.childNodes[2].eulerAngles.z += (degToRad(45))
		root.childNodes[3].eulerAngles.z -= (degToRad(45))
		
		root.childNodes[4].eulerAngles.x += (degToRad(90))
		root.childNodes[5].eulerAngles.x -= (degToRad(90))
		
		eulerAngles.y += (degToRad(90))
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}