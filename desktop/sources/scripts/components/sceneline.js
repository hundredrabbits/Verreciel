//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class SceneLine extends SceneDrawNode {
  constructor (vertices, color = verreciel.white) {
    // assertArgs(arguments, 1);
    super()
    this.updateVertices(vertices)
    this.color = color
  }

  makeElement () {
    this.meshLineSegments = new MeshLineSegments(verreciel.colorPalette)
    this.material = this.meshLineSegments.material
    this.material.screenAspectRatio = verreciel.width / verreciel.height
    this.material.lineWidth = 0.004
    this.element = this.meshLineSegments.element
    super.makeElement()
  }

  updateChildrenColors (color) {
    // assertArgs(arguments, 1);
    this.color = color
    super.updateChildrenColors(color)
  }

  updateMaterialOpacity () {
    super.updateMaterialOpacity()
    this.material.visible = this.material.opacity > 0
  }

  updateVertices (vertices) {
    // assertArgs(arguments, 1);
    if (vertices.indexOf(null) != -1) {
      throw 'BAD GEOMETRY'
    }
    this.meshLineSegments.updateGeometry(vertices)
  }

  updateColorPalette () {
    super.updateColorPalette()
    this.material.colorPalette = verreciel.colorPalette
  }

  whenResize () {
    this.material.screenAspectRatio = verreciel.width / verreciel.height
    super.whenResize()
  }
}

SceneLine.DUD_VERT = new THREE.Vector3()
