
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
		info = "[missing text]"
		requirement = ItemTypes.shield
		isPowered = { battery.isShieldPowered() }
		
		label.update(name!)
	}
	
	var growthVal:Float = 0
	
	override func onPowered()
	{
		super.onPowered()
		
		port.enable()
		
		if port.hasItemOfType(.shield) == true {
			capsule.shieldRoot.opacity = 1
		}
	}
	
	override func onUnpowered()
	{
		super.onUnpowered()
		
		port.disable()
		capsule.shieldRoot.opacity = 0
	}
	
	func createShield()
	{
		capsule.addChildNode(capsule.shieldRoot)
		let radius:CGFloat = 6
		var scale:CGFloat = 2.5
		let sides:CGFloat = 8
		let color:UIColor = red
		
		var i = 0
		while i < Int(sides) {
			scale = 2.5
			// Face 1
			let face1 = SCNNode()
			face1.addChildNode(SCNLine(vertices: [SCNVector3(0,scale,radius), SCNVector3(0,-scale,radius)], color: color))
			face1.eulerAngles.y += (degToRad(CGFloat(i) * (360/sides)))
			capsule.shieldRoot.addChildNode(face1)
			
			// Face 2
			scale = 1.9
			let face2 = SCNNode()
			let line5 = SCNLine(vertices: [SCNVector3(-scale,0,radius), SCNVector3(0,scale,radius)], color: color)
			let line6 = SCNLine(vertices: [SCNVector3(0,scale,radius), SCNVector3(scale,0,radius)], color: color)
			let line7 = SCNLine(vertices: [SCNVector3(scale,0,radius), SCNVector3(0,-scale,radius)], color: color)
			let line8 = SCNLine(vertices: [SCNVector3(0,-scale,radius), SCNVector3(-scale,0,radius)], color: color)
			face2.addChildNode(line5)
			face2.addChildNode(line6)
			face2.addChildNode(line7)
			face2.addChildNode(line8)
			face2.eulerAngles.y += (degToRad(CGFloat(i) * (360/sides)))
			face2.eulerAngles.x += (degToRad(40))
			capsule.shieldRoot.addChildNode(face2)
			
			// Face 3
			scale = 1.9
			let face3 = SCNNode()
			let line9 = SCNLine(vertices: [SCNVector3(-scale,0,radius), SCNVector3(0,scale,radius)], color: color)
			let line10 = SCNLine(vertices: [SCNVector3(0,scale,radius), SCNVector3(scale,0,radius)], color: color)
			let line11 = SCNLine(vertices: [SCNVector3(scale,0,radius), SCNVector3(0,-scale,radius)], color: color)
			let line12 = SCNLine(vertices: [SCNVector3(0,-scale,radius), SCNVector3(-scale,0,radius)], color: color)
			face3.addChildNode(line9)
			face3.addChildNode(line10)
			face3.addChildNode(line11)
			face3.addChildNode(line12)
			face3.eulerAngles.y += (degToRad(CGFloat(i) * (360/sides)))
			face3.eulerAngles.x -= (degToRad(40))
			capsule.shieldRoot.addChildNode(face3)
			
			i += 1
		}
		
		capsule.shieldRoot.eulerAngles.y = (degToRad(360/16))
		capsule.shieldRoot.opacity = 0
	}

	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		battery.installShield()
		createShield()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}