//
//  Settings.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-09.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import Foundation

enum alignment {
	case left
	case center
	case right
}

enum sectors {
	case opal
	case cyanine
	case vermiles
	case normal
	case void
}

enum eventTypes {
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

enum eventDetails {
	case unknown
	case battery
	case card
	case star
	case quest
}

enum services
{
	case none
	case electricity
	case hull
}

enum missions
{
	case none
	case visit
	case discover
	case fetch
	case trade
}