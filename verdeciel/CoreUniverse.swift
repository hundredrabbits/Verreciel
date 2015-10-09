//
//  CoreUniverse.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-18.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreUniverse : SCNNode
{
	var falvetToSenni = eventPath()
	var falvetToValen = eventPath()
	var falvetToUsul = eventPath()
	var falvetToLoiqe = eventPath()
	
	var valenToVenic = eventPath()
	
	var entryToSenni = eventStation()
	var entryToValen = eventStation()
	var entryToUsul = eventStation()
	var entryToVenic = eventStation()
	var entryToLoiqe:Location!
	
	override init()
	{
		super.init()
		
		print("@ UNIVERSE | Init")
	
		// Starting zone
		falvetSystem(CGPoint(x: 0,y: 0))
		senniSystem(CGPoint(x: 0,y: 4))
		valenSystem(CGPoint(x: 4,y: 0))
		usulSystem(CGPoint(x: -4,y: 0))
		
		venicSystem(CGPoint(x: 4,y: -4))
		loiqeSystem(CGPoint(x: 0,y: -4))
		
		connectPaths()
	}
	
	func falvetSystem(offset:CGPoint)
	{
		self.addChildNode(locations.falvet(CGPoint(x:offset.x,y:offset.y)))
		
		falvetToUsul = eventPath(name:"landing",at: CGPoint(x:offset.x - 1.5,y:offset.y))
		falvetToSenni = eventPath(name:"landing",at: CGPoint(x:offset.x,y:offset.y + 1.5))
		falvetToValen = eventPath(name:"landing",at: CGPoint(x:offset.x + 1.5,y:offset.y))
		falvetToLoiqe = eventPath(name:"landing",at: CGPoint(x:offset.x,y:offset.y - 1.5))
		
		let city = locations.falvetCity(CGPoint(x:offset.x - 1,y:offset.y + 1))
		
		self.addChildNode(city)
		let city6 = eventStation(name:"landing",at: CGPoint(x:offset.x + 1,y:offset.y + 1), size: 0.5)
		let city7 = eventStation(name:"landing",at: CGPoint(x:offset.x + 1,y:offset.y - 1), size: 0.5)
		let city8 = eventStation(name:"landing",at: CGPoint(x:offset.x - 1,y:offset.y - 1), size: 0.5)
		
		self.addChildNode(falvetToUsul)
		self.addChildNode(falvetToSenni)
		self.addChildNode(falvetToValen)
		self.addChildNode(falvetToLoiqe)
		
		self.addChildNode(city)
		self.addChildNode(city6)
		self.addChildNode(city7)
		self.addChildNode(city8)
		
		city.connect(falvetToSenni)
		city6.connect(falvetToValen)
		city7.connect(falvetToLoiqe)
		city8.connect(falvetToUsul)
		
	}
	
	func loiqeSystem(offset:CGPoint)
	{
		let star = LocationStar(name:"loiqe",at: CGPoint(x:offset.x,y:offset.y))
		self.addChildNode(star)
		
		entryToLoiqe = locations.loiqeRepair(CGPoint(x:offset.x,y:offset.y + 1))
		self.addChildNode(entryToLoiqe)
		
		let loiqeBeacon = locations.loiqeBeacon(CGPoint(x:offset.x - 1,y:offset.y + 1))
		self.addChildNode(loiqeBeacon)
		
		let loiqeCity = locations.loiqeCity(CGPoint(x:offset.x - 1,y:offset.y))
		loiqeCity.connect(entryToLoiqe)
		self.addChildNode(loiqeCity)
	}
	
	func venicSystem(offset:CGPoint)
	{
		let star = LocationStar(name:"venic",at: CGPoint(x:offset.x,y:offset.y))
		
		entryToVenic = eventStation(name:"Repair",at: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		
		let portal = eventPortal(name: "Portal", at: CGPoint(x:offset.x - 1,y:offset.y), destination:CGPoint(x:offset.x,y:offset.y))
		
		
		portal.connect(entryToVenic)
		
		self.addChildNode(entryToVenic)
		self.addChildNode(star)
		self.addChildNode(portal)
	}
	
	func usulSystem(offset:CGPoint)
	{
		let star = LocationStar(name:"Usul",at: CGPoint(x:offset.x,y:offset.y))
		
		entryToUsul = eventStation(name:"Repair",at: CGPoint(x:offset.x + 1,y:offset.y), size: 0.5)
		
		let portal = eventPortal(name: "Portal", at: CGPoint(x:offset.x,y:offset.y - 1), destination:CGPoint(x:offset.x,y:offset.y))
		
		self.addChildNode(entryToUsul)
		self.addChildNode(star)
		self.addChildNode(portal)
	}
	
	func valenSystem(offset:CGPoint)
	{
		let star = LocationStar(name:"valen",at: CGPoint(x:offset.x,y:offset.y))
		
		entryToValen = eventStation(name:"Repair",at: CGPoint(x:offset.x - 1,y:offset.y), size: 0.5)
		valenToVenic = eventPath(name:"landing",at: CGPoint(x:offset.x,y:offset.y - 1))
		
		let city2 = eventStation(name:"landing",at: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		
		city2.connect(entryToValen)
		
		self.addChildNode(entryToValen)
		self.addChildNode(star)
		self.addChildNode(valenToVenic)
		self.addChildNode(city2)
	}

	func senniSystem(offset:CGPoint)
	{
		let star = LocationStar(name:"Senni",at: CGPoint(x:offset.x,y:offset.y))
		let landing = eventStation(name:"landing",at: CGPoint(x:offset.x - 1,y:offset.y), size: 0.5)
		let repair = eventStation(name:"Repair",at: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		let portal = eventPortal(name: "Portal", at: CGPoint(x:offset.x + 1,y:offset.y), destination:CGPoint(x:offset.x,y:offset.y))
		let cargo2 = eventCargo(name: "cargo", at: CGPoint(x:offset.x + 1.5,y:offset.y))
		let gate = eventPortal(name: "Portal", at: CGPoint(x:offset.x,y:offset.y + 2), destination:CGPoint(x:offset.x,y:offset.y), sector: sectors.cyanine)
		
		
		entryToSenni = eventStation(name: "cargo", at: CGPoint(x:offset.x,y:offset.y - 1), size:1)
		
		landing.connect(repair)
		repair.connect(portal)
		portal.connect(entryToSenni)
		entryToSenni.connect(landing)
		cargo2.connect(portal)
		
		gate.connect(repair)
		
		self.addChildNode(star)
		self.addChildNode(landing)
		self.addChildNode(repair)
		self.addChildNode(portal)
		self.addChildNode(cargo2)
		
		self.addChildNode(gate)
	}
	
	func connectPaths()
	{
		falvetToSenni.connect(entryToSenni)
		falvetToValen.connect(entryToValen)
		falvetToUsul.connect(entryToUsul)
		valenToVenic.connect(entryToVenic)
		falvetToLoiqe.connect(entryToLoiqe)
	}
	
	override func update()
	{
		for newEvent in self.childNodes {
			newEvent.update()
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}