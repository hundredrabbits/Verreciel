//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructureSatellite : Structure
{
	let nodes:Int = Int(arc4random_uniform(2)) + 2
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let value1:Float = Float(20 + arc4random_uniform(5))/10
		let value2 = (Float(arc4random_uniform(100))/100).clamp(0.4, 2.9)
		let value3 = (Float(arc4random_uniform(100))/100).clamp(0.7, 2.9)
		
		var i = 0
		while i < nodes {
			
			let axis = SCNNode()
			axis.eulerAngles.y = Float(degToRad(CGFloat(i * (360/nodes))))
			
			root.addChildNode(axis)
			
			let shape = SCNHexa(size: 3, color: red)
			shape.position.x = 0
			axis.addChildNode(shape)
			
			let shape2 = SCNHexa(size: 3, color: red)
			shape2.eulerAngles.z = Float(degToRad(90))
			shape.addChildNode(shape2)
			
			let shape3 = SCNHexa(size: 3, color: red)
			shape3.eulerAngles.y = Float(degToRad(90))
			shape.addChildNode(shape3)
			
			let shape4 = SCNHexa(size: 3, color: red)
			shape4.eulerAngles.x = Float(degToRad(90))
			shape.addChildNode(shape4)
			
			i += 1
		}
	}
	
	override func onSight()
	{
		super.onSight()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes {
			for subnode in node.childNodes {
				subnode.position.x = 3
			}
		}
		
		SCNTransaction.commit()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes {
			for subnode in node.childNodes {
				subnode.position.x = 3
			}
		}
		
		SCNTransaction.commit()
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(0.5)
		
		for node in root.childNodes {
			for subnode in node.childNodes {
				subnode.position.x = 0
			}
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
		root.eulerAngles.y += Float(degToRad(0.1))
	}
	
	override func dockUpdate()
	{
		for node in root.childNodes {
			for subnode in node.childNodes {
				subnode.eulerAngles.z += Float(degToRad(0.25))
			}
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}