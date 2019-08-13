//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class LocationStation extends Location {
  constructor (
    name,
    system,
    at,
    requirement = null,
    installation,
    installationName,
    mapRequirement = null
  ) {
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
    // assertArgs(arguments, 0);
    let newPanel = new Panel()

    let requirementLabel = new SceneLabel(
      'Exchange ' +
        this.requirement.name +
        '$install the ' +
        this.installationName
    )
    requirementLabel.position.set(
      Templates.leftMargin,
      Templates.topMargin - 0.3,
      0
    )
    newPanel.add(requirementLabel)

    this.button = new SceneButton(this, this.code + '_install', 'install', 1)
    this.button.position.set(0, -1, 0)
    newPanel.add(this.button)

    this.port = new ScenePortSlot(this, this.code)
    this.port.position.set(0, -0.2, 0)
    newPanel.add(this.port)

    this.tradeLabel = new SceneLabel(
      'trade',
      0.1,
      Alignment.right,
      verreciel.grey
    )
    this.tradeLabel.position.set(-0.3, 0, 0)
    this.port.add(this.tradeLabel)

    this.button.disable('install')
    this.port.enable()

    return newPanel
  }

  onUploadComplete () {
    // assertArgs(arguments, 0);
    if (this.port.hasEvent() == false) {
      this.tradeLabel.color = verreciel.grey
      return
    }

    let trade = this.port.event
    if (
      trade instanceof Item &&
      trade.name == this.requirement.name &&
      trade.type == this.requirement.type
    ) {
      this.button.enable('install')
      this.tradeLabel.color = verreciel.cyan
    } else {
      this.tradeLabel.color = verreciel.red
    }
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

class IconStation extends Icon {
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

class StructureStation extends Structure {
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
      node.rotation.x = degToRad(0)
    }

    verreciel.animator.commit()
  }

  onUndock () {
    // assertArgs(arguments, 0);
    super.onUndock()

    verreciel.animator.begin()
    verreciel.animator.animationDuration = 0.5

    for (let node of this.root.children) {
      node.rotation.x = degToRad(45)
    }

    verreciel.animator.commit()
  }

  onDock () {
    // assertArgs(arguments, 0);
    super.onDock()

    verreciel.animator.begin()
    verreciel.animator.animationDuration = 0.5

    for (let node of this.root.children) {
      node.rotation.x = degToRad(45)
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
