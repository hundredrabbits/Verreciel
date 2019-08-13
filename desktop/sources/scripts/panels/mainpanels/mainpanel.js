//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class MainPanel extends Panel {
  constructor (name) {
    assertArgs(arguments, 1)
    super(name)

    this.installNode = new Empty()
    this.installNode.position.set(0, 0, 0)
    this.installProgressBar = new SceneProgressBar(1)
    this.installProgressBar.position.set(
      -this.installProgressBar.width / 2,
      -0.3,
      0
    )
    this.installProgressBar.show()
    this.installNode.add(this.installProgressBar)
    this.installLabel = new SceneLabel(
      'install',
      0.1,
      Alignment.center,
      verreciel.grey
    )
    this.installNode.add(this.installLabel)
    this.installNode.hide()
    this.root.add(this.installNode)

    this.nameLabel = new SceneLabel('', 0.1, Alignment.center)
    this.detailsLabel = new SceneLabel('', 0.085, Alignment.center)
    this.header = new Empty()
    this.footer = new Empty()
    this.mainNode = new Empty()
    this.decals = new Empty()

    this.details = 'unknown'
    this.root.position.set(0, 0, Templates.radius)
    this.root.add(this.mainNode)
    this.root.add(this.decals)

    // Header
    this.port = new ScenePort(this, 'mainpanel_' + this.name)
    this.port.position.set(0, 0.4, Templates.radius)
    this.nameLabel.position.set(0, 0, Templates.radius)
    this.header.add(this.port)
    this.header.add(this.nameLabel)
    this.add(this.header)
    this.header.rotation.x += degToRad(Templates.titlesAngle)

    // Footer
    this.detailsLabel.position.set(0, 0, Templates.radius)
    this.footer.add(this.detailsLabel)
    this.add(this.footer)
    this.footer.rotation.x = degToRad(-Templates.titlesAngle)

    this.width = 1.65
    this.height = 1.8

    // Start

    this.mainNode.hide()
    this.decals.hide()
    this.footer.hide()

    this.nameLabel.updateText('--', verreciel.grey)
  }

  drawDecals () {
    if (this.decals.children.length == 0) {
      this.decals.add(
        new SceneLine(
          [
            new THREE.Vector3(this.width + 0.2, this.height - 0.2, 0),
            new THREE.Vector3(this.width, this.height, 0),
            new THREE.Vector3(this.width + 0.2, this.height - 0.2, 0),
            new THREE.Vector3(this.width + 0.2, -this.height + 0.2, 0),
            new THREE.Vector3(this.width + 0.2, -this.height + 0.2, 0),
            new THREE.Vector3(this.width, -this.height, 0)
          ],
          verreciel.grey
        )
      )
      this.decals.add(
        new SceneLine(
          [
            new THREE.Vector3(-this.width - 0.2, this.height - 0.2, 0),
            new THREE.Vector3(-this.width, this.height, 0),
            new THREE.Vector3(-this.width - 0.2, -this.height + 0.2, 0),
            new THREE.Vector3(-this.width, -this.height, 0),
            new THREE.Vector3(-this.width - 0.2, this.height - 0.2, 0),
            new THREE.Vector3(-this.width - 0.2, -this.height + 0.2, 0)
          ],
          verreciel.grey
        )
      )
    }
  }

  whenStart () {
    // assertArgs(arguments, 0);
    super.whenStart()

    this.decals.hide()
    this.mainNode.hide()
    this.nameLabel.updateText('--', verreciel.grey)
  }

  // MARK: Installation -

  onInstallationBegin () {
    // assertArgs(arguments, 0);
    super.onInstallationBegin()
    verreciel.helmet.addWarning('Installing', null, 3, 'install')
    this.installNode.show()
  }

  installProgress () {
    // assertArgs(arguments, 0);
    super.installProgress()

    this.installLabel.updateText(
      'Install ' + this.installPercentage.toFixed(0) + '%'
    )
    this.installProgressBar.updatePercent(this.installPercentage)
  }

  onInstallationComplete () {
    // assertArgs(arguments, 0);
    super.onInstallationComplete()

    this.mainNode.position.set(0, 0, -0.2)
    this.mainNode.hide()
    this.decals.position.set(0, 0, -0.4)
    this.decals.hide()

    verreciel.animator.begin()
    verreciel.animator.animationDuration = 0.7
    this.mainNode.position.set(0, 0, 0)
    this.mainNode.show()
    this.decals.position.set(0, 0, 0)
    this.decals.show()
    this.footer.show()
    verreciel.animator.commit()

    this.installNode.hide()

    this.port.enable()
    this.nameLabel.updateText(this.name, verreciel.white)
  }
}
