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
	
	func onDock()
	{
	
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
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}