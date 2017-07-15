//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class SceneProgressRadial extends Empty {
  constructor(size = 1.2, linesCount = 52, color = verreciel.cyan) {
    super();

    this.linesCount = linesCount;
    this.lines = [];

    var i = 0;
    while (i < linesCount) {
      let line = new SceneLine(
        [new THREE.Vector3(0, size - 0.2, 0), new THREE.Vector3(0, size, 0)],
        color
      );
      line.rotation.z = degToRad(i * (360 / this.linesCount));
      this.lines.push(line);
      this.add(line);
      i += 1;
    }
  }

  updatePercent(percentage) {
    let reach = percentage / 100 * this.linesCount;

    var i = 0;
    for (let line of this.lines) {
      if (reach == 0) {
        line.color = verreciel.cyan;
      } else if (i > reach) {
        line.color = verreciel.grey;
      } else {
        line.color = verreciel.cyan;
      }

      i += 1;
    }
  }
}
