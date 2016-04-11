//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructureStation : Structure
{
	let nodes:Int = 4 + Int(arc4random_uniform(4))
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
//		let value1:CGFloat = CGFloat(20 + arc4random_uniform(5))/10
//		let value2 = (Float(arc4random_uniform(100))/100).clamp(0.4, 2.9)
//		let value3 = (Float(arc4random_uniform(100))/100).clamp(0.7, 2.9)
		
		var i:Int = 0
		while i < nodes {
			let axis = SCNNode()
			axis.eulerAngles.y = (degToRad(CGFloat(Float(i) * Float(360/nodes))))
			
			let node = SCNHexa(size: 4, color: red)
			node.eulerAngles.x = (degToRad(90))
			let node1 = SCNHexa(size: 4, color: red)
			node1.eulerAngles.y = (degToRad(90))
			
			axis.addChildNode(node)
			node.addChildNode(node1)
			root.addChildNode(axis)
			i += 1
		}
		
		
	}
	
	override func onSight()
	{
		super.onSight()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.x = (degToRad(0))
		}
		
		SCNTransaction.commit()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.x = (degToRad(45))
		}
		
		SCNTransaction.commit()
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes	{
			node.eulerAngles.x = (degToRad(45))
		}
		
		SCNTransaction.commit()
	}
	
	override func onComplete()
	{
		super.onComplete()
		
		updateChildrenColors(cyan)
	}
	
	override func sightUpdate()
	{
		root.eulerAngles.y += (degToRad(0.1))
	}
	
	override func dockUpdate()
	{
	}
	
	override func morph()
	{
		super.morph()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		let deg1 = 22.5 * (CGFloat(morphTime * 123) % 8) % 180
		let deg2 = 22.5 * (CGFloat(morphTime * 678) % 6) % 180
		
		for node in root.childNodes {
			for subnode in node.childNodes	{
				subnode.eulerAngles.z = (degToRad(deg1 - deg2))
				subnode.position.y = (2 - ((Float(morphTime) * 0.34) % 4)) * 0.6
			}
		}
		
		SCNTransaction.commit()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}