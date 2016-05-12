
//  Created by Devine Lu Linvega on 2015-12-15.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class WidgetRadio : Widget
{
	var time:NSTimer!
	var seek:Int = 0
	
	override init()
	{
		super.init()
		
		name = "radio"
		details = "[missing text]"
		requirement = ItemTypes.record
		isPowered = { battery.isRadioPowered() }
		
		label.update(name!)
	}
	
	func isPlaying() -> Bool
	{
		if port.hasItemOfType(.record) { return true }
		return false
	}
	
	override func onPowered()
	{
		super.onPowered()
		if port.hasItemOfType(.record) {
			play()
		}
	}
	
	override func onUnpowered()
	{
		super.onUnpowered()
		stop()
	}
	
	func play()
	{
//		audio.playAmbient(port.event.name!)
	}
	
	func stop()
	{
		audio.stopAmbient()
	}
	
	override func onUploadComplete()
	{
		super.onUploadComplete()
		
		print("!!!!!!!!!")
	}
	
	override func onInstallationBegin()
	{
		super.onInstallationBegin()
		
		player.lookAt(deg: 0)
	}
	
	override func onInstallationComplete()
	{
		super.onInstallationComplete()
		
		battery.installRadio()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}