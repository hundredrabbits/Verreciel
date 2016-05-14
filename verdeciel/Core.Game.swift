
//  Created by Devine Lu Linvega on 2015-12-18.
//  Copyright © 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class CoreGame
{
	var time:Float = 0
	let memory = NSUserDefaults.standardUserDefaults()
	
	init()
	{
		print("^ Game | Init")
		NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(self.onTic), userInfo: nil, repeats: true)
		NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.whenSecond), userInfo: nil, repeats: true)
	}
	
	func whenStart()
	{
		print("+ Game | Start")
	
		load(memory.integerForKey("state"))
	}
	
	func save(id:Int)
	{
		print("@ GAME     | Saved State to \(id)")
		memory.setValue(id, forKey: "state")
		memory.setValue(version, forKey: "version")
	}
	
	func load(id:Int)
	{
		let id = (id == 20) ? 0 : id
		
		print("@ GAME     | Loaded State to \(id)")
		
		for mission in missions.story {
			if mission.id < id {
				mission.complete()
			}
		}
		missions.story[id].state()
	}
	
	func erase()
	{
		print("$ GAME     | Erase")
		
		let appDomain = NSBundle.mainBundle().bundleIdentifier!
		NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
	}
	
    var needsSecond = false
    var needsTic = false
    
	@objc func whenSecond()
	{
        self.needsSecond = true
	}
	
	@objc func onTic()
	{
        self.needsTic = true
	}
    
    func doSecond()
    {
        if self.needsSecond == true
        {
            self.needsSecond = false
            capsule.whenSecond()
            missions.refresh()
        }
    }
    
    func doTic()
    {
        if self.needsTic == true
        {
            self.needsTic = false
            self.time += 1
            space.whenTime()
        }
    }
}