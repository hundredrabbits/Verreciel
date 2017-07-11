class Structure extends Empty
{
  constructor()
  {
    // assertArgs(arguments, 0);
    super();

    this.morphTime = 0;

    this.rot = new Empty();
    this.pos = new Empty();
    this.root = new Empty();
    
    this.add(this.rot);
    this.rot.add(this.pos);
    this.pos.add(this.root);
  }
  
  addHost(host)
  {
    // assertArgs(arguments, 1);
    this.host = host;
  }
  
  whenRenderer()
  {
    // assertArgs(arguments, 0);
    super.whenRenderer();
    
    let distance;
    if (this.host instanceof LocationConstellation)
    {
      distance = this.host.distance/Settings.approach * 100;
    }
    else
    {
      distance = Math.pow(this.host.distance/Settings.approach, 5) * 1000.0;
    }
    
    this.pos.position.set(0,distance,0);
    
    if (verreciel.capsule.isDockedAtLocation(this.host))
    {
      this.rot.rotation.z = degToRad(0);
    }
    else if (verreciel.capsule.lastLocation == this.host)
    {
      this.rot.rotation.z = degToRad(0);
      this.pos.position.set(0,distance * -1,0);
    }
    else
    {
      this.rot.rotation.z = degToRad(this.host.align);
    }
    
    this.rot.rotation.y = degToRad(verreciel.capsule.direction);
    
    if (this.host.distance > Settings.approach)
    {
      this.onLeave();
    }
  }

  onDock()
  {
    // assertArgs(arguments, 0);
    this.show();
    this.morph();
  }
  
  onSight()
  {
    // assertArgs(arguments, 0);
    // this.show();
  }
  
  onUndock()
  {
    // assertArgs(arguments, 0);
    
  }
  
  onComplete()
  {
    // assertArgs(arguments, 0);
    this.update();
  }
  
  onLeave()
  {
    // assertArgs(arguments, 0);
    this.removeFromParentNode();
  }
  
  dockUpdate()
  {
    // assertArgs(arguments, 0);
  
  }
  
  sightUpdate()
  {
    // assertArgs(arguments, 0);
  
  }
  
  update()
  {
    // assertArgs(arguments, 0);
    super.update();
    
    if (this.host.isComplete == null)
    {
      this.root.updateChildrenColors(verreciel.grey);
    }
    else if (this.host.isComplete == true)
    {
      this.root.updateChildrenColors(verreciel.cyan);
    }
    else
    {
      this.root.updateChildrenColors(verreciel.red);
    }
  }
  
  morph()
  {
    // assertArgs(arguments, 0);
    this.morphTime += 1;
    if (verreciel.capsule.isDocked == true)
    {
      delay(2, this.morph.bind(this));
    }
  }
}
