//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructureSatellite : Structure
{
	let nodes:Int = Int(arc4random_uniform(10)) + 4
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let value1:Float = Float(20 + arc4random_uniform(5))/10
		
		let value2 = (Float(arc4random_uniform(100))/100).clamp(0.4, 2.9)
		let value3 = (Float(arc4random_uniform(100))/100).clamp(0.7, 2.9)
		
		var i = 0
		while i < nodes {
			var e = 0
			while e < nodes {
				let node = SCNNode()
				node.eulerAngles.y = Float(degToRad(CGFloat(Float(e) * Float(360/nodes))))
				root.addChildNode(node)
				let branch1 = SCNLine(nodeA: SCNVector3(0,0,value1 * value2 + 1), nodeB: SCNVector3((value1) * value3,0,value1 * value3 - 1), color: red)
				let branch2 = SCNLine(nodeA: SCNVector3(0,0,value1 * value2 + 1), nodeB: SCNVector3((-value1) * value3,0,value1 * value3 - 1), color: red)
				node.addChildNode(branch1)
				node.addChildNode(branch2)
				branch1.addChildNode(SCNLine(nodeA: branch1.nodeB, nodeB: SCNVector3(value1 * value2 * value3,0,1 * value3), color: grey))
				branch1.addChildNode(SCNLine(nodeA: branch1.nodeB, nodeB: SCNVector3(-value1 * value2 * value3,0,1 * value3), color: grey))
				branch2.addChildNode(SCNLine(nodeA: branch2.nodeB, nodeB: SCNVector3(value1 * value2 * value3,0,1 * value3), color: grey))
				branch2.addChildNode(SCNLine(nodeA: branch2.nodeB, nodeB: SCNVector3(-value1 * value2 * value3,0,1 * value3), color: grey))
				e += 1
			}
			i += 1
		}
	}
	
	override func onSight()
	{
		super.onSight()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.x = Float(degToRad(0))
		}
		
		SCNTransaction.commit()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.x = Float(degToRad(45))
		}
		
		SCNTransaction.commit()
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.x = Float(degToRad(45))
		}
		
		SCNTransaction.commit()
	}
	
	override func onComplete()
	{
		super.onComplete()
	}
	
	override func sightUpdate()
	{
		root.eulerAngles.y += Float(degToRad(0.1))
	}
	
	override func dockUpdate()
	{
		for node in root.childNodes {
			node.eulerAngles.x += Float(degToRad(0.1))
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}