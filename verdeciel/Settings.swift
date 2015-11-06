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

// Panels
let battery = PanelBattery()
let pilot = PanelPilot()
let hatch = PanelHatch()
let mission = PanelMission()
let cargo = PanelCargo()
let thruster = PanelThruster()
let console = PanelConsole()
let radar = PanelRadar()

// Monitors
let journey = MonitorJourney()
let exploration = MonitorExploration()
let progress = MonitorProgress()

// Generic
var time:CoreTime!
var universe:CoreUniverse!
var capsule:CoreCapsule!
var player:CorePlayer!
var space:CoreSpace!
var ui:CoreUI!

// Collections
var quests = QuestLibrary()
var items = ItemLibrary()
var locations = LocationLibrary()
var recipes = RecipesLibrary()
var structures = StructuresLibrary()
var icons = IconsLibrary()

var templates = Templates()
var settings = Settings()
var debug = Debug()

// Colors
var black:UIColor = UIColor(white: 0, alpha: 1)
var grey:UIColor = UIColor(white: 0.4, alpha: 1)
var greyTone:UIColor = UIColor(white: 0.2, alpha: 1)
var white:UIColor = UIColor.whiteColor()
var whiteTone:UIColor = UIColor(white: 0.8, alpha: 1)
var red:UIColor = UIColor.redColor()
var redTone:UIColor = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
var cyan:UIColor = UIColor(red: 0.44, green: 0.87, blue: 0.76, alpha: 1)
var cyanTone:UIColor = UIColor(red: 0.24, green: 0.67, blue: 0.56, alpha: 1)
var clear:UIColor = UIColor(white: 0, alpha: 0)

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
	case none
	case unknown
	
	case generic
	case drive
	
	case portal
	case cargo
	case station
	case beacon
	case city
	case star
	case cell
	
	case location
	case item
	case npc
	case battery
	case waypoint
	case ammo
	case cypher
	case map
	case warp
	case panel
}

enum itemTypes
{
	case unknown
	case battery
	case card
	case star
	case quest
	case waste
	case part
	case panel
	case key
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
	
	var margin:Float = 0
	var leftMargin:Float = 0
	var rightMargin:Float = 0
	var topMargin:Float = 0
	var bottomMargin:Float = 0
	
	var titlesAngle:CGFloat = 22
	var monitorsAngle:CGFloat = 47
	var warningsAngle:CGFloat = 44
	
	var lineSpacing:Float = 0.42
}

struct Settings
{
	var applicationIsReady:Bool = false
	var sight:CGFloat = 2.0
	var approach:CGFloat = 0.5
	var collision:CGFloat = 0.5
}

struct Debug
{
	var isActive:Bool = false
	var fixedUpdatedCount:Int = 0
}