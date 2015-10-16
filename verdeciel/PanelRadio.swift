//
//  PanelBeacon.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelRadio : Panel
{
	override func setup()
	{
		name = "radio"
		self.position = SCNVector3(x: 0, y: -1 * templates.leftMargin - 0.6, z: templates.radius)
	}
}