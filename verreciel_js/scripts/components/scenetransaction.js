class SceneTransaction
{
  constructor()
  {
    assertArgs(arguments, 0, true);
    this.begun = false;
    this.properties = [];
    this.ease = Penner.easeOutQuart;
  }

  begin()
  {
    assertArgs(arguments, 0, true);
    this.begun = true;
    this.properties.splice(0, this.properties.length);
  }

  registerProperty(property)
  {
    assertArgs(arguments, 1, true);
    if (!property.registered)
    {
      this.properties.push(property);
    }
  }

  commit()
  {
    assertArgs(arguments, 0, true);
    for (let property of this.properties)
    {
      property.registered = false;
      property.commit();
    }
    this.properties.splice(0, this.properties.length);

    this.begun = false;

    var animationDuration = this.animationDuration;
    this.animationDuration = 0;
    var completionBlock = this.completionBlock;
    this.completionBlock = null;
    delay(animationDuration, completionBlock);
  }
}

class ScenePropertyXYZ
{
  constructor(sceneTransaction, target, property, angles = false)
  {
    assertArgs(arguments, 3);
    var xyz = target[property];
    var xProperty = new SceneProperty(sceneTransaction, xyz, "x", angles);
    var yProperty = new SceneProperty(sceneTransaction, xyz, "y", angles);
    var zProperty = new SceneProperty(sceneTransaction, xyz, "z", angles);
    
    Object.defineProperties( this, {
      x:
      {
        get: function() { return xProperty.value; },
        set: function(value) { xProperty.value = value; }
      },
      y:
      {
        get: function() { return yProperty.value; },
        set: function(value) { yProperty.value = value; }
      },
      z:
      {
        get: function() { return zProperty.value; },
        set: function(value) { zProperty.value = value; }
      }
    });
  }

  set(x, y, z)
  {
    assertArgs(arguments, 3, true);
    this.x = x;
    this.y = y;
    this.z = z;
  }

  copy(other)
  {
    assertArgs(arguments, 1, true);
    this.x = other.x;
    this.y = other.y;
    this.z = other.z;
  }

  render()
  {
    assertArgs(arguments, 0, true);
    this.x.render();
    this.y.render();
    this.z.render();
  }
}

class SceneProperty
{
  constructor(sceneTransaction, target, property, isAngle = false)
  {
    assertArgs(arguments, 3);
    this.sceneTransaction = sceneTransaction;
    this.target = target;
    this.property = property;
    this.isAngle = isAngle;

    var value = this.target[this.property];
    if (this.isAngle) { value = sanitizeAngle(value); }

    Object.defineProperties( this, {
      value:
      {
        get: function() { return value; },
        set: function(newValue) {
          if (this.isAngle) { newValue = sanitizeAngle(newValue); }
          if (value == newValue) { return; }
          value = newValue;
          if (sceneTransaction.begun)
          {
            this.sceneTransaction.registerProperty(this);
          }
          else
          {
            this.target[this.property] = value;
          }
        }
      }
    });
  }

  commit()
  {
    assertArgs(arguments, 0, true);

    let oldValue = this.target[this.property];
    if (this.isAngle) { oldValue = sanitizeAngle(oldValue); }
    let newValue = this.value;

    if (oldValue == newValue)
    {
      return;
    }

    if (this.isAngle)
    {
      oldValue = newValue - sanitizeDiffAngle(newValue, oldValue);
    }

    let duration = this.sceneTransaction.animationDuration;
    let target = this.target;
    let property = this.property;
    let ease = this.sceneTransaction.ease;
    
    var percent = 0;
    var lastFrameTime = Date.now();
    function tick()
    {
      let frameTime = Date.now();
      let secondsElapsed = (frameTime - lastFrameTime) / 1000;
      lastFrameTime = frameTime;

      var percentElapsed = secondsElapsed / duration;
      percent += percentElapsed;

      // console.log("~~~", property, ":", oldValue, "-", newValue, "/", duration, "s", secondsElapsed, "@", percent);

      if (percent > 1)
      {
        percent = 1;
      }

      let easedPercent = ease(percent, 0, 1, 1);

      target[property] = newValue * easedPercent + oldValue * (1 - easedPercent);

      if (percent < 1)
      {
        requestAnimationFrame(tick);
      }
    }

    requestAnimationFrame(tick);
  }
}
