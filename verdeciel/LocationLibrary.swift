//
//  LocationLibrary.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-10-07.
//  Copyright © 2015 XXIIVV. All rights reserved.
//

import UIKit

class LocationLibrary
{
	func loiqeCity(at:CGPoint) -> eventTrade
	{
		let location = eventTrade(name: "Loiqe City", want:itemLibrary.loiqeLicense, give:itemLibrary.smallBattery)
		location.addService(services.electricity)
		location.at = at
		return location
	}
}