//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class StructureHoradric : Structure
{
	let nodes:Int = Int(arc4random_uniform(10)) + 4
	let radius:CGFloat = 5
	
	override init()
	{
		super.init()
		
		root.position = SCNVector3(0,5,0)
		
		let cube1 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube1)
		cube1.line9.color(clear)
		cube1.line10.color(clear)
		cube1.line11.color(clear)
		cube1.line12.color(clear)
		
		let cube2 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube2)
		cube2.line9.color(clear)
		cube2.line10.color(clear)
		cube2.line11.color(clear)
		cube2.line12.color(clear)
		
		let cube3 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube3)
		cube3.line9.color(clear)
		cube3.line10.color(clear)
		cube3.line11.color(clear)
		cube3.line12.color(clear)
		
		let cube4 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube4)
		cube4.line9.color(clear)
		cube4.line10.color(clear)
		cube4.line11.color(clear)
		cube4.line12.color(clear)
		
		let cube5 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube5)
		cube5.line9.color(clear)
		cube5.line10.color(clear)
		cube5.line11.color(clear)
		cube5.line12.color(clear)
		
		let cube6 = SCNCube(size: radius, color:grey)
		root.addChildNode(cube6)
		cube6.line9.color(clear)
		cube6.line10.color(clear)
		cube6.line11.color(clear)
		cube6.line12.color(clear)
	}
	
	override func onSight()
	{
		super.onSight()
	}
	
	override func onUndock()
	{
		super.onUndock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		
		childNodes[0].eulerAngles.y = Float(degToRad(0))
		childNodes[1].eulerAngles.y = Float(degToRad(0))
		
		childNodes[2].eulerAngles.z = Float(degToRad(0))
		childNodes[3].eulerAngles.z = Float(degToRad(0))
		
		childNodes[4].eulerAngles.x = Float(degToRad(0))
		childNodes[5].eulerAngles.x = Float(degToRad(0))
		
		eulerAngles.y = Float(degToRad(0))
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	override func onDock()
	{
		super.onDock()
		
		SCNTransaction.begin()
		SCNTransaction.setAnimationDuration(3)
		
		childNodes[0].eulerAngles.y += Float(degToRad(22.5))
		childNodes[1].eulerAngles.y -= Float(degToRad(22.5))
		
		childNodes[2].eulerAngles.z += Float(degToRad(45))
		childNodes[3].eulerAngles.z -= Float(degToRad(45))
		
		childNodes[4].eulerAngles.x += Float(degToRad(90))
		childNodes[5].eulerAngles.x -= Float(degToRad(90))
		
		eulerAngles.y += Float(degToRad(90))
		
		SCNTransaction.setCompletionBlock({ })
		SCNTransaction.commit()
	}
	
	override func onComplete()
	{
		super.onComplete()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}