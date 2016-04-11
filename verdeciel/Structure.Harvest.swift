//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructureHarvest : Structure
{
	let nodes:Int = 45
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let color:UIColor = cyan
		let value1:Float = 7
		
		var i = 0
		while i < nodes {
			let node = SCNNode()
			node.eulerAngles.y = Float(degToRad(CGFloat(i * (360/nodes))))
			node.addChildNode(SCNLine(nodeA: SCNVector3(0,0,value1), nodeB: SCNVector3(0,5,value1), color: color))
			node.addChildNode(SCNLine(nodeA: SCNVector3(0,5,value1), nodeB: SCNVector3(0.5,5.5,value1), color: color))
			node.addChildNode(SCNLine(nodeA: SCNVector3(0,5,value1), nodeB: SCNVector3(-0.5,5.5,value1), color: color))
			root.addChildNode(node)
			i += 1
		}
	}
	
	override func onSight()
	{
		super.onSight()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
	}
	
	override func onDock()
	{
		super.onDock()
	}
	
	override func onComplete()
	{
		super.onComplete()
	}
	
	override func sightUpdate()
	{
		root.eulerAngles.y += Float(degToRad(0.1))
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}