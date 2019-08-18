//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class SceneWire extends Empty {
  constructor (host, endA = new THREE.Vector3(), endB = new THREE.Vector3()) {
    // assertArgs(arguments, 3);
    super()
    this.isEnabled = true
    this.isUploading = false
    this.host = host
    this.endA = endA
    this.endB = endB
    this.time = 0
    this.length = 0
    this.lastGameTime = 0

    this.baseline1 = new THREE.Vector3(
      this.endB.x * 0.2,
      this.endB.y * 0.2,
      this.endB.z * 0.2
    )
    this.baseline2 = new THREE.Vector3(
      this.endB.x * 0.4,
      this.endB.y * 0.4,
      this.endB.z * 0.4
    )
    this.baseline3 = new THREE.Vector3(
      this.endB.x * 0.6,
      this.endB.y * 0.6,
      this.endB.z * 0.6
    )
    this.baseline4 = new THREE.Vector3(
      this.endB.x * 0.8,
      this.endB.y * 0.8,
      this.endB.z * 0.8
    )

    this.vertex1 = this.baseline1.clone()
    this.vertex2 = this.baseline2.clone()
    this.vertex3 = this.baseline3.clone()
    this.vertex4 = this.baseline4.clone()

    this.wiggle = new THREE.Vector3(0, 1, 0)
    this.thrust = new THREE.Vector3()

    this.segment1 = new SceneLine([this.endA, this.vertex1], verreciel.cyan)
    this.segment2 = new SceneLine(
      [this.vertex1, this.vertex2],
      verreciel.white
    )
    this.segment3 = new SceneLine(
      [this.vertex2, this.vertex3],
      verreciel.white
    )
    this.segment4 = new SceneLine(
      [this.vertex3, this.vertex4],
      verreciel.white
    )
    this.segment5 = new SceneLine([this.vertex4, this.endB], verreciel.red)

    this.segment1.element.frustumCulled = false
    this.segment2.element.frustumCulled = false
    this.segment3.element.frustumCulled = false
    this.segment4.element.frustumCulled = false
    this.segment5.element.frustumCulled = false

    this.add(this.segment1)
    this.add(this.segment2)
    this.add(this.segment3)
    this.add(this.segment4)
    this.add(this.segment5)
  }

  whenRenderer () {
    // assertArgs(arguments, 0);
    super.whenRenderer()

    if (
      this.isEnabled == false ||
      this.endB == null ||
      this.endA.equals(this.endB)
    ) {
      return
    }

    this.thrust.y =
      0.9 * this.thrust.y +
      0.1 * -Math.sqrt(Math.abs(verreciel.thruster.actualSpeed))
    this.updateSegments()
  }

  animate () {
    let rand = Math.random()
    let delta = verreciel.game.time - this.lastGameTime
    this.lastGameTime = verreciel.game.time
    this.time += rand * rand * delta
    if (
      this.isEnabled == false ||
      this.endB == null ||
      this.endA.equals(this.endB)
    ) {
      return
    }
    requestAnimationFrame(this.animate.bind(this))
  }

  updateEnds (
    endA = new THREE.Vector3(),
    endB = new THREE.Vector3(),
    reset = true
  ) {
    // assertArgs(arguments, 2);
    this.endA = endA
    this.endB = endB
    this.length = this.endA.distanceTo(this.endB)

    this.baseline1.copy(this.endB).multiplyScalar(0.2)
    this.baseline2.copy(this.endB).multiplyScalar(0.4)
    this.baseline3.copy(this.endB).multiplyScalar(0.6)
    this.baseline4.copy(this.endB).multiplyScalar(0.8)

    if (reset == true) {
      this.phase = Math.random() * Math.PI * 2
      this.animate()
    }

    this.updateSegments()
  }

  updateSegments () {
    this.wiggle.y = Math.sin(this.time / (this.length * 20) + this.phase)

    this.vertex1
      .copy(this.wiggle)
      .add(this.thrust)
      .multiplyScalar(this.length * 0.05)
      .add(this.baseline1)
    this.vertex2
      .copy(this.wiggle)
      .add(this.thrust)
      .multiplyScalar(this.length * 0.08)
      .add(this.baseline2)
    this.vertex3
      .copy(this.wiggle)
      .add(this.thrust)
      .multiplyScalar(this.length * 0.08)
      .add(this.baseline3)
    this.vertex4
      .copy(this.wiggle)
      .add(this.thrust)
      .multiplyScalar(this.length * 0.05)
      .add(this.baseline4)

    this.segment1.updateVertices([this.endA, this.vertex1])
    this.segment2.updateVertices([this.vertex1, this.vertex2])
    this.segment3.updateVertices([this.vertex2, this.vertex3])
    this.segment4.updateVertices([this.vertex3, this.vertex4])
    this.segment5.updateVertices([this.vertex4, this.endB])
  }

  enable () {
    // assertArgs(arguments, 0);
    this.isEnabled = true
    this.show()
  }

  disable () {
    // assertArgs(arguments, 0);
    this.isEnabled = false
    this.hide()
  }

  isCompatible () {
    // assertArgs(arguments, 0);
    return true
  }

  updateChildrenColors (color) {
    // NOPE.
  }
}
