
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
		details = "star protection"
		requirement = ItemTypes.shield
		isPowered = { battery.isShieldPowered() }
		label.update(name!)
	}
	
	override func update()
	{
		if port.hasItemOfType(.shield) == true {
			if battery.isShieldPowered() == true {
				mode_powered()
			}
			else{
				mode_unpowered()
			}
		}
		else{
			if battery.isShieldPowered() == true {
				mode_blank()
			}
			else{
				mode_none()
			}
		}
	}
	
	func mode_powered()
	{
		capsule.shieldRoot.updateChildrenColors(cyan)
		capsule.shieldRoot.show()
	}
	
	func mode_unpowered()
	{
		capsule.shieldRoot.updateChildrenColors(grey)
		capsule.shieldRoot.show()
	}
	
	func mode_blank()
	{
		capsule.shieldRoot.updateChildrenColors(grey)
		capsule.shieldRoot.show()
	}
	
	func mode_none()
	{
		capsule.shieldRoot.updateChildrenColors(clear)
		capsule.shieldRoot.hide()
	}
	
	override func onPowered()
	{
		super.onPowered()		
		update()
	}
	
	override func onUnpowered()
	{
		super.onUnpowered()
		update()
	}
	
	func createShield()
	{
		capsule.addChildNode(capsule.shieldRoot)
		let radius:CGFloat = 6
		var scale:CGFloat = 2.5
		let sides:Float = 8
		let color:UIColor = red
		
		var i = 0
		while i < Int(sides) {
			scale = 2.5
			// Face 1
			let face1 = Empty()
			face1.addChildNode(SCNLine(vertices: [SCNVector3(0,scale,radius), SCNVector3(0,-scale,radius)], color: color))
			face1.eulerAngles.y += (degToRad(Float(i) * (360/sides)))
			capsule.shieldRoot.addChildNode(face1)
			
			// Face 2
			scale = 1.9
			let face2 = Empty()
			let line5 = SCNLine(vertices: [SCNVector3(-scale,0,radius), SCNVector3(0,scale,radius)], color: color)
			let line6 = SCNLine(vertices: [SCNVector3(0,scale,radius), SCNVector3(scale,0,radius)], color: color)
			let line7 = SCNLine(vertices: [SCNVector3(scale,0,radius), SCNVector3(0,-scale,radius)], color: color)
			let line8 = SCNLine(vertices: [SCNVector3(0,-scale,radius), SCNVector3(-scale,0,radius)], color: color)
			face2.addChildNode(line5)
			face2.addChildNode(line6)
			face2.addChildNode(line7)
			face2.addChildNode(line8)
			face2.eulerAngles.y += (degToRad(Float(i) * (360/sides)))
			face2.eulerAngles.x += (degToRad(40))
			capsule.shieldRoot.addChildNode(face2)
			
			// Face 3
			scale = 1.9
			let face3 = Empty()
			let line9 = SCNLine(vertices: [SCNVector3(-scale,0,radius), SCNVector3(0,scale,radius)], color: color)
			let line10 = SCNLine(vertices: [SCNVector3(0,scale,radius), SCNVector3(scale,0,radius)], color: color)
			let line11 = SCNLine(vertices: [SCNVector3(scale,0,radius), SCNVector3(0,-scale,radius)], color: color)
			let line12 = SCNLine(vertices: [SCNVector3(0,-scale,radius), SCNVector3(-scale,0,radius)], color: color)
			face3.addChildNode(line9)
			face3.addChildNode(line10)
			face3.addChildNode(line11)
			face3.addChildNode(line12)
			face3.eulerAngles.y += (degToRad(Float(i) * (360/sides)))
			face3.eulerAngles.x -= (degToRad(40))
			capsule.shieldRoot.addChildNode(face3)
			
			i += 1
		}
		
		capsule.shieldRoot.eulerAngles.y = (degToRad(360/16))
		capsule.shieldRoot.hide()
	}

	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		
		createShield()
		battery.installShield()
		
		update()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}