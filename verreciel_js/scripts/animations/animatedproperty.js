//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class AnimatedProperty {
  constructor(
    animator,
    target,
    property,
    isAngle = false,
    snapToEnd = false,
    onChange = null
  ) {
    // assertArgs(arguments, 3);
    this.animator = animator;
    this.animation = null;
    this.registered = false;
    this.onChange = onChange;

    this.target = target;
    this.property = property;
    this.isAngle = isAngle;
    this.snapToEnd = snapToEnd;

    this.__value = this.target[this.property];
    if (this.isAngle) {
      this.__value = sanitizeAngle(this.__value);
    }
  }

  get value() {
    return this.__value;
  }

  set value(newValue) {
    if (this.isAngle) {
      newValue = sanitizeAngle(newValue);
    }
    if (this.__value == newValue) {
      return;
    }

    // Stop any running animation
    if (this.animation != null) {
      this.registered = false;
      this.animation = null;
      // Snap to the end if configured to do so
      if (this.snapToEnd) {
        this.target[this.property] = this.__value;
      }
    }

    this.__value = newValue;
    if (this.animator.begun) {
      this.animator.registerProperty(this);
    } else {
      this.target[this.property] = this.__value;
    }
    if (this.onChange != null) {
      this.onChange();
    }
  }

  setNow(newValue) {
    if (this.isAngle) {
      newValue = sanitizeAngle(newValue);
    }
    if (this.__value == newValue) {
      return;
    }

    this.animation = null;
    this.registered = false;

    this.__value = newValue;
    this.target[this.property] = this.__value;
    if (this.onChange != null) {
      this.onChange();
    }
  }

  commit(animation) {
    // assertArgs(arguments, 1, true);
    this.from = this.target[this.property];
    if (this.isAngle) {
      this.from = sanitizeAngle(this.from);
    }
    this.to = this.value;

    if (this.isAngle) {
      this.from = this.to - sanitizeDiffAngle(this.to, this.from);
    }

    if (this.from == this.to) {
      this.registered = false;
    } else {
      this.animation = animation;
    }
  }

  interpolate(percent) {
    this.percent = percent;
    this.__value = this.to * percent + this.from * (1 - percent);
    this.target[this.property] = this.__value;
    if (this.onChange != null) {
      this.onChange();
    }
  }
}
