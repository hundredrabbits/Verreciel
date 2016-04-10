//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class Structure : SCNNode
{
	let root = SCNNode()
	
	override init()
	{
		super.init()
		
		addChildNode(root)
	}
	
	var morphTime:Int = 0
	var morphTimer:NSTimer!
	
	func onDock()
	{
		morph()
	}
	
	func onSight()
	{
		
	}
	
	func onUndock()
	{
		
	}
	
	func onComplete()
	{
	
	}
	
	func dockUpdate()
	{
	
	}
	
	func sightUpdate()
	{
	
	}
	
	func morph()
	{
		morphTime += 1
		if capsule.isDocked == true {
			delay(2, block: { self.morph() })
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}