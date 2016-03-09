
//  Created by Devine Lu Linvega on 2014-09-21.
//  Copyright (c) 2014 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit

var sceneView:SCNView!
var scene = SCNScene()
var touchOrigin = CGPoint()
var touchPosition = CGPoint()

class GameViewController: UIViewController, SCNSceneRendererDelegate
{
    override func viewDidLoad()
	{
		super.viewDidLoad()
		
		create()
		initialize()
		start()
	}
	
	func create()
	{
		sceneView = self.view as! SCNView
		sceneView.scene = scene
		sceneView.showsStatistics = false
		sceneView.backgroundColor = UIColor.blackColor()
		sceneView.antialiasingMode = SCNAntialiasingMode.None
		sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
		sceneView.preferredFramesPerSecond = 25
		sceneView.playing = true

		sceneView.delegate = self
	}
	
	func initialize()
	{
		universe = CoreUniverse()
		
		capsule = CoreCapsule()
		scene.rootNode.addChildNode(capsule)
		
		player = CorePlayer()
		scene.rootNode.addChildNode(player)
		
		space = CoreSpace()
		scene.rootNode.addChildNode(space)
		
		ui = CoreUI()
		scene.rootNode.addChildNode(ui)
		
		time = CoreTime()
		game = CoreGame()
	}
	
	func start()
	{
		universe._start()
		capsule._start()
		player._start()
		space._start()
		ui._start()
		
		time.start()
		game.start()
		
		settings.applicationIsReady = true
		
//		unlockedState(universe.loiqe_city)
		startingState()
	}
	
	func startingState()
	{
		debug.isActive = false
		
		capsule.start(universe.loiqe_spawn)
		battery.cellPort1.addEvent(items.cell1)
	}
	
	func unlockedState(location:Location = universe.loiqe_horadric)
	{
		debug.isActive = true
		
		universe.unlock(.loiqe)
		universe.unlock(.valen)
		universe.unlock(.senni)
		universe.unlock(.usul)
		
		pilot.install()
		radar.install()
		cargo.install()
		hatch.install()
		mission.install()
		console.install()
		
		radio.install()
		enigma.install()
		map.install()
		shield.install()

		exploration.install()
		journey.install()
		progress.install()
		complete.install()
		
		capsule.start(location)
		
		cargo.addItems([items.valenPortalKey, items.materia, items.credit])
		
		battery.cellPort1.addEvent(items.cell1)
		battery.cellPort1.connect(battery.thrusterPort)
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		for touch: AnyObject in touches {
			touchOrigin = touch.locationInView(self.view)
		}
		
		player.canAlign = false
		ui.canAlign = false
	}
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		for touch: AnyObject in touches {
			touchPosition = touch.locationInView(self.view)
		}
		
		let dragX = CGFloat(touchPosition.x - touchOrigin.x)
		let dragY = CGFloat(touchPosition.y - touchOrigin.y)
		
		touchOrigin = touchPosition

        player.accelY += Float(degToRad(dragX/6))
        player.accelX += Float(degToRad(dragY/6))
		
		ui.accelX += Float(degToRad(dragY/6)) * 0.975
        ui.accelY += Float(degToRad(dragX/6)) * 0.95
        
		ui.updatePort()
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		player.canAlign = true
		ui.canAlign = true
		ui.updatePort()
	}
	
	func handleTap(gestureRecognize: UIGestureRecognizer)
	{
		let p = gestureRecognize.locationInView(sceneView)
		
		let hitResults = sceneView.hitTest(p, options: nil)
		
		if hitResults.count > 0
		{
			let result: AnyObject! = hitResults[0]
			result.node.touch()
		}
		game.update()
	}
	
	func renderer(renderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval)
	{
		capsule.fixedUpdate()
		player.fixedUpdate()
		ui.fixedUpdate()
		
		space.fixedUpdate()
		ui.updatePort()
	}
	
	override func prefersStatusBarHidden() -> Bool
	{
		return true
	}
}