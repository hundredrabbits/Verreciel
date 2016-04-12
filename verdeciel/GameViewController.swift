
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
		sceneView.backgroundColor = UIColor.blackColor()
		sceneView.antialiasingMode = SCNAntialiasingMode.None
		sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
		sceneView.preferredFramesPerSecond = 25
		sceneView.playing = true
		
		sceneView.showsStatistics = true

		sceneView.delegate = self
	}
	
	func initialize()
	{
		universe = CoreUniverse()
		
		game = CoreGame()
		
		player = CorePlayer()
		scene.rootNode.addChildNode(player)
		
		capsule = CoreCapsule()
		scene.rootNode.addChildNode(capsule)
		
		space = CoreSpace()
		scene.rootNode.addChildNode(space)
		
		helmet = Helmet()
		scene.rootNode.addChildNode(helmet)
	}
	
	func start()
	{
		game.start()
		
		unlockedState(universe.loiqe_city, newItems:[Item(like: items.currency1), items.map1])
//		startingState()
	}
	
	func startingState()
	{
		capsule.start(universe.loiqe_spawn)
		battery.cellPort1.addEvent(items.battery1)
	}
	
	func unlockedState(location:Location = universe.senni_station, newItems:Array<Item> = [])
	{
		universe.unlock(.loiqe)
		universe.unlock(.valen)
		universe.unlock(.senni)
		universe.unlock(.usul)
		
		pilot.install()
		radar.install()
		cargo.install()
		hatch.install()
		intercom.install()
		console.install()
		thruster.install()
		
		radio.install()
		enigma.install()
		map.install()
		shield.install()

		exploration.install()
		journey.install()
		progress.install()
		completion.install()
		
		capsule.start(location)
		
		universe.valen_portal.isKnown = true
		universe.loiqe_portal.isKnown = true
		universe.senni_portal.isKnown = true
		
		cargo.addItems(newItems)
		
		battery.cellPort1.addEvent(items.battery1)
		battery.cellPort1.connect(battery.thrusterPort)
//		battery.cellPort2.addEvent(items.battery3)
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		for touch: AnyObject in touches {
			touchOrigin = touch.locationInView(self.view)
		}
		
		player.canAlign = false
		helmet.canAlign = false
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

        player.accelY += (degToRad(dragX/6))
        player.accelX += (degToRad(dragY/6))
        
		helmet.updatePort()
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player.isLocked == true { return }
		
		player.canAlign = true
		helmet.canAlign = true
		helmet.updatePort()
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
	}
	
	func renderer(renderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval)
	{
		glLineWidth(1)
		
		capsule.whenRenderer()
		player.whenRenderer()
		helmet.whenRenderer()
		
		space.whenRenderer()
		helmet.whenRenderer()
	}
	
	override func prefersStatusBarHidden() -> Bool
	{
		return true
	}
}