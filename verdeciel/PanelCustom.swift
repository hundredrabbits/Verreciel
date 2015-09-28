//
//  PanelBeacon.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelCustom : SCNNode
{
	override init()
	{
		super.init()
		
		name = "custom"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: 0)
		
		update()
	}
	
	func addInterface()
	{
		self.addChildNode(SCNLine(nodeA: highNode[0],nodeB: lowNode[7],color:white))
		self.addChildNode(SCNLine(nodeA: highNode[7],nodeB: lowNode[0],color:white))
	}
	
	override func listen(event:SCNEvent)
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}