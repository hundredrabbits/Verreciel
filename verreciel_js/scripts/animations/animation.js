//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Animation {
  constructor(name, duration, animDelay, ease, properties, completionBlock) {
    this.name = name;
    this.duration = duration;
    this.delay = animDelay;
    this.ease = ease;
    this.properties = properties;
    this.completionBlock = completionBlock;
    this.percent = 0;
    this.lastFrameTime = Date.now();
    this.completed = false;
    this.started = false;

    for (let property of this.properties) {
      if (property.registered) {
        property.commit(this.name);
      }
    }

    this.tick();
    this.started = true;
    this.lastFrameTime += this.delay * 1000;
    delay(this.delay, this.tick.bind(this));
  }

  tick() {
    if (this.completed) {
      return;
    }
    let frameTime = Date.now();
    let secondsElapsed = (frameTime - this.lastFrameTime) / 1000;
    this.lastFrameTime = frameTime;

    var percentElapsed = secondsElapsed / this.duration;
    this.percent += percentElapsed;

    if (this.percent > 1) {
      this.percent = 1;
    }

    let easedPercent = this.ease(this.percent, 0, 1, 1);

    for (let property of this.properties) {
      if (property.registered) {
        property.interpolate(easedPercent);
        if (this.percent >= 1) {
          property.animation = null;
          property.registered = false;
        }
      }
    }

    if (this.started == true) {
      if (this.percent < 1) {
        requestAnimationFrame(this.tick.bind(this));
      } else {
        verreciel.animator.completeAnimation(this.name);
      }
    }
  }

  complete() {
    this.completed = true;
    if (this.completionBlock != null) {
      this.completionBlock();
    }
  }
}
