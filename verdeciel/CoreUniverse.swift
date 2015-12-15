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
		addVenic()
		addValen()
		addSenni()
		addFalvet()
		
		connectPaths()
		connectPortals()
	}
	
	// MARK: Loiqe -
	
	var loiqe = locations.loiqe.star()
	var loiqe_spawn = locations.loiqe.spawn()
	var loiqe_landing = locations.loiqe.landing()
	var loiqe_city = locations.loiqe.city()
	var loiqe_horadric = locations.loiqe.horadric()
	var loiqe_portal = locations.loiqe.portal()
	var loiqe_cargo = locations.loiqe.satellite()
	
	func addLoiqe()
	{
		addChildNode(loiqe)
		addChildNode(loiqe_spawn)
		addChildNode(loiqe_landing)
		addChildNode(loiqe_city)
		addChildNode(loiqe_horadric)
		addChildNode(loiqe_portal)
		addChildNode(loiqe_cargo)
	}
	
	// MARK: Usul -
	
	var usul = locations.usul.star()
	var usul_city = locations.usul.city()
	var usul_portal = locations.usul.portal()
	
	func addUsul()
	{
		addChildNode(usul)
		addChildNode(usul_city)
		addChildNode(usul_portal)
	}
	
	// MARK: Valen -
	
	var valen = locations.valen.star()
	var valen_bank = locations.valen.bank()
	var valen_telescope = locations.valen.telescope()
	var valen_portal = locations.valen.portal()
	var valen_satellite = locations.valen.satellite()
	
	func addValen()
	{
		addChildNode(valen)
		addChildNode(valen_bank)
		addChildNode(valen_telescope)
		addChildNode(valen_portal)
		addChildNode(valen_satellite)
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
	var senni_station = locations.senni.portal()
	var senni_telescope = locations.senni.telescope()
	var senni_portal = locations.senni.portal()
	var senni_service = locations.senni.service()
	var senni_spawn = locations.senni.spawn()
	
	func addSenni()
	{
		addChildNode(senni)
		addChildNode(senni_city)
		addChildNode(senni_station)
		addChildNode(senni_telescope)
		addChildNode(senni_portal)
		addChildNode(senni_service)
		addChildNode(senni_spawn)
	}
	
	// MARK: Falvet -
	
	var falvet = locations.falvet.star()
	var falvet_toUsul = locations.falvet.toUsul()
	var falvet_toSenni = locations.falvet.toSenni()
	var falvet_toValen = locations.falvet.toValen()
	var falvet_toLoiqe = locations.falvet.toLoiqe()
	
	var falvet_service1 = locations.falvet.service1()
	var falvet_service2 = locations.falvet.service2()
	var falvet_service3 = locations.falvet.service3()
	var falvet_service4 = locations.falvet.service4()
	
	func addFalvet()
	{
		addChildNode(falvet)
		addChildNode(falvet_toUsul)
		addChildNode(falvet_toSenni)
		addChildNode(falvet_toValen)
		addChildNode(falvet_toLoiqe)
		
		addChildNode(falvet_service1)
		addChildNode(falvet_service2)
		addChildNode(falvet_service3)
		addChildNode(falvet_service4)
	}
	
	// MARK: Misc -
	
	func connectPortals()
	{		
		usul_portal.addPortals(loiqe_portal, left: senni_portal)
		senni_portal.addPortals(usul_portal, left: valen_portal)
		valen_portal.addPortals(senni_portal, left: loiqe_portal)
		loiqe_portal.addPortals(valen_portal, left: usul_portal)
	}
	
	func connectPaths()
	{
		loiqe_landing.connect(loiqe_city)
		loiqe_city.connect(loiqe_horadric)
		loiqe_horadric.connect(loiqe_portal)
		loiqe_portal.connect(falvet_toLoiqe)
		
		venic_city.connect(venic_waypoint)
		
		falvet_toUsul.connect(usul_portal)
		falvet_toValen.connect(valen_portal)
		falvet_toSenni.connect(senni_portal)
		
		valen_telescope.connect(venic_waypoint)
		valen_bank.connect(valen_portal)
		valen_satellite.connect(valen_bank)
		
		falvet_service1.connect(falvet_toValen)
		falvet_service2.connect(falvet_toSenni)
		falvet_service3.connect(falvet_toLoiqe)
		falvet_service4.connect(falvet_toUsul)
		
		senni_telescope.connect(senni_service)
		senni_spawn.connect(senni_portal)
		senni_service.connect(senni_portal)
		senni_portal.connect(senni_portal)
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
	
	override func _start()
	{
		valen_bank.port1.addEvent(items.loiqePortalKey)
		valen_bank.port2.addEvent(items.waste)
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}