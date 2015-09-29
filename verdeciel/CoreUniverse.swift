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
		
		
		self.addChildNode(eventStar(location: CGPoint(x: -0.5,y: 0.5)))
		
		self.addChildNode(eventStation(location: CGPoint(x: 0.25,y: 0), size: 0.5))
		
		self.addChildNode(eventStation(location: CGPoint(x: 0.75,y: 0.5), size: 0.5))
		
		self.addChildNode(eventStation(location: CGPoint(x: 1.25,y: 0.25), size: 0.5))
		
		self.addChildNode(eventStation(location: CGPoint(x: 1.75,y: 0.5), size: 0.5))
		
		self.addChildNode(eventStation(location: CGPoint(x: 2.25,y: 0.25), size: 0.5))
		
		/*
		
		self.addChildNode(eventPortal(location: CGPoint(x: 0.5,y: 0.5), destination: CGPoint(x: 2,y: 0.7), sector: sectors.opal, color:whiteTone))
		
		
		
		self.addChildNode(eventCargo(location: CGPoint(x: -0.25, y: 0.75), inventory: SCNEvent(newName: "warpdisk",type: eventTypes.item)))
		
		self.addChildNode(eventCargo(location: CGPoint(x: 0.25, y: -0.5), inventory: SCNEvent(newName: "warpdisk",type: eventTypes.item)))
*/
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