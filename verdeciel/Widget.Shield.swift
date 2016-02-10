
//  Created by Devine Lu Linvega on 2015-12-15.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class WidgetShield : Widget
{
	var isActive:Bool = false
	
	override init()
	{
		super.init()
	
		name = "shield"
		label.update(name!)
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		battery.installShield()
	}
	
	override func fixedUpdate()
	{
		super.fixedUpdate()
		
		let randomMeshId = Int(arc4random_uniform(UInt32(capsule.shield.childNodes.count)))
		print(capsule.shield.childNodes[randomMeshId])
//		capsule.shield.childNodes[randomMeshId].updateChildrenColors(red)
	}
	
	func createShield()
	{
		let radius:CGFloat = 6
		var scale:CGFloat = 2.5
		let sides:CGFloat = 8
		
		var i = 0
		while i < Int(sides) {
			scale = 2.5
			// Face 1
			let face1 = SCNNode()
			let line1 = SCNLine(nodeA: SCNVector3(-scale,0,radius), nodeB: SCNVector3(0,scale,radius), color: grey)
			let line2 = SCNLine(nodeA: SCNVector3(0,scale,radius), nodeB: SCNVector3(scale,0,radius), color: grey)
			let line3 = SCNLine(nodeA: SCNVector3(scale,0,radius), nodeB: SCNVector3(0,-scale,radius), color: grey)
			let line4 = SCNLine(nodeA: SCNVector3(0,-scale,radius), nodeB: SCNVector3(-scale,0,radius), color: grey)
			face1.addChildNode(line1)
			face1.addChildNode(line2)
			face1.addChildNode(line3)
			face1.addChildNode(line4)
			face1.eulerAngles.y += Float(degToRad(CGFloat(i) * (360/sides)))
			shield.addChildNode(face1)
			
			// Face 2
			scale = 1.9
			let face2 = SCNNode()
			let line5 = SCNLine(nodeA: SCNVector3(-scale,0,radius), nodeB: SCNVector3(0,scale,radius), color: grey)
			let line6 = SCNLine(nodeA: SCNVector3(0,scale,radius), nodeB: SCNVector3(scale,0,radius), color: grey)
			let line7 = SCNLine(nodeA: SCNVector3(scale,0,radius), nodeB: SCNVector3(0,-scale,radius), color: grey)
			let line8 = SCNLine(nodeA: SCNVector3(0,-scale,radius), nodeB: SCNVector3(-scale,0,radius), color: grey)
			face2.addChildNode(line5)
			face2.addChildNode(line6)
			face2.addChildNode(line7)
			face2.addChildNode(line8)
			face2.eulerAngles.y += Float(degToRad(CGFloat(i) * (360/sides)))
			face2.eulerAngles.x += Float(degToRad(40))
			shield.addChildNode(face2)
			
			// Face 3
			scale = 1.9
			let face3 = SCNNode()
			let line9 = SCNLine(nodeA: SCNVector3(-scale,0,radius), nodeB: SCNVector3(0,scale,radius), color: grey)
			let line10 = SCNLine(nodeA: SCNVector3(0,scale,radius), nodeB: SCNVector3(scale,0,radius), color: grey)
			let line11 = SCNLine(nodeA: SCNVector3(scale,0,radius), nodeB: SCNVector3(0,-scale,radius), color: grey)
			let line12 = SCNLine(nodeA: SCNVector3(0,-scale,radius), nodeB: SCNVector3(-scale,0,radius), color: grey)
			face3.addChildNode(line9)
			face3.addChildNode(line10)
			face3.addChildNode(line11)
			face3.addChildNode(line12)
			face3.eulerAngles.y += Float(degToRad(CGFloat(i) * (360/sides)))
			face3.eulerAngles.x -= Float(degToRad(40))
			shield.addChildNode(face3)
			
			i += 1
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}