//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class SceneNode {
  constructor() {
    // assertArgs(arguments, 0);
    this.id = SceneNode.ids++;
    // console.log(this.id);
    this.children = [];

    if (DEBUG_REPORT_NODE_USE) {
      this.inception = getStackTrace();
      this.inception = this.inception.replace(/^Error\n/, "");
      this.useCheckDelay = null;
      this.useCheckDuration = 1;
    }

    this.makeElement();

    this.element.node = this;
    this.element.rotation.order = "YXZ";
    this.position = new AnimatedXYZ(
      verreciel.animator,
      this.element,
      "position"
    );
    this.rotation = new AnimatedXYZ(
      verreciel.animator,
      this.element,
      "rotation",
      true
    );
    this.__opacityProperty = new AnimatedProperty(
      verreciel.animator,
      { opacity: 1 },
      "opacity",
      false,
      true,
      this.whenInherit.bind(this)
    );
  }

  get opacity() {
    return this.__opacityProperty.value;
  }

  set opacity(newValue) {
    this.__opacityProperty.value = newValue;
  }

  get opacityFromTop() {
    var value = this.parent == null ? 1 : this.parent.opacityFromTop;
    return value * this.__opacityProperty.value;
  }

  makeElement() {
    this.element = new THREE.Group();
  }

  add(other) {
    this.element.add(other.element);
    this.children.push(other);
    other.parent = this;
    other.element.updateMatrixWorld(true);
    other.whenInherit();
    if (verreciel.phase == Phase.render) {
      other.whenRenderer();
    }
  }

  remove(other) {
    this.element.remove(other.element);
    this.children.splice(this.children.indexOf(other), 1);
    other.parent = null;

    if (DEBUG_REPORT_NODE_USE) {
      other.startReportingUnused();
    }
  }

  startReportingUnused() {
    this.useCheckDuration = 1;
    this.useCheckDelay = delay(
      this.useCheckDuration,
      this.checkUnused.bind(this)
    );
  }

  checkUnused() {
    if (DEBUG_REPORT_NODE_USE) {
      var parent = this.parent;
      while (parent != null && parent != verreciel.root) {
        parent = parent.parent;
      }
      if (parent == null) {
        console.log("Unused for", this.useCheckDuration, "seconds:");
        console.log(this.inception);
        this.useCheckDuration *= 2;
        this.useCheckDelay = delay(
          this.useCheckDuration,
          this.checkUnused.bind(this)
        );
      } else {
        console.log("On graph", this.inception);
        this.useCheckDelay = null;
        this.useCheckDuration = 1;
      }
    }
  }

  whenInherit() {
    for (let node of this.children) {
      node.whenInherit();
    }
  }

  whenStart() {
    // assertArgs(arguments, 0);
    for (let node of this.children) {
      node.whenStart();
    }
  }

  whenTime() {
    // assertArgs(arguments, 0);
    for (let node of this.children) {
      node.whenTime();
    }
  }

  whenSecond() {
    // assertArgs(arguments, 0);
    for (let node of this.children) {
      node.whenSecond();
    }
  }

  whenRenderer() {
    // assertArgs(arguments, 0);
    for (let node of this.children) {
      node.whenRenderer();
    }
  }

  removeFromParentNode() {
    // assertArgs(arguments, 0);
    if (this.parent != null) {
      this.parent.remove(this);
    }
  }

  convertPositionToNode(xyz, node) {
    // assertArgs(arguments, 2);
    let position = new THREE.Vector3(xyz.x, xyz.y, xyz.z);
    this.hardUpdateMatrixWorld();
    node.hardUpdateMatrixWorld();
    position
      .applyMatrix4(this.element.matrixWorld)
      .applyMatrix4(
        node.element.matrixWorld.getInverse(node.element.matrixWorld)
      );
    return position;
  }

  convertPositionFromNode(xyz, node) {
    // assertArgs(arguments, 2);
    let position = new THREE.Vector3(xyz.x, xyz.y, xyz.z);
    this.hardUpdateMatrixWorld();
    node.hardUpdateMatrixWorld();
    position
      .applyMatrix4(node.element.matrixWorld)
      .applyMatrix4(
        this.element.matrixWorld.getInverse(this.element.matrixWorld)
      );
    return position;
  }

  getDistSquared(point) {
    let position = point.clone();
    this.hardUpdateMatrixWorld();
    position.applyMatrix4(
      this.element.matrixWorld.getInverse(this.element.matrixWorld)
    );
    return position.lengthSq();
  }

  hardUpdateMatrixWorld() {
    var node = this;
    while (node != null) {
      node.element.updateMatrixWorld();
      node = node.parent;
    }
  }
}

SceneNode.ids = 0;
