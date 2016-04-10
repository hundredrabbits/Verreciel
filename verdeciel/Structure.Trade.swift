//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructureTrade : Structure
{
	let nodes:Int = 24
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let value1:Float = 3
		let value2:Float = 5
		
		var i = 0
		while i < nodes {
			
			let node = SCNNode()
			
			node.addChildNode(SCNLine(nodeA: SCNVector3(-value2,value1 * Float(i),0), nodeB: SCNVector3(0,value1 * Float(i),value2), color: red))
			node.addChildNode(SCNLine(nodeA: SCNVector3(0,value1 * Float(i),value2), nodeB: SCNVector3(value2,value1 * Float(i),0), color: red))
			node.addChildNode(SCNLine(nodeA: SCNVector3(value2,value1 * Float(i),0), nodeB: SCNVector3(0,value1 * Float(i) + 2,-value2), color: red))
			node.addChildNode(SCNLine(nodeA: SCNVector3(0,value1 * Float(i) + 2,-value2), nodeB: SCNVector3(-value2,value1 * Float(i),0), color: red))

			root.addChildNode(node)
			i += 1
		}
	}
	
	override func onSight()
	{
		super.onSight()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		var i = 0
		for node in root.childNodes	{
			node.eulerAngles.y = Float(degToRad(CGFloat(i * (360/nodes))))
			i += 1
		}
		
		SCNTransaction.commit()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		var i = 0
		for node in root.childNodes	{
			node.eulerAngles.y = Float(degToRad(CGFloat(i * (360/nodes))))
			i += 1
		}
		
		SCNTransaction.commit()
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.y = 0
		}

		SCNTransaction.commit()
	}
	
	override func onComplete()
	{
		super.onComplete()
		
		for node in root.childNodes	{
			node.updateChildrenColors(cyan)
		}
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