//
//  CoreUniverse.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-18.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreUniverse : SCNNode
{
	var falvetToSenni = LocationWaypoint()
	var falvetToValen = LocationWaypoint()
	var falvetToUsul = LocationWaypoint()
	var falvetToLoiqe = LocationWaypoint()
	
	var valenToVenic = LocationWaypoint()
	
	var entryToSenni = LocationStation()
	var entryToValen = LocationStation()
	var entryToUsul = LocationStation()
	var entryToVenic = LocationStation()
	var entryToLoiqe:Location!
	
	override init()
	{
		super.init()
		
		print("@ UNIVERSE | Init")
		
		addLoiqe()
		addUsul()
		addVenic()
		addValen()
		
		// Starting zone
		falvetSystem(CGPoint(x: 0,y: 0))
		senniSystem(CGPoint(x: 0,y: 4))
		valenSystem(CGPoint(x: 4,y: 0))
		
		connectPaths()
	}
	
	// MARK: Loiqe -
	
	var loiqe = locations.loiqe.star()
	var loiqe_spawn = locations.loiqe.spawn()
	var loiqe_landing = locations.loiqe.landing()
	var loiqe_city = locations.loiqe.city()
	var loiqe_telescope = locations.loiqe.telescope()
	var loiqe_waypoint = locations.loiqe.waypoint()
	
	func addLoiqe()
	{
		addChildNode(loiqe)
		addChildNode(loiqe_spawn)
		addChildNode(loiqe_landing)
		addChildNode(loiqe_city)
		addChildNode(loiqe_telescope)
		addChildNode(loiqe_waypoint)
	}
	
	// MARK: Usul -
	
	var usul = locations.usul.star()
	var usul_city = locations.usul.city()
	var usul_waypoint = locations.usul.waypoint()
	
	func addUsul()
	{
		addChildNode(usul)
		addChildNode(usul_city)
		addChildNode(usul_waypoint)
	}
	
	// MARK: Valen -
	
	var valen = locations.valen.star()
	var valen_city = locations.valen.city()
	var valen_telescope = locations.valen.telescope()
	var valen_waypoint = locations.valen.waypoint()
	
	func addValen()
	{
		addChildNode(valen)
		addChildNode(valen_city)
		addChildNode(valen_telescope)
		addChildNode(valen_waypoint)
	}
	
	// MARK: Venic -
	
	var venic = locations.venic.star()
	var venic_city = locations.venic.city()
	var venic_waypoint = locations.venic.waypoint()
	
	func addVenic()
	{
		addChildNode(venic)
		addChildNode(venic_city)
		addChildNode(venic_waypoint)
	}
	
	// MARK: Senni -
	
	var senni = locations.senni.star()
	var senni_city = locations.senni.city()
	var senni_waypoint = locations.senni.waypoint()
	var senni_telescope = locations.senni.telescope()
	var senni_portal = locations.senni.portal()
	var senni_service = locations.senni.service()
	var senni_spawn = locations.senni.spawn()
	
	func addSenni()
	{
		addChildNode(senni)
		addChildNode(senni_city)
		addChildNode(senni_waypoint)
		addChildNode(senni_telescope)
		addChildNode(senni_portal)
		addChildNode(senni_service)
		addChildNode(senni_spawn)
	}
	
	// MARK: Usul -
	
	func falvetSystem(offset:CGPoint)
	{
		self.addChildNode(locations.falvet(CGPoint(x:offset.x,y:offset.y)))
		
		falvetToUsul = LocationWaypoint(name:"landing",at: CGPoint(x:offset.x - 1.5,y:offset.y))
		falvetToSenni = LocationWaypoint(name:"landing",at: CGPoint(x:offset.x,y:offset.y + 1.5))
		falvetToValen = LocationWaypoint(name:"landing",at: CGPoint(x:offset.x + 1.5,y:offset.y))
		falvetToLoiqe = LocationWaypoint(name:"landing",at: CGPoint(x:offset.x,y:offset.y - 1.5))
		
		let city = locations.falvetCity(CGPoint(x:offset.x - 1,y:offset.y + 1))
		
		self.addChildNode(city)
		let city6 = LocationStation(name:"landing",at: CGPoint(x:offset.x + 1,y:offset.y + 1), size: 0.5)
		let city7 = LocationStation(name:"landing",at: CGPoint(x:offset.x + 1,y:offset.y - 1), size: 0.5)
		let city8 = LocationStation(name:"landing",at: CGPoint(x:offset.x - 1,y:offset.y - 1), size: 0.5)
		
		self.addChildNode(falvetToUsul)
		self.addChildNode(falvetToSenni)
		self.addChildNode(falvetToValen)
		self.addChildNode(falvetToLoiqe)
		
		self.addChildNode(city)
		self.addChildNode(city6)
		self.addChildNode(city7)
		self.addChildNode(city8)
		
		city.connect(falvetToSenni)
		city6.connect(falvetToValen)
		city7.connect(falvetToLoiqe)
		city8.connect(falvetToUsul)
		
	}
	
	func valenSystem(offset:CGPoint)
	{
		let star = LocationStar(name:"valen",at: CGPoint(x:offset.x,y:offset.y))
		
		entryToValen = LocationStation(name:"Repair",at: CGPoint(x:offset.x - 1,y:offset.y), size: 0.5)
		valenToVenic = LocationWaypoint(name:"landing",at: CGPoint(x:offset.x,y:offset.y - 1))
		
		let city2 = LocationStation(name:"landing",at: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		
		city2.connect(entryToValen)
		
		self.addChildNode(entryToValen)
		self.addChildNode(star)
		self.addChildNode(valenToVenic)
		self.addChildNode(city2)
	}

	func senniSystem(offset:CGPoint)
	{
		let star = LocationStar(name:"Senni",at: CGPoint(x:offset.x,y:offset.y))
		let landing = LocationStation(name:"landing",at: CGPoint(x:offset.x - 1,y:offset.y), size: 0.5)
		let repair = LocationStation(name:"Repair",at: CGPoint(x:offset.x,y:offset.y + 1), size: 0.5)
		let portal = LocationPortal(name: "Portal", at: CGPoint(x:offset.x + 1,y:offset.y), destination:CGPoint(x:offset.x,y:offset.y))
		let cargo2 = LocationCargo(name: "cargo", at: CGPoint(x:offset.x + 1.5,y:offset.y))
		let gate = LocationPortal(name: "Portal", at: CGPoint(x:offset.x,y:offset.y + 2), destination:CGPoint(x:offset.x,y:offset.y), sector: sectors.cyanine)
		
		
		entryToSenni = LocationStation(name: "cargo", at: CGPoint(x:offset.x,y:offset.y - 1), size:1)
		
		landing.connect(repair)
		repair.connect(portal)
		portal.connect(entryToSenni)
		entryToSenni.connect(landing)
		cargo2.connect(portal)
		
		gate.connect(repair)
		
		self.addChildNode(star)
		self.addChildNode(landing)
		self.addChildNode(repair)
		self.addChildNode(portal)
		self.addChildNode(cargo2)
		
		self.addChildNode(gate)
	}
	
	func connectPaths()
	{
		loiqe_spawn.connect(loiqe_landing)
		loiqe_landing.connect(loiqe_city)
		loiqe_telescope.connect(loiqe_waypoint)
		
		venic_city.connect(venic_waypoint)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}