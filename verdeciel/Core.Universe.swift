//  Created by Devine Lu Linvega on 2015-07-18.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreUniverse : Empty
{
	override init()
	{
		super.init()
		
		print("@ UNIVERSE | Init")
		
		addLoiqe()
		addUsul()
		addValen()
		addSenni()
		
		connectPaths()
	}
		
	// MARK: Loiqe -
	
	var loiqe = locations.loiqe.star()
	var loiqe_spawn = locations.loiqe.spawn()
	var loiqe_harvest = locations.loiqe.harvest()
	var loiqe_city = locations.loiqe.city()
	var loiqe_horadric = locations.loiqe.horadric()
	var loiqe_portal = locations.loiqe.portal()
	var loiqe_satellite = locations.loiqe.satellite()
	var loiqe_port = locations.loiqe.port()
	// MARK: Fog
	var loiqe_fog = locations.loiqe.fog()
	var loiqe_transit = locations.loiqe.transit()
	var loiqe_c_1 = locations.loiqe.c_1()
	
	func addLoiqe()
	{
		addChildNode(loiqe)
		addChildNode(loiqe_spawn)
		addChildNode(loiqe_harvest)
		addChildNode(loiqe_city)
		addChildNode(loiqe_horadric)
		addChildNode(loiqe_portal)
		addChildNode(loiqe_satellite)
		addChildNode(loiqe_port)
		// Fog
		addChildNode(loiqe_transit)
		addChildNode(loiqe_fog)
		addChildNode(loiqe_transit)
		// Constellations
		addChildNode(loiqe_c_1)
	}
	
	// MARK: Valen -
	
	var valen = locations.valen.star()
	var valen_bank = locations.valen.bank()
	var valen_station = locations.valen.station()
	var valen_portal = locations.valen.portal()
	var valen_harvest = locations.valen.harvest()
	var valen_cargo = locations.valen.cargo()
	// MARK: Fog
	var valen_transit = locations.valen.transit()
	var valen_fog = locations.valen.fog()
	var valen_beacon = locations.valen.beacon()
	var valen_c_1 = locations.valen.c_1()
	// MARK: Blind
	var valen_void = locations.valen.void()
	
	func addValen()
	{
		addChildNode(valen)
		addChildNode(valen_bank)
		addChildNode(valen_station)
		addChildNode(valen_portal)
		addChildNode(valen_harvest)
		addChildNode(valen_cargo)
		// Fog
		addChildNode(valen_transit)
		addChildNode(valen_fog)
		addChildNode(valen_c_1)
		// Blind
		addChildNode(valen_void)
	}
	
	// MARK: Senni -
	
	var senni = locations.senni.star()
	var senni_station = locations.senni.station()
	var senni_cargo = locations.senni.cargo()
	var senni_portal = locations.senni.portal()
	var senni_harvest = locations.senni.harvest()
	// MARK: Fog
	var senni_transit = locations.senni.transit()
	var senni_horadric = locations.senni.horadric()
	var senni_fog = locations.senni.fog()
	var senni_wreck = locations.senni.wreck()
	// MARK: Blind
	var senni_bog = locations.senni.bog()
	
	func addSenni()
	{
		addChildNode(senni)
		addChildNode(senni_station)
		addChildNode(senni_portal)
		addChildNode(senni_cargo)
		addChildNode(senni_harvest)
		// Fog
		addChildNode(senni_transit)
		addChildNode(senni_horadric)
		addChildNode(senni_fog)
		addChildNode(senni_wreck)
		// Blind
		addChildNode(senni_bog)
	}
	
	// MARK: Usul -
	
	var usul = locations.usul.star()
	var usul_portal = locations.usul.portal()
	// MARK: Fog
	var usul_transit = locations.usul.transit()
	var usul_station = locations.usul.station()
	var usul_telescope = locations.usul.telescope()
	// MARK: Blind
	var usul_silence = locations.usul.silence()
	
	func addUsul()
	{
		addChildNode(usul)
		
		addChildNode(usul_portal)
		// Fog
		addChildNode(usul_station)
		addChildNode(usul_transit)
		addChildNode(usul_telescope)
		// Blind
		addChildNode(usul_silence)
	}
	
	func connectPaths()
	{
		loiqe_city.connect(loiqe_satellite)
		loiqe_satellite.connect(loiqe_portal)
		loiqe_horadric.connect(loiqe_satellite)
		loiqe_fog.connect(loiqe_port)
		
		valen_bank.connect(valen_portal)
		valen_station.connect(valen_bank)
		valen_harvest.connect(valen_bank)
		valen_fog.connect(valen_portal)
		valen_beacon.connect(valen_fog)
		
		senni_portal.connect(senni_cargo)
		senni_cargo.connect(senni_portal)
		senni_station.connect(senni_portal)
		senni_fog.connect(senni_station)
		senni_horadric.connect(senni_harvest)
		
		usul_station.connect(usul_portal)
		usul_telescope.connect(usul_portal)
		
		// Transits
		
		usul_transit.connect(loiqe_transit)
		loiqe_transit.connect(valen_transit)
		valen_transit.connect(senni_transit)
		senni_transit.connect(usul_transit)
		
		loiqe_portal.connect(loiqe_transit)
		valen_portal.connect(valen_transit)
		senni_portal.connect(senni_transit)
		usul_portal.connect(usul_transit)
	}

	func locationLike(target:Location) -> Location!
	{
		for location in childNodes as! [Location] {
			if location.name == target.name && location.system == target.system { return location }
		}
		
		return nil
	}
	
	func locationWithCode(code:String) -> Location!
	{
		for location in childNodes as! [Location] {
			if location.code == code { return location }
		}
		return nil
	}
	
	// Default
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}