class AnimatedXYZ
{
  constructor(animator, target, property, angles = false, snapToEnd = false)
  {
    assertArgs(arguments, 3);
    this.snapToEnd = snapToEnd;
    var xyz = target[property];
    this.__xProperty = new AnimatedProperty(animator, xyz, "x", angles, snapToEnd);
    this.__yProperty = new AnimatedProperty(animator, xyz, "y", angles, snapToEnd);
    this.__zProperty = new AnimatedProperty(animator, xyz, "z", angles, snapToEnd);
  }
  
  get x()
  {
    return this.__xProperty.value;
  }

  set x(value)
  {
    let animation = this.__xProperty.animation;
    this.__xProperty.value = value;
    if (this.snapToEnd && animation && !this.__xProperty.animation)
    {
      this.fastForward();
    }
  }

  get y()
  {
    return this.__yProperty.value;
  }

  set y(value)
  {
    let animation = this.__yProperty.animation;
    this.__yProperty.value = value;
    if (this.snapToEnd && animation && !this.__yProperty.animation)
    {
      this.fastForward();
    }
  }

  get z()
  {
    return this.__zProperty.value;
  }

  set z(value)
  {
    let animation = this.__zProperty.animation;
    this.__zProperty.value = value;
    if (animation && !this.__zProperty.animation)
    {
      this.fastForward();
    }
  }

  set(x, y, z)
  {
    assertArgs(arguments, 3, true);
    this.x = x;
    this.y = y;
    this.z = z;
  }

  setNow(x, y, z)
  {
    assertArgs(arguments, 3, true);
    this.__xProperty.setNow(x);
    this.__yProperty.setNow(y);
    this.__zProperty.setNow(z);
  }

  copy(other)
  {
    assertArgs(arguments, 1, true);
    this.x = other.x;
    this.y = other.y;
    this.z = other.z;
  }

  fastForward()
  {
    this.setNow(this.x, this.y, this.z);
  }
}
