//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class LocationTransmitter extends Location {
  constructor (name, system, at, mapRequirement = null) {
    // assertArgs(arguments, 4);
    super(name, system, at, new IconTransmitter(), new StructureTransmitter())

    this.target = null
    this.shouldAlign = false
    this.orientation = 0

    this.details = '???'
    this.mapRequirement = mapRequirement
  }

  makePanel () {
    // assertArgs(arguments, 0);
    let newPanel = new Panel()

    let requirementLabel = new SceneLabel('Orientation Location$Transmit Access')
    requirementLabel.position.set(Templates.leftMargin, Templates.topMargin - 0.3, 0)
    newPanel.add(requirementLabel)

    this.button = new SceneButton(this, 'orient', 'orient', 2)
    this.button.position.set(0, -1, 0)
    newPanel.add(this.button)

    this.port = new ScenePort(this, this.code)
    this.port.position.set(0, -0.2, 0)
    newPanel.add(this.port)

    this.targetLabel = new SceneLabel('--', 0.1, Alignment.right, verreciel.grey)
    this.targetLabel.position.set(-0.3, 0, 0)
    this.port.add(this.targetLabel)

    this.orientationLabel = new SceneLabel('--', 0.1, Alignment.left, verreciel.grey)
    this.orientationLabel.position.set(0.3, 0, 0)
    this.port.add(this.orientationLabel)

    this.button.disable('orient', verreciel.white)
    this.port.enable()

    return newPanel
  }

  dockUpdate () {
    // assertArgs(arguments, 0);
    super.dockUpdate()

    // Update target coming through the wire
    if (this.port.origin && this.port.origin.event && this.port.origin.event.system) {
      if (!this.target) {
        this.target = this.port.origin.event
        this.refresh()
      } else if (this.target && this.target.name !== this.port.origin.event.name) {
        this.target = this.port.origin.event
        this.refresh()
      }
    } else {
      if (this.target) {
        this.target = null
        this.refresh()
      }
    }

    // Align
    if (this.shouldAlign === true) {
      if (!this.target) { this.shouldAlign = false; return }
      const angle = angleBetweenTwoPoints(this.target.at, this.at)
      const offset = angle - this.orientation
      this.orientation += offset * 0.01
      this.orientation = this.orientation % 360
      this.orientationLabel.updateText(parseInt(this.orientation), verreciel.cyan)
      if (parseInt(this.orientation) === parseInt(angle)) {
        this.shouldAlign = false
        this.button.disable('aligned', verreciel.white)
        this.orientationLabel.updateText(parseInt(this.orientation), verreciel.grey)
        this.targetLabel.updateText(parseInt(angle), verreciel.grey)
      }
    }
  }

  refresh () {
    super.refresh()
    if (this.target) {
      const angle = angleBetweenTwoPoints(this.target.at, this.at)
      this.targetLabel.updateText(parseInt(angle), verreciel.cyan)
      this.button.enable('orient', parseInt(this.orientation) === parseInt(angle) ? verreciel.white : verreciel.cyan)
    } else {
      this.targetLabel.updateText('--', verreciel.grey)
      this.button.disable('orient', verreciel.white)
    }
  }

  touch (id) {
    // assertArgs(arguments, 1);
    if (id === 2) {
      this.shouldAlign = true
    } else {
      super.touch(id)
    }
    return true
  }
}

class IconTransmitter extends Icon {
  constructor () {
    // assertArgs(arguments, 0);
    super()

    this.mesh.add(
      new SceneLine(
        [
          new THREE.Vector3(0, this.size, 0),
          new THREE.Vector3(this.size, 0, 0),
          new THREE.Vector3(-this.size, 0, 0),
          new THREE.Vector3(0, -this.size, 0),
          new THREE.Vector3(0, this.size, 0),
          new THREE.Vector3(-this.size, 0, 0),
          new THREE.Vector3(this.size, 0, 0),
          new THREE.Vector3(0, -this.size, 0),

          new THREE.Vector3(-this.size * 0.5, -this.size * 0.5, 0),
          new THREE.Vector3(this.size * 0.5, this.size * 0.5, 0),
          new THREE.Vector3(this.size * 0.5, -this.size * 0.5, 0),
          new THREE.Vector3(-this.size * 0.5, this.size * 0.5, 0)
        ],
        this.color
      )
    )
  }
}

class StructureTransmitter extends Structure {
  constructor () {
    // assertArgs(arguments, 0);
    super()

    this.root.position.set(0, 0, 0)

    let node = new Empty()
    let ring = new Empty()
    let color = verreciel.grey
    let nodes = 24
    var i = 0
    while (i < nodes) {
      let node2 = new Empty()
      const distance = 2.5
      const length = 0.34
      node2.rotation.y = degToRad(i * (360 / nodes))
      node2.add(new SceneLine([new THREE.Vector3(length, 1.5, distance), new THREE.Vector3(-length, 1.5, distance)], verreciel.white))
      node2.add(new SceneLine([new THREE.Vector3(length * 0.75, 1.25, distance * 0.75), new THREE.Vector3(-length * 0.75, 1.25, distance * 0.75)], verreciel.white))
      ring.add(node2)
      i += 1
    }
    ring.position.set(3, 0, 0)
    ring.rotation.z = degToRad(90)

    node.add(new Cross(0.1, verreciel.cyan, { x: 0, y: 0, z: 4 }))

    node.add(ring)
    node.position.set(0, 5, 0)

    node.add(new SceneLine([
      new THREE.Vector3(-5, 0, 0),
      new THREE.Vector3(2, 0, 0),
      new THREE.Vector3(0, -0.1, 0),
      new THREE.Vector3(0, 0.1, 0),
      new THREE.Vector3(0, 0, -0.1),
      new THREE.Vector3(0, 0, 0.1)
    ], verreciel.white))

    node.add(new SceneLine([
      new THREE.Vector3(2, 0, 0),
      new THREE.Vector3(4, 0, 0),
      new THREE.Vector3(0, -0.5, -0.5),
      new THREE.Vector3(0, 0, 0),
      new THREE.Vector3(0, 0, 0),
      new THREE.Vector3(0, -0.5, 0.5)
    ], verreciel.grey))

    node.add(new SceneLine([
      new THREE.Vector3(-5, 0, 0),
      new THREE.Vector3(-6, 0, 0)
    ], verreciel.cyan))

    node.add(new Cross(0.5, verreciel.grey))

    this.root.add(node)
  }

  sightUpdate () {
    // assertArgs(arguments, 0);
    this.root.rotation.y = degToRad(this.host.orientation / 2)
    this.root.rotation.x = degToRad(this.host.orientation / 3)
    this.root.rotation.z = degToRad(this.host.orientation / 6)

    this.root.children[0].rotation.x += 0.005
  }
}
