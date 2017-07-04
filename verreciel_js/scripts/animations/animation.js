class Animation
{
  constructor(name, duration, ease, properties, completionBlock)
  {
    this.name = name;
    this.duration = duration;
    this.ease = ease;
    this.properties = properties;
    this.completionBlock = completionBlock;
    this.percent = 0;
    this.lastFrameTime = Date.now();
    this.completed = false;

    for (let property of this.properties)
    {
      if (property.registered)
      {
        property.commit(this.name);
      }
    }
    this.tick();
  }

  tick()
  {
    if (this.completed)
    {
      return;
    }
    let frameTime = Date.now();
    let secondsElapsed = (frameTime - this.lastFrameTime) / 1000;
    this.lastFrameTime = frameTime;

    var percentElapsed = secondsElapsed / this.duration;
    this.percent += percentElapsed;

    if (this.percent > 1)
    {
      this.percent = 1;
    }

    let easedPercent = this.ease(this.percent, 0, 1, 1);

    for (let property of this.properties)
    {
      if (property.registered)
      {
        property.interpolate(easedPercent);
        if (this.percent >= 1)
        {
          property.animation = null;
          property.registered = false;
        }
      }
    }

    if (this.percent < 1)
    {
      requestAnimationFrame(this.tick.bind(this));
    }
    else
    {
      verreciel.animator.completeAnimation(this.name);
    }
  }

  complete()
  {
    this.completed = true;
    if (this.completionBlock != null)
    {
      this.completionBlock();
    }
  }
}
