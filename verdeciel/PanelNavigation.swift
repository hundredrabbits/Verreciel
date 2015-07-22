//
//  SCNNavigation.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelNavigation : SCNNode
{
	var leftArrow:SCNArrow!
	var rightArrow:SCNArrow!
	
	override init()
	{
		super.init()
		name = "navigation"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: -2, z: lowNode[7].z * 0.65)
		self.rotation = SCNVector4Make(-1, 0, 0, Float(M_PI/2 * 0.85));
	}
	
	func addInterface()
	{
		leftArrow = SCNArrow(direction: cardinals.w)
		leftArrow.position = SCNVector3(x: 0.5, y: 0, z: 0)
		self.addChildNode(leftArrow)
		
		rightArrow = SCNArrow(direction: cardinals.e)
		rightArrow.position = SCNVector3(x: -0.5, y: 0, z: 0)
		self.addChildNode(rightArrow)
		
		let nameLabel = SCNLabel(text: "navigation", scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: -0.5, z: 0)
		nameLabel.name = "label.navigation"
		self.addChildNode(nameLabel)
	}
	
	func update()
	{
	}
	
	func turn(right:Bool)
	{
		if right {
			switch radar.direction {
				case  .n : radar.direction = .nw
				case  .ne : radar.direction = .n
				case  .e : radar.direction = .ne
				case  .se : radar.direction = .e
				case  .nw : radar.direction = .w
				case  .w : radar.direction = .sw
				case  .sw : radar.direction = .s
				default : radar.direction = .se
			}
		}
		else{
			switch radar.direction {
				case  .n : radar.direction = .ne
				case  .ne : radar.direction = .e
				case  .e : radar.direction = .se
				case  .se : radar.direction = .s
				case  .nw : radar.direction = .n
				case  .w : radar.direction = .nw
				case  .sw : radar.direction = .w
				default : radar.direction = .sw
			}
		}
		radar.update()
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}