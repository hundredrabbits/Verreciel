//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class SceneTrigger extends Empty {
  constructor (host, name, width, height, operation) {
    // assertArgs(arguments, 5);

    super()
    this.name = name
    verreciel.ghost.triggersByName[name] = this
    this.isEnabled = true
    this.operation = operation
    this.host = host

    this.mouseUpTarget = new SceneTapTarget(
      this,
      "mouseup",
      width,
      height,
      SceneTrigger.DEBUG_BLUE
    )
    this.add(this.mouseUpTarget)
    this.mouseDownTarget = new SceneTapTarget(
      this,
      "mousedown",
      width / 2,
      height / 2,
      SceneTrigger.DEBUG_MAGENTA
    )
    this.add(this.mouseDownTarget)
  }

  tap () {
    // assertArgs(arguments, 1);
    if (this.isEnabled == false) {
      return false
    }

    let result = this.host.touch(this.operation)

    if (result == true) {
      verreciel.ghost.report(
        LogType.hit,
        verreciel.ghost.recordHitTarget(this)
      )
    }

    return result
  }

  enable () {
    // assertArgs(arguments, 0);
    if (!this.isEnabled) {
      this.isEnabled = true
      this.mouseUpTarget.color = SceneTrigger.DEBUG_BLUE
      this.mouseDownTarget.color = SceneTrigger.DEBUG_MAGENTA
    }
  }

  disable () {
    // assertArgs(arguments, 0);
    if (this.isEnabled) {
      this.isEnabled = false
      this.mouseUpTarget.color = SceneTrigger.DEBUG_WHITE
      this.mouseDownTarget.color = SceneTrigger.DEBUG_WHITE
    }
  }
}

class SceneTapTarget extends SceneDrawNode {
  constructor (trigger, type, width, height, color) {
    super()
    this.trigger = trigger;
    this.type = type

    let scale = IS_MOBILE ? 1 : 0.5

    this.geometry.fromBufferGeometry(
      new THREE.PlaneBufferGeometry(width * scale, height * scale)
    )
    this.geometry.mergeVertices()

    this.color = color
  }

  makeElement () {
    this.material = new THREE.MeshBasicMaterial({
      color: 0xffffff,
      visible: DEBUG_SHOW_TRIGGERS,
      transparent: true
    })
    this.geometry = new THREE.Geometry()
    this.geometry.dynamic = true
    this.element = new THREE.Mesh(this.geometry, this.material)
    super.makeElement()
  }
}

SceneTrigger.DEBUG_BLUE = new THREE.Vector4(0, 0, 1, 0.1)
SceneTrigger.DEBUG_MAGENTA = new THREE.Vector4(0.5, 0, 0.5, 0.1)
SceneTrigger.DEBUG_WHITE = new THREE.Vector4(1, 1, 1, 0.1)
