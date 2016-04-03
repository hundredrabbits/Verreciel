
//  Created by Devine Lu Linvega on 2016-02-17.
//  Copyright © 2016 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class LocationConstellation : Location
{
	init(name:String = "", system:Systems, at:CGPoint = CGPoint(x: 0,y: 0), structure:SCNNode = structures.none())
	{
		super.init(name:name, system:system, at:at)
		
		self.note = ""
		self.structure = structure
		icon.replace(icons.constellation())
		
		label.opacity = 0
	}
	
	override func onApproach()
	{
		print("* EVENT    | Approached \(self.name!)")
		space.startInstance(self)
		update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}