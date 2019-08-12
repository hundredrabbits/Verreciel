//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class SceneDrawNode extends Empty {
  constructor () {
    super()
    this.__color4 = new THREE.Vector4(1, 0, 0, 1)
    this.__materialColor = new THREE.Color()
    this.__colorRGB = new AnimatedXYZ(
      verreciel.animator,
      this,
      '__color4',
      false,
      false,
      this.updateMaterialColor.bind(this)
    )
    this.updateMaterialColor()
  }

  get color () {
    return this.__color4
  }

  set color (newColor) {
    if (this.__color4.equals(newColor)) {
      return
    }
    this.__color4.w = newColor.w
    this.__colorRGB.set(newColor.x, newColor.y, newColor.z)
    this.updateMaterialColor()
    this.updateMaterialOpacity()
  }

  makeElement () {}

  updateMaterialColor () {
    this.__materialColor.r = this.__color4.x
    this.__materialColor.g = this.__color4.y
    this.__materialColor.b = this.__color4.z
    this.material.color = this.__materialColor
  }

  updateMaterialOpacity () {
    this.material.opacity = this.opacityFromTop * this.__color4.w
  }

  whenInherit () {
    this.updateMaterialOpacity()
    super.whenInherit()
  }
}
