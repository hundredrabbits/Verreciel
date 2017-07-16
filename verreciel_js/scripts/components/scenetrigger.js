//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class SceneTrigger extends SceneDrawNode {
  constructor(host, name, width, height, operation) {
    // assertArgs(arguments, 5);

    super();
    this.name = name;
    SceneTrigger.triggersByName[name] = this;
    this.isEnabled = true;
    this.operation = operation;
    this.host = host;

    let scale = IS_MOBILE ? 1 : 0.5;

    this.geometry.fromBufferGeometry(
      new THREE.PlaneBufferGeometry(width * scale, height * scale)
    );
    this.geometry.mergeVertices();

    this.color = SceneTrigger.DEBUG_BLUE;
  }

  makeElement() {
    this.material = new THREE.MeshBasicMaterial({
      color: 0xffffff,
      visible: DEBUG_SHOW_TRIGGERS,
      transparent: true
    });
    this.geometry = new THREE.Geometry();
    this.geometry.dynamic = true;
    this.element = new THREE.Mesh(this.geometry, this.material);
    super.makeElement();
  }

  tap() {
    // assertArgs(arguments, 1);
    if (this.isEnabled == false) {
      return false;
    }

    let result = this.host.touch(this.operation);

    if (result == true) {
      console.log("hit:", this.name);
    }

    return result;
  }

  update() {
    // assertArgs(arguments, 0);
  }

  enable() {
    // assertArgs(arguments, 0);
    if (!this.isEnabled) {
      this.isEnabled = true;
      this.color = SceneTrigger.DEBUG_BLUE;
    }
  }

  disable() {
    // assertArgs(arguments, 0);
    if (this.isEnabled) {
      this.isEnabled = false;
      this.color = SceneTrigger.DEBUG_WHITE;
    }
  }

  static autoTapTrigger(name) {
    SceneTrigger.triggersByName[name].tap();
  }
}

SceneTrigger.DEBUG_BLUE = new THREE.Vector4(0, 0, 1, 0.1);
SceneTrigger.DEBUG_WHITE = new THREE.Vector4(1, 1, 1, 0.1);
SceneTrigger.triggersByName = {};
