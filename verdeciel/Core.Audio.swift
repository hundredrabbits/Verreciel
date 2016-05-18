
//  Created by Devine Lu Linvega on 2015-11-30.
//  Copyright (c) 2016 XXIIVV. All rights reserved

import SceneKit
import AVFoundation
import Foundation

class CoreAudio
{
	var ambience_player:AVAudioPlayer!
	var sound_player:AVAudioPlayer!
	var record_player:AVAudioPlayer!
	
	init()
	{
		ambience_player = AVAudioPlayer()
		sound_player = AVAudioPlayer()
		record_player = AVAudioPlayer()
	}
	
	var lastTimeSound:Float = 0
	
	func playSound(soundName:String)
	{
		if game.time < lastTimeSound + 5 { return }
		
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
	
	var ambientTrack:String! = nil
	
	func playAmbience(ambientName:String)
	{
		if ambientTrack != nil && ambientTrack == ambientName { return }
		
		let coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(ambientName, ofType: "mp3")!)
		do{
			ambience_player = try AVAudioPlayer(contentsOfURL:coinSound)
			ambience_player.prepareToPlay()
			ambience_player.play()
			ambience_player.numberOfLoops = -1
			ambience_player.volume = 1
			ambientTrack = ambientName
		}catch {
			print("Error getting the audio file")
		}
	}
	
	func stopAmbient()
	{
		if ambientTrack == nil { return }
	
		ambience_player = AVAudioPlayer()
		ambientTrack = nil
	}
	
	var recordTrack:String! = nil
	
	func playRecord(recordName:String)
	{
		if recordTrack != nil && recordTrack == recordName { return }
		
		let coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(recordName, ofType: "mp3")!)
		do{
			record_player = try AVAudioPlayer(contentsOfURL:coinSound)
			record_player.prepareToPlay()
			record_player.play()
			record_player.numberOfLoops = -1
			record_player.volume = 1
			recordTrack = recordName
		}catch {
			print("Error getting the audio file")
		}
	}
	
	func stopRecord()
	{
		if recordTrack == nil { return }
		
		record_player = AVAudioPlayer()
		recordTrack = nil
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
