//
//  SCNMonitor.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNMonitor : SCNNode
{
	override init()
	{
		super.init()
		name = "monitor"
		addInterface()
	}
	
	func addInterface()
	{
		
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}