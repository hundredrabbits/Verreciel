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

class CoreUniverse
{
	init() // Todo
	{
		radar.addEvent(SCNEvent(newName: "test", location: CGPoint(x: 0,y: 0.5), size: 0.5, type: eventTypes.location))
//		radar.addEvent(SCNEvent(newName: "home", location: CGPoint(x: 0,y: 0), size: 1, type: eventTypes.location))
		
		radar.addEvent(SCNEvent(newName: "a", location: CGPoint(x: -0.5,y: 0), size: 1, type: eventTypes.location))
		radar.addEvent(SCNEvent(newName: "b", location: CGPoint(x: 0.5,y: 0), size: 1, type: eventTypes.location))
		radar.addEvent(SCNEvent(newName: "c", location: CGPoint(x: 0,y: -0.5), size: 1, type: eventTypes.location))
		radar.addEvent(SCNEvent(newName: "d", location: CGPoint(x: 0,y: 0.5), size: 1, type: eventTypes.location))
		
		radar.addEvent(SCNEvent(newName: "a", location: CGPoint(x: -0.5,y: 0.5), size: 1, type: eventTypes.location))
		radar.addEvent(SCNEvent(newName: "b", location: CGPoint(x: 0.5,y: 0.5), size: 1, type: eventTypes.location))
		radar.addEvent(SCNEvent(newName: "c", location: CGPoint(x: 0.5,y: -0.5), size: 1, type: eventTypes.location))
		radar.addEvent(SCNEvent(newName: "d", location: CGPoint(x: -0.5,y: -0.5), size: 1, type: eventTypes.location))
		
		radar.addEvent(SCNEvent(newName: "star", location: CGPoint(x: 4,y: 4), size: 1, type: eventTypes.location))
	}
}