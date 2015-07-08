//
//  displayNode.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-06-22.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class SCNLabel : SCNNode
{
	var activeText = String()
	var activeScale:Float = 0.2
	var activeAlignment:alignment!
	
	var nodeOffset:SCNNode!
	
	init(text:String,scale:Float,align:alignment)
	{
		super.init()
		
		activeText = text
		activeScale = scale
		activeAlignment = align
		nodeOffset = SCNNode()
		
		addLetters(activeText,scale:activeScale)
		adjustAlignment()
		
		self.addChildNode(nodeOffset)
	}
	
	func adjustAlignment()
	{
		if activeAlignment == alignment.center {
			let wordLength = Float(Array(activeText).count) * (activeScale * 1.5) * -1
			nodeOffset.position = SCNVector3(x: wordLength/2, y: 0, z: 0)
		}
		else if activeAlignment == alignment.right {
			let wordLength = Float(Array(activeText).count) * (activeScale * 1.5) * -1
			nodeOffset.position = SCNVector3(x: wordLength, y: 0, z: 0)
		}
	}
	
	func addLetters(text:String,scale:Float)
	{
		let characters = Array(text)
		
		var letterPos = 0
		for letterCur in characters
		{
			var letterNode = letter(String(letterCur),scale:scale)
			letterNode.position = SCNVector3(x: (scale * 1.5) * Float(letterPos), y: 0, z: 0)
			nodeOffset.addChildNode(letterNode)
			
			letterPos += 1
		}
	}
	
	func removeLetters()
	{		
		activeText = ""
		for letterCur in nodeOffset.childNodes {
			letterCur.removeFromParentNode()
		}
	}
	
	func update(text:String)
	{
		if text == activeText { return }
		
		removeLetters()
		activeText = text
		addLetters(activeText, scale: activeScale)
	}
	
	func letter(letter:String,scale:Float) -> SCNNode
	{		
		let letterPivot = SCNNode()
		
		if letter == "a"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "b"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "c"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "d"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "e"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == "f"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == "f"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == "g"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == "h"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "i"
		{
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
		}
		else if letter == "j"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
		}
		else if letter == "k"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "l"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "m"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0)))
		}
		else if letter == "n"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "o"
		{
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: 0, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
		}
		else if letter == "p"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
		}
		else if letter == "r"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			
		}
		else if letter == "s"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			
		}
		else if letter == "t"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
			
		}
		else if letter == "u"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
		}
		else if letter == "v"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
		}
		else if letter == "w"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
		}
		else if letter == "x"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			
		}
		else if letter == "y"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
			
		}
		else if letter == "1"{
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
			
		}
		else if letter == "2"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "3"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			
		}
		else if letter == "4"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "5"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "6"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: -scale, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
		}
		else if letter == "7"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "8"
		{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == "9"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == "0"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
		}
		else if letter == " "{
			
		}
		else if letter == "-"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == ">"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: 0, z: 0)))
		}
		else if letter == ","{
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
		}
		else if letter == "."{
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: 0, z: 0), SCNVector3(x: scale/2, y: -scale, z: 0)))
		}
		else if letter == "'"{
			letterPivot.addChildNode(line(SCNVector3(x: scale/2, y: scale, z: 0), SCNVector3(x: scale/2, y: 0, z: 0)))
		}
		else if letter == "%"{
			letterPivot.addChildNode(line(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: 0, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: 0, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(line(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
		}
		else{
			letterPivot.addChildNode(redLine(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: 0, y: -scale, z: 0)))
			letterPivot.addChildNode(redLine(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: scale, z: 0)))
			letterPivot.addChildNode(redLine(SCNVector3(x: 0, y: -scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(redLine(SCNVector3(x: 0, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			letterPivot.addChildNode(redLine(SCNVector3(x: scale, y: scale, z: 0), SCNVector3(x: scale, y: -scale, z: 0)))
			
		}

		return letterPivot
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}