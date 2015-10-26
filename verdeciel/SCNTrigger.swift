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
	var size:CGSize!
	
	init(host:SCNNode,size:CGSize,operation:Int = 0)
	{
		self.operation = operation
		self.host = host
		self.size = size
		super.init()
		self.geometry = SCNPlane(width: size.width, height: size.height)
		self.geometry?.materials.first?.diffuse.contents = cyan
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
		self.geometry = SCNPlane(width: size.width, height: size.height)
	}
	
	func disable()
	{
		isEnabled = false
		self.geometry = SCNPlane(width: 0, height: 0)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}