//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class SceneButton extends Empty {
  constructor (host, name, text, operation, width = 0.65) {
    super()
    this.text = text
    this.host = host
    this.operation = operation

    this.trigger = new SceneTrigger(this, 'button_' + name, 2, 0.5, 2)
    this.trigger.add(
      new SceneLine(
        [
          new THREE.Vector3(-width, -0.25, 0),
          new THREE.Vector3(width, -0.25, 0),
          new THREE.Vector3(-width, 0.25, 0),
          new THREE.Vector3(width, 0.25, 0),
          new THREE.Vector3(-width, 0.25, 0),
          new THREE.Vector3(-width - 0.25, 0, 0),
          new THREE.Vector3(-width, -0.25, 0),
          new THREE.Vector3(-width - 0.25, 0, 0),
          new THREE.Vector3(width, 0.25, 0),
          new THREE.Vector3(width + 0.25, 0, 0),
          new THREE.Vector3(width, -0.25, 0),
          new THREE.Vector3(width + 0.25, 0, 0)
        ],
        verreciel.red
      )
    )
    this.add(this.trigger)

    this.label = new SceneLabel(this.text, 0.1, Alignment.center)
    this.add(this.label)
  }

  enable (newText = this.text, outline = verreciel.cyan) {
    this.text = newText
    this.label.updateText(this.text, verreciel.white)
    this.trigger.enable()
    this.trigger.updateChildrenColors(outline)
  }

  disable (newText = this.text, outline = verreciel.red) {
    this.text = newText
    this.label.updateText(this.text, verreciel.grey)
    this.trigger.updateChildrenColors(outline)
    this.trigger.disable()
  }

  touch (id = 0) {
    verreciel.music.playEffect('click3')
    return this.host.touch(this.operation)
  }
}
