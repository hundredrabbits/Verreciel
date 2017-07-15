//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Animator {
  constructor() {
    // assertArgs(arguments, 0, true);
    this.begun = false;
    this.properties = [];
    this.delay = 0;
    this.ease = Penner.easeOutQuart;
    this.animationID = 1;
    this.animations = {};
  }

  begin(name = null) {
    // assertArgs(arguments, 0);
    if (this.begun) {
      console.warn("Animator has already begun.");
      return;
    }
    this.name = name;
    if (this.name == null) {
      this.name = "animation" + this.animationID;
    }
    this.animationID++;
    this.begun = true;
    this.properties.splice(0, this.properties.length);
  }

  registerProperty(property) {
    // assertArgs(arguments, 1, true);
    if (!property.registered) {
      property.registered = true;
      this.properties.push(property);
    }
  }

  commit() {
    // assertArgs(arguments, 0, true);
    if (!this.begun) {
      console.warn("Animator has not yet begun.");
      return;
    }

    let animation = new Animation(
      this.name,
      this.animationDuration,
      this.delay,
      this.ease,
      this.properties.slice(),
      this.completionBlock
    );
    this.name = null;
    this.properties.splice(0, this.properties.length);
    this.begun = false;
    this.animationDuration = 0;
    this.completionBlock = null;
    this.delay = 0;
    this.animations[animation.name] = animation;
    this.ease = Penner.easeOutQuart;
    return animation.name;
  }

  completeAnimation(name) {
    let animation = this.animations[name];
    if (animation == null) {
      return;
    }
    delete this.animations[name];
    animation.complete();
  }
}
