//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNLabel : Empty
{
	var activeText = String()
	var activeScale:Float = 0.2
	var activeAlignment:alignment!
	var nodeOffset:Empty = Empty()
	var color:UIColor = UIColor.whiteColor()
	
	init(text:String = "",scale:Float = 0.1,align:alignment = alignment.left, color:UIColor = white)
	{
		super.init()
		
		self.color = color
		activeText = text
		activeScale = scale
		activeAlignment = align
		
		addLetters(activeText,scale:activeScale)
		adjustAlignment()
		
		self.addChildNode(nodeOffset)
	}
	
	func adjustAlignment()
	{
		if activeAlignment == alignment.center {
			let wordLength = Float(activeText.characters.count) * (activeScale * 1.5)
			nodeOffset.position = SCNVector3(x: (-wordLength/2), y: 0, z: 0)
		}
		else if activeAlignment == alignment.right {
			let wordLength = Float(activeText.characters.count) * (activeScale * 1.5)
			nodeOffset.position = SCNVector3(x: -wordLength + (activeScale * 0.5), y: 0, z: 0)
		}
	}
	
	func addLetters(text:String,scale:Float)
	{
		var letterPos:Float = 0
		var linePos:Float = 0
		for letterCur in text.characters
		{
			if letterCur == "$" { linePos += 1 ; letterPos = 0 ; continue }
			let letterNode = letter(String(letterCur),scale:scale)
			letterNode.position = SCNVector3(x: (scale * 1.5) * Float(letterPos), y: scale * linePos * -4.15, z: 0)
			nodeOffset.addChildNode(letterNode)
			letterPos += 1
		}
	}
	
	func removeLetters()
	{
		for letterCur in nodeOffset.childNodes {
			letterCur.removeFromParentNode()
		}
	}
	
	func update(text:String, force:Bool = false, color:UIColor)
	{
		if text == activeText && color == self.color && force == false { return }
		removeLetters()
		activeText = text
		self.color = color
		addLetters(activeText, scale: activeScale)
		adjustAlignment()
	}
	
	func update(color:UIColor, force:Bool = false)
	{
		if self.color == color { return }
		self.color = color
		removeLetters()
		addLetters(activeText, scale: activeScale)
		adjustAlignment()
	}
	
	func update(text:String)
	{
		if text == activeText { return }
		removeLetters()
		activeText = text
		addLetters(activeText, scale: activeScale)
		adjustAlignment()
	}
	
	func updateScale(scale:Float)
	{
		activeScale = scale
		removeLetters()
		addLetters(activeText, scale: activeScale)
		adjustAlignment()		
	}
	
	func updateColor(color:UIColor)
	{
		if self.color == color { return }
		self.color = color
		removeLetters()
		addLetters(activeText, scale: activeScale)
		adjustAlignment()
	}
	
	func letter(letter:String,scale:Float) -> Empty
	{		
		let letterPivot = Empty()
		
		let letter = letter.lowercaseString
		
		if letter == "a"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "b"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "c"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "d"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "e"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)],color:self.color))
		}
		else if letter == "f"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)],color:self.color))
		}
		else if letter == "g"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)],color:self.color))
		}
		else if letter == "h"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "i"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "j"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "k"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "l"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "m"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0)],color:self.color))
		}
		else if letter == "n"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "o"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0),SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)],color:self.color))
		}
		else if letter == "p"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0)],color:self.color))
		}
		else if letter == "q"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "r"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "s"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "t"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "u"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)],color:self.color))
		}
		else if letter == "v"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)],color:self.color))
		}
		else if letter == "w"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "x"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)],color:self.color))
		}
		else if letter == "y"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "z"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "1"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "2"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "3"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "4"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "5"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "6"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0)],color:self.color))
		}
		else if letter == "7"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "8"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "9"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)],color:self.color))
		}
		else if letter == "0"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:self.color))
		}
		else if letter == ":"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: scale/2, y: scale/2, z: 0), SCNVector3(x: scale/2, y: -scale/2, z: 0)],color:self.color))
		}
		else if letter == " "{
			
		}
		else if letter == "~"{
			
		}
		else if letter == "/"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)],color:self.color))
		}
		else if letter == "-"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)],color:self.color))
		}
		else if letter == "+"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)],color:self.color))
		}
		else if letter == ">"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: 0, z: 0)],color:self.color))
		}
		else if letter == "<"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: 0, z: 0)],color:self.color))
		}
		else if letter == ","{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "."{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)],color:self.color))
		}
		else if letter == "'"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0)],color:self.color))
		}
		else if letter == "%"{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)],color:self.color))
		}
		else{
			letterPivot.addChildNode(SCNLine(vertices: [SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)],color:red))
		}

		return letterPivot
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}