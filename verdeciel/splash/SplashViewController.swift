
//  Created by Devine Lu Linvega on 2015-11-12.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.

// - Assign to a blank view controller
// - Set Storyboard ID of main view controller to "Main"
// - Update .name parameter of SplashViewController
// - Go!

import UIKit
import SpriteKit
import AVFoundation

class SplashViewController: UIViewController
{
	let name:String = "Verreciel"
	let skip:Bool = true
	
	var logo:UIImageView!
	var blink:UIView!
	var button:UIButton!
	
	override func viewDidLoad()
	{
		if skip == true { exit() ; return }
		
		self.view.backgroundColor = .blackColor()
		
		// Logo
		
		logo = UIImageView(frame:CGRectMake((view.frame.width/2) - (view.frame.height/4/2), (view.frame.height/2) - (view.frame.height/4/2) - 10, (view.frame.height/4), (view.frame.height/4)))
		logo.image = UIImage(named:"SplashLogo.png")
		logo.contentMode = .ScaleAspectFit
		logo.alpha = 0
		self.view.addSubview(logo)
		
		UIView.animateWithDuration(2) {
			self.logo.alpha = 1
			self.logo.frame.origin.y -= 10
		}
		
		// Blink
		
		blink = UIView(frame: CGRect(x: (view.frame.width/2) - 3, y: (view.frame.height) - 60, width: 6, height: 6))
		blink.clipsToBounds = true
		blink.layer.cornerRadius = 3
		blink.backgroundColor = .whiteColor()
		blink.alpha = 0
		self.view.addSubview(blink)
		
		// Button
		
		button = UIButton(frame: CGRect(x: (view.frame.width/2) - 50, y: (view.frame.height) - 110, width: 100, height: 100))
		button.backgroundColor = .redColor()
		button.alpha = 0.5
		button.addTarget(self, action: #selector(self.support), forControlEvents:.TouchUpInside)
		self.view.addSubview(button)
		
		// Start
		
		NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(self.flash), userInfo: nil, repeats: false)
		NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.exit), userInfo: nil, repeats: false)
		
		playTheme("SplashTune")
	}
	
	func flash()
	{
		blink.alpha = (blink.alpha == 1) ? 0 : 1
		NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(self.flash), userInfo: nil, repeats: false)
	}
	
	func support()
	{
		UIApplication.sharedApplication().openURL(NSURL(string: "http://wiki.xxiivv.com/\(name)")!)
	}
	
	// MARK: Audio -
	
	var player = AVAudioPlayer()
	
	func playTheme(name:String) {
		
		let url:NSURL = NSBundle.mainBundle().URLForResource(name, withExtension: "wav")!
		
		do { player = try AVAudioPlayer(contentsOfURL: url, fileTypeHint: nil) }
		catch let error as NSError { print(error.description) }
		
		player.numberOfLoops = 0
		player.prepareToPlay()
		player.play()
	}
	
	// MARK: Exit -
	
	func exit()
	{
		let transition: CATransition = CATransition()
		transition.duration = 0.4
		transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		transition.type = kCATransitionFade
		self.navigationController!.view.layer.addAnimation(transition, forKey: nil)
		
		let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Main") as! MainViewController
		self.navigationController?.pushViewController(vc, animated: false)
	}
	
	// MARK: Misc -
	
	override func prefersStatusBarHidden() -> Bool
	{
		return true
	}
}