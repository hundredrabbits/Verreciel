//
//  SCNLine.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-13.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNTrigger : SCNNode
{
	let host:SCNNode!
	let operation:Bool!
	
	init(host:SCNNode,size:CGFloat,operation:Bool = true)
	{
		self.operation = operation
		self.host = host
		super.init()
		self.geometry = SCNPlane(width: size, height: size)
		self.geometry?.materials.first?.diffuse.contents = cyan
	}
	
	override func touch()
	{
		host.bang(self.operation)
	}
	
	override func update()
	{
		
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}