//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class SceneLine extends SceneDrawNode {
  constructor(vertices, color = verreciel.white) {
    // assertArgs(arguments, 1);
    super();
    this.updateVertices(vertices);
    this.color = color;
  }

  makeElement() {
    this.material = new THREE.LineBasicMaterial({
      color: 0xffffff,
      transparent: true
    });
    this.geometry = new THREE.Geometry();
    this.element = new THREE.LineSegments(this.geometry, this.material);
    super.makeElement();
  }

  updateChildrenColors(color) {
    // assertArgs(arguments, 1);
    this.color = color;
    super.updateChildrenColors(color);
  }

  updateMaterialOpacity() {
    super.updateMaterialOpacity();
    this.material.visible = this.material.opacity > 0;
  }

  updateVertices(vertices) {
    // assertArgs(arguments, 1);
    if (vertices.indexOf(null) != -1) {
      throw "BAD GEOMETRY";
    }

    let oldLength = this.vertices == null ? -1 : this.vertices.length;
    this.vertices = vertices;
    while (this.vertices.length < oldLength) {
      this.vertices.push(SceneLine.DUD_VERT);
    }

    if (oldLength != -1 && this.vertices.length > oldLength) {
      this.geometry.dispose();
      this.geometry = new THREE.Geometry();
      this.element.geometry = this.geometry;
      // console.log("EXPAND:", oldLength, "-->", this.vertices.length);
    }

    this.geometry.vertices = vertices;
    this.geometry.verticesNeedUpdate = true;
    this.geometry.computeBoundingSphere();
  }
}

SceneLine.DUD_VERT = new THREE.Vector3();
