
//  Created by Devine Lu Linvega on 2015-11-30.
//  Copyright © 2015 XXIIVV. All rights reserved

import SceneKit
import AVFoundation
import Foundation

class CoreAudio
{
	var ambient_player = AVAudioPlayer()
	var sound_player = AVAudioPlayer()
	
	init()
	{
		
	}
	
	func playSound(soundName:String)
	{
		print(" AUDIO - Sound: \(soundName)")
		
		let coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("\(soundName)", ofType: "wav")!)
		do{
			sound_player = try AVAudioPlayer(contentsOfURL:coinSound)
			sound_player.prepareToPlay()
			sound_player.play()
			//			sound_player.numberOfLoops = -1
		}catch {
			print("Error getting the audio file")
		}
	}
	
	func playAmbient(ambientName:String)
	{
		print(" AUDIO - Ambient: \(ambientName)")
		
		let coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("sound.\(ambientName)", ofType: "mp3")!)
		do{
			ambient_player = try AVAudioPlayer(contentsOfURL:coinSound)
			ambient_player.prepareToPlay()
			ambient_player.play()
			sound_player.numberOfLoops = -1
		}catch {
			print("Error getting the audio file")
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}