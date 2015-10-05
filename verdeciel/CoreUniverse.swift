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
	override init()
	{
		super.init()
		
		print("@ UNIVERSE | Init")
		
		
		// Starting zone
		senniSystem(CGPoint(x: 0,y: 0))
		valentSystem(CGPoint(x: 3,y: 3))
		
		usulSystem(CGPoint(x: -2,y: 2))
		
		
		/*
		
		
		self.addChildNode(eventStation(location: CGPoint(x: 0.25,y: 0), size: 0.5))
		
		self.addChildNode(eventStation(location: CGPoint(x: 0.75,y: 0.5), size: 0.5))
		
		self.addChildNode(eventStation(location: CGPoint(x: 1.25,y: 0.25), size: 0.5))
		
		self.addChildNode(eventStation(location: CGPoint(x: 1.75,y: 0.5), size: 0.5))
		
		self.addChildNode(eventStation(location: CGPoint(x: 2.25,y: 0.25), size: 0.5))
		
		self.addChildNode(eventPortal(location: CGPoint(x: 0.5,y: 0.5), destination: CGPoint(x: 2,y: 0.7), sector: sectors.opal, color:whiteTone))
		
		
		
		self.addChildNode(eventCargo(location: CGPoint(x: -0.25, y: 0.75), inventory: Event(newName: "warpdisk",type: eventTypes.item)))
		
		self.addChildNode(eventCargo(location: CGPoint(x: 0.25, y: -0.5), inventory: Event(newName: "warpdisk",type: eventTypes.item)))
*/
	}
	
	
	func usulSystem(offset:CGPoint)
	{
		let star = eventStar(name:"Usul",location: CGPoint(x:offset.x,y:offset.y),color:cyan)
		let portal = eventPortal(name: "Portal", location: CGPoint(x:offset.x,y:offset.y - 1), destination:CGPoint(x:offset.x,y:offset.y))
		
		let beacon = eventBeacon(name: "beacon", location: CGPoint(x:offset.x,y:offset.y - 2))
		
		portal.connect(beacon)
		
		self.addChildNode(star)
		self.addChildNode(portal)
		self.addChildNode(beacon)
	}
	
	func valentSystem(offset:CGPoint)
	{
		let star = eventStar(name:"Valent",location: CGPoint(x:offset.x,y:offset.y))
		let landing = eventStation(name:"landing",location: CGPoint(x:offset.x - 1.25,y:offset.y + 1), size: 0.5)
		let repair = eventStation(name:"Repair",location: CGPoint(x:offset.x + 1.25,y:offset.y + 1), size: 0.5)
		let portal = eventPortal(name: "Portal", location: CGPoint(x:offset.x,y:offset.y + 1), destination:CGPoint(x:offset.x,y:offset.y))
		
		let beacon = eventBeacon(name: "beacon", location: CGPoint(x:offset.x,y:offset.y + 2))
		
		landing.connect(portal)
		repair.connect(portal)
		repair.connect(portal)
		portal.connect(beacon)
		
		self.addChildNode(star)
		self.addChildNode(landing)
		self.addChildNode(repair)
		self.addChildNode(portal)
		self.addChildNode(beacon)
	}

	func senniSystem(offset:CGPoint)
	{
		let star = eventStar(name:"Senni",location: CGPoint(x:offset.x,y:offset.y))
		let landing = eventStation(name:"landing",location: CGPoint(x:offset.x - 1,y:offset.y), size: 0.5)
		let repair = eventStation(name:"Repair",location: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		let portal = eventPortal(name: "Portal", location: CGPoint(x:offset.x + 1,y:offset.y), destination:CGPoint(x:offset.x,y:offset.y))
		let cargo = eventCargo(name: "cargo", location: CGPoint(x:offset.x,y:offset.y - 1))
		let cargo2 = eventCargo(name: "cargo", location: CGPoint(x:offset.x + 1.5,y:offset.y))
		let gate = eventPortal(name: "Portal", location: CGPoint(x:offset.x,y:offset.y + 2), destination:CGPoint(x:offset.x,y:offset.y), sector: sectors.cyanine)
		
		let beacon = eventBeacon(name: "beacon", location: CGPoint(x:offset.x + 0.75,y:offset.y + 0.75))
		
		landing.connect(repair)
		repair.connect(portal)
		portal.connect(cargo)
		cargo.connect(landing)
		cargo2.connect(portal)
		
		gate.connect(repair)
		
		self.addChildNode(star)
		self.addChildNode(landing)
		self.addChildNode(repair)
		self.addChildNode(portal)
		self.addChildNode(cargo)
		self.addChildNode(cargo2)
		
		self.addChildNode(beacon)
		self.addChildNode(gate)
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