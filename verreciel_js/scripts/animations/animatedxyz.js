//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class AnimatedXYZ
{
  constructor(animator, target, property, angles = false, snapToEnd = false, onChange = null)
  {
    // assertArgs(arguments, 3);
    this.target = target;
    this.property = property;
    this.xyz = target[property];
    this.__xProperty = new AnimatedProperty(animator, this.xyz, "x", angles, snapToEnd, onChange);
    this.__yProperty = new AnimatedProperty(animator, this.xyz, "y", angles, snapToEnd, onChange);
    this.__zProperty = new AnimatedProperty(animator, this.xyz, "z", angles, snapToEnd, onChange);
  }
  
  get x() { return this.__xProperty.value; }
  set x(value) { this.__xProperty.value = value; }

  get y() { return this.__yProperty.value; }
  set y(value) { this.__yProperty.value = value; }

  get z() { return this.__zProperty.value; }
  set z(value) { this.__zProperty.value = value; }

  set(x, y, z)
  {
    // assertArgs(arguments, 3, true);
    this.x = x;
    this.y = y;
    this.z = z;
  }

  setNow(x, y, z)
  {
    // assertArgs(arguments, 3, true);
    this.__xProperty.setNow(x);
    this.__yProperty.setNow(y);
    this.__zProperty.setNow(z);
  }

  copy(other)
  {
    // assertArgs(arguments, 1, true);
    this.x = other.x;
    this.y = other.y;
    this.z = other.z;
  }
}
