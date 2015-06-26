//
//  SCNRadarEvent.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-26.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNRadarEvent : SCNNode
{
	init(newPosition:SCNVector3)
	{
		super.init()
		name = "event"
		position = newPosition
		self.addChildNode(cyanLine(SCNVector3(x:0,y:-0.1,z:0), SCNVector3(x:0,y:0.1,z:0)))
		self.addChildNode(cyanLine(SCNVector3(x:-0.1,y:0,z:0), SCNVector3(x:0.1,y:0,z:0)))
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}