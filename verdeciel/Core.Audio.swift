
//  Created by Devine Lu Linvega on 2015-11-30.
//  Copyright © 2015 XXIIVV. All rights reserved

import SceneKit
import AVFoundation
import Foundation

class CoreAudio
{
	var ambience_player = AVAudioPlayer()
	var sound_player = AVAudioPlayer()
	
	init()
	{
		
	}
	
	var lastTimeSound:Float = 0
	
	func playSound(soundName:String)
	{
		print(" AUDIO - Sound: \(soundName)")
		
		if lastTimeSound == game.time { print("silenced") ; return }
		
		let coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundName, ofType: "wav")!)
		do{
			sound_player = try AVAudioPlayer(contentsOfURL:coinSound)
			sound_player.prepareToPlay()
			sound_player.play()
			lastTimeSound = game.time
			//			sound_player.numberOfLoops = -1
		}catch {
			print("Error getting the audio file")
		}
	}
	
	func playAmbience(ambientName:String)
	{
		print(" AUDIO - Ambience: \(ambientName)")
		
		let coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(ambientName, ofType: "mp3")!)
		do{
			ambience_player = try AVAudioPlayer(contentsOfURL:coinSound)
			ambience_player.prepareToPlay()
			ambience_player.play()
			ambience_player.numberOfLoops = -1
			ambience_player.volume = 1
		}catch {
			print("Error getting the audio file")
		}
	}
	
	func stopAmbient()
	{
		print(" AUDIO - Ambient: Stop!")
		ambience_player.volume = 0
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}