class Structure extends Empty
{
  constructor()
  {
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
    this.host = host;
  }
  
  whenRenderer()
  {
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
      rot.rotation.z = degToRad(this.host.align);
    }
    
    rot.rotation.y = degToRad(verreciel.capsule.direction);
    
    if (this.host.distance > Settings.approach)
    {
      this.onLeave();
    }
  }

  onDock()
  {
    this.morph();
  }
  
  onSight()
  {
    this.show();
  }
  
  onUndock()
  {
    
  }
  
  onComplete()
  {
    this.update();
  }
  
  onLeave()
  {
    this.removeFromParentNode();
  }
  
  dockUpdate()
  {
  
  }
  
  sightUpdate()
  {
  
  }
  
  update()
  {
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
    this.morphTime += 1;
    if (verreciel.capsule.isDocked == true)
    {
      delay(2, this.morph.bind(this));
    }
  }
}
