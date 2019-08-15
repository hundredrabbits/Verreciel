//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class LocationAntenna extends Location {
  constructor (name, system, at, requirement = null, installation, installationName, mapRequirement = null) {
    // assertArgs(arguments, 6);
    super(name, system, at, new IconStation(), new StructureStation())

    this.installation = installation
    this.requirement = requirement
    this.installationName = installationName
    this.details = installationName
    this.mapRequirement = mapRequirement
    this.isComplete = false
  }

  makePanel () {
    if (this.isComplete == true) {
      return null
    }
    // assertArgs(arguments, 0);
    let newPanel = new Panel()

    let text = new SceneLabel('Orient Transmitters$install shield', 0.1, Alignment.left)
    text.position.set(-1.5, 1, 0)
    newPanel.add(text)

    this.button = new SceneButton(this, this.code + '_install', 'install', 1)
    this.button.position.set(0, -1, 0)
    newPanel.add(this.button)

    this.signalLabel = new SceneLabel('signal', 0.1, Alignment.right, verreciel.grey)
    this.signalLabel.position.set(-0.6, 0, 0)
    newPanel.add(this.signalLabel)

    this.syncLabel = new SceneLabel('sync', 0.1, Alignment.left, verreciel.grey)
    this.syncLabel.position.set(0.6, 0, 0)
    newPanel.add(this.syncLabel)

    this.diamond = new Diamond(0.5, verreciel.grey)
    this.diamond.position.set(0, 0, 0)
    this.diamond.rotation.x = degToRad(90)
    newPanel.add(this.diamond)

    this.syncDiamond = new Diamond(0.4, verreciel.red)
    this.syncDiamond.position.set(0, 0, 0)
    this.syncDiamond.rotation.x = degToRad(90)
    newPanel.add(this.syncDiamond)

    this.button.disable('install')

    return newPanel
  }

  onDock () {
    super.onDock()

    const signal = this.getSignal()
    const value = (signal * 100).toFixed(1)
    this.syncLabel.updateText(value + '%')
    this.syncDiamond.position.set(0, 0, -5 * (1 - signal))

    if (signal >= 0.95) {
      this.syncDiamond.color = verreciel.cyan
      this.syncLabel.updateText('online', verreciel.cyan)
      this.button.enable('install')
    }
  }

  getSignal () {
    const loiqeOffset = (angleBetweenTwoPoints(this.at, verreciel.universe.loiqe_transmitter.at)) - verreciel.universe.loiqe_transmitter.orientation
    const senniOffset = (angleBetweenTwoPoints(this.at, verreciel.universe.senni_transmitter.at)) - verreciel.universe.senni_transmitter.orientation
    const offset = 1 - ((Math.abs(loiqeOffset) + Math.abs(senniOffset)) / 360)
  }

  touch (id) {
    // assertArgs(arguments, 1);
    super.touch(id)
    if (id == 1) {
      this.installation()
      this.onComplete()
    }
    return true
  }
}

class IconAntenna extends Icon {
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
          new THREE.Vector3(-this.size, 0, 0),
          new THREE.Vector3(this.size, 0, 0)
        ],
        this.color
      )
    )
  }
}

class StructurAntenna extends Structure {
  constructor () {
    // assertArgs(arguments, 0);
    super()

    this.root.position.set(0, 5, 0)

    let color = verreciel.grey
    let nodes = 24
    var i = 0
    while (i < nodes) {
      let node = new Empty()
      node.rotation.y = degToRad(i * (360 / nodes))
      node.add(
        new SceneLine(
          [
            new THREE.Vector3(0.375, -4, 0),
            new THREE.Vector3(-0.375, -4, 0),
            new THREE.Vector3(-3.75, -40, 0),
            new THREE.Vector3(3.75, -40, 0)
          ],
          color
        )
      )
      this.root.add(node)
      i += 1
    }
  }

  onSight () {
    // assertArgs(arguments, 0);
    super.onSight()

    verreciel.animator.begin()
    verreciel.animator.animationDuration = 0.5

    for (let node of this.root.children) {
      node.rotation.x = degToRad(45)
    }

    verreciel.animator.commit()
  }

  onUndock () {
    // assertArgs(arguments, 0);
    super.onUndock()

    verreciel.animator.begin()
    verreciel.animator.animationDuration = 0.5

    for (let node of this.root.children) {
      node.rotation.x = degToRad(40)
    }

    verreciel.animator.commit()
  }

  onDock () {
    // assertArgs(arguments, 0);
    super.onDock()

    verreciel.animator.begin()
    verreciel.animator.animationDuration = 0.5

    for (let node of this.root.children) {
      node.rotation.x = degToRad(50)
    }

    verreciel.animator.commit()
  }

  onComplete () {
    // assertArgs(arguments, 0);
    super.onComplete()

    this.updateChildrenColors(verreciel.cyan)
  }

  sightUpdate () {
    // assertArgs(arguments, 0);
    this.root.rotation.y += degToRad(0.1)
  }
}
