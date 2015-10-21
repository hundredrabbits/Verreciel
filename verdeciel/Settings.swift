//
//  Settings.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-09.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

enum alignment
{
	case left
	case center
	case right
}

enum sectors
{
	case opal
	case cyanine
	case vermiles
	case normal
	case void
}

enum eventTypes
{
	case unknown
	
	case portal
	case cargo
	case station
	case beacon
	case city
	case star
	case cell
	
	case stack
	case location
	case item
	case npc
	case battery
	case waypoint
	case ammo
	case cypher
	case map
	case warp
}

enum eventDetails
{
	case unknown
	case battery
	case card
	case star
	case quest
	case waste
	case part
	case panel
}

enum services
{
	case none
	case electricity
	case hull
	case neutralize
}

struct Templates
{
	var left:Float = 0
	var right:Float = 0
	var top:Float = 0
	var bottom:Float = 0
	
	var radius:Float = 0
	
	var leftMargin:Float = 0
	var rightMargin:Float = 0
	var topMargin:Float = 0
	var bottomMargin:Float = 0
	
	var titlesAngle:CGFloat = 22
	var monitorsAngle:CGFloat = 32
	var warningsAngle:CGFloat = 44
}

struct Settings
{
	var sight:CGFloat = 2.0
	var approach:CGFloat = 0.5
	var collision:CGFloat = 0.5
}