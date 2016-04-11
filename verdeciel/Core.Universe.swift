//  Created by Devine Lu Linvega on 2015-07-18.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreUniverse : SCNNode
{
	override init()
	{
		super.init()
		
		print("@ UNIVERSE | Init")
		
		addLoiqe()
		addUsul()
		addValen()
		addSenni()
		addNevic()
		
		connectPaths()
		connectPortals()
	}
	
	override func _start()
	{
		unlock(.loiqe)
		
		valen_bank.port1.addEvent(items.loiqePortalKey)
		valen_bank.port2.addEvent(items.record1)
		valen_bank.port3.addEvent(Item(like:items.waste))
			
		for location in childNodes {
			location.start()
		}
	}
	
	// MARK: Loiqe -
	
	var loiqe = locations.loiqe.star()
	var loiqe_spawn = locations.loiqe.spawn()
	var loiqe_harvest = locations.loiqe.harvest()
	var loiqe_city = locations.loiqe.city()
	var loiqe_horadric = locations.loiqe.horadric()
	var loiqe_portal = locations.loiqe.portal()
	var loiqe_satellite = locations.loiqe.satellite()
	var loiqe_fog = locations.loiqe.fog()
	var loiqe_gateway = locations.loiqe.gateway()
	var loiqe_c_1 = locations.loiqe.c_1()
//	var loiqe_c_2 = locations.loiqe.c_2()
//	var loiqe_c_3 = locations.loiqe.c_3()
//	var loiqe_c_4 = locations.loiqe.c_4()
	
	func addLoiqe()
	{
		addChildNode(loiqe)
		addChildNode(loiqe_spawn)
		addChildNode(loiqe_harvest)
		addChildNode(loiqe_city)
		addChildNode(loiqe_horadric)
		addChildNode(loiqe_portal)
		addChildNode(loiqe_satellite)
		// Fog
		addChildNode(loiqe_fog)
		// Ghost
		addChildNode(loiqe_gateway)
		// Constellations
		addChildNode(loiqe_c_1)
//		addChildNode(loiqe_c_2)
//		addChildNode(loiqe_c_3)
//		addChildNode(loiqe_c_4)
	}
	
	// MARK: Valen -
	
	var valen = locations.valen.star()
	var valen_bank = locations.valen.bank()
	var valen_station = locations.valen.station()
	var valen_portal = locations.valen.portal()
	var valen_harvest = locations.valen.harvest()
	var valen_port = locations.valen.port()
	var valen_cargo = locations.valen.cargo()
	var valen_fog = locations.valen.fog()
//	var valen_c_1 = locations.valen.c_1()
//	var valen_c_3 = locations.valen.c_3()
//	var valen_c_4 = locations.valen.c_4()
	
	func addValen()
	{
		addChildNode(valen)
		addChildNode(valen_bank)
		addChildNode(valen_station)
		addChildNode(valen_portal)
		addChildNode(valen_harvest)
		addChildNode(valen_port)
		addChildNode(valen_cargo)
		// Fog
		addChildNode(valen_fog)
//		addChildNode(valen_c_1)
//		addChildNode(valen_c_3)
//		addChildNode(valen_c_4)
	}
	
	// MARK: Senni -
	
	var senni = locations.senni.star()
	var senni_station = locations.senni.station()
	var senni_cargo = locations.senni.cargo()
	var senni_portal = locations.senni.portal()
	var senni_harvest = locations.senni.harvest()
	var senni_horadric = locations.senni.horadric()
	var senni_fog = locations.senni.fog()
	
	func addSenni()
	{
		addChildNode(senni)
		addChildNode(senni_station)
		addChildNode(senni_portal)
		addChildNode(senni_cargo)
		addChildNode(senni_harvest)
		// Fog
		addChildNode(senni_horadric)
		addChildNode(senni_fog)
	}
	
	// MARK: Usul -
	
	var usul = locations.usul.star()
	var usul_station = locations.usul.station()
	var usul_portal = locations.usul.portal()
	// Ghost
	var usul_wreck = locations.usul.wreck()
	var usul_cargo = locations.usul.cargo()
	var usul_silence = locations.usul.silence()
	
	func addUsul()
	{
		addChildNode(usul)
		addChildNode(usul_station)
		addChildNode(usul_portal)
		addChildNode(usul_wreck)
		addChildNode(usul_station)
		addChildNode(usul_cargo)
		addChildNode(usul_silence)
	}
	
	// MARK: Nevic -
	
	var nevic = locations.nevic.star()
	var nevic_satellite = locations.nevic.satellite()
	var nevic_gateway = locations.nevic.gateway()
	
	func addNevic()
	{
		addChildNode(nevic)
		addChildNode(nevic_satellite)
		addChildNode(nevic_gateway)
	}

	// MARK: Misc -
	
	func connectPortals()
	{
		loiqe_gateway.addDestination(nevic_gateway)
		nevic_gateway.addDestination(loiqe_gateway)
	}
	
	func connectPaths()
	{
		loiqe_city.connect(loiqe_satellite)
		loiqe_satellite.connect(loiqe_portal)
		loiqe_horadric.connect(loiqe_satellite)
		loiqe_fog.connect(loiqe_city)
		
		valen_bank.connect(valen_portal)
		valen_station.connect(valen_bank)
		valen_harvest.connect(valen_bank)
		valen_port.connect(valen_bank)
		valen_fog.connect(valen_port)
		
		senni_portal.connect(senni_cargo)
		senni_cargo.connect(senni_harvest)
		senni_harvest.connect(senni_station)
		senni_station.connect(senni_portal)
		senni_fog.connect(senni_station)
		senni_horadric.connect(senni_harvest)
		
		usul_wreck.connect(usul_portal)
		
		usul_portal.connect(usul_cargo)
		usul_cargo.connect(usul_silence)
		usul_silence.connect(usul_station)
		usul_station.connect(usul_portal)
	}
	
	func unlock(system:Systems)
	{
		print("! SYSTEM(Unlock) \(system)")
		for location in self.childNodes {
			let location = location as! Location
			if location.system != system { continue }
			print("  > \(location.name!)")
			location.isAccessible = true
		}
	}
	
	func locationLike(target:Location) -> Location!
	{
		for location in childNodes {
			let location = location as! Location
			if location.name == target.name && location.system == target.system { return location }
		}
		
		return nil
	}
	
	// Default
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}