//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Icon extends Empty {
  constructor () {
    // assertArgs(arguments, 0);
    super()

    this.color = new THREE.Vector4(0.5, 0, 0.5, 1) // Haha, weird!
    this.size = 0.1

    this.trigger = new Empty()
    this.mesh = new Empty()
    this.label = new SceneLabel('', 0.06, Alignment.center, verreciel.grey)
    this.label.position.set(0, -0.3, -0.35)
    this.add(this.label)

    this.wire = new SceneLine([], verreciel.grey)
    this.wire.position.set(0, 0, -0.01)
    this.wire.hide()
    this.add(this.wire)

    this.add(this.mesh)
    this.add(this.label)
    this.add(this.trigger)
    this.add(this.wire)

    this.marker = new Empty()
    this.marker.add(new SceneLine([
      new THREE.Vector3(0, this.size * 3, 0),
      new THREE.Vector3(0, this.size * 4, 0)
      ], verreciel.cyan)
    )
  }

  addHost (host) {
    // assertArgs(arguments, 1);
    this.host = host
    this.label.updateText(this.host.name)
  }

  whenStart () {
    // assertArgs(arguments, 0);
    super.whenStart()

    if (this.host.mapRequirement != null) {
      this.label.color = verreciel.cyan
      this.add(this.marker)
    }
  }

  onUpdate () {
    // assertArgs(arguments, 0);
    if (this.host.isComplete == null) {
      this.color = verreciel.white
    } else if (this.host.isComplete == false) {
      this.color = verreciel.red
    } else if (this.host.isComplete == true) {
      this.color = verreciel.cyan
    }

    this.mesh.updateChildrenColors(this.color)
  }

  close () {
    // assertArgs(arguments, 0);
  }
}
