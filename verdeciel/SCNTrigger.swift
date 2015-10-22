//  Created by Devine Lu Linvega on 2015-07-13.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNTrigger : SCNNode
{
	var isEnabled:Bool = true
	let host:SCNNode!
	let operation:Int!
	
	init(host:SCNNode,size:CGSize,operation:Int = 0)
	{
		self.operation = operation
		self.host = host
		super.init()
		self.geometry = SCNPlane(width: size.width, height: size.height)
		self.geometry?.materials.first?.diffuse.contents = clear
	}
	
	override func touch(id:Int)
	{
		if isEnabled == false { return }
		host.touch(operation)
	}
	
	override func update()
	{
		
	}
	
	func enable()
	{
		isEnabled = true
	}
	
	func disable()
	{
		isEnabled = false
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}