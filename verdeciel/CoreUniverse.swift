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
	
	func senniSystem(offset:CGPoint)
	{
		let star = eventStar(name:"Senni",location: CGPoint(x:offset.x,y:offset.y))
		let landing = eventStation(name:"landing",location: CGPoint(x:offset.x - 1,y:offset.y), size: 0.5)
		let repair = eventStation(name:"Repair",location: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		let portal = eventPortal(name: "Portal", location: CGPoint(x:offset.x + 1,y:offset.y), destination:CGPoint(x:offset.x,y:offset.y))
		let cargo = eventCargo(name: "cargo", location: CGPoint(x:offset.x,y:offset.y - 1))
		let cargo2 = eventCargo(name: "cargo", location: CGPoint(x:offset.x + 1.5,y:offset.y))
		
		landing.connect(repair)
		repair.connect(portal)
		portal.connect(cargo)
		cargo.connect(landing)
		cargo2.connect(portal)
		
		self.addChildNode(star)
		self.addChildNode(landing)
		self.addChildNode(repair)
		self.addChildNode(portal)
		self.addChildNode(cargo)
		self.addChildNode(cargo2)
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