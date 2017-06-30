class Icon extends Empty
{
  constructor()
  {
    super();

    this.color = new THREE.Vector4(0.5, 0, 0.5, 1); // Haha, weird!
    this.size = 0.1;
    
    this.trigger = new Empty();
    this.mesh = new Empty();
    this.label = new SceneLabel("", 0.06, Alignment.center, verreciel.grey);
    this.label.position.set(0,-0.3,-0.35);
    this.add(this.label);
    
    this.wire = new SceneLine([], verreciel.white);
    this.wire.position.set(0,0,-0.01);
    this.wire.hide();
    this.add(this.wire);
    
    this.add(this.mesh);
    this.add(this.label);
    this.add(this.trigger);
    this.add(this.wire);
  }
  
  addHost(host)
  {
    this.host = host;
    this.label.update(this.host.name);
  }
  
  whenStart()
  {
    super.whenStart();
    if (this.host.mapRequirement != null)
    {
      this.label.update(verreciel.cyan);
    }
  }
  
  onUpdate()
  {
    if (this.host.isComplete == null)
    {
      this.color = verreciel.white;
    }
    else if (this.host.isComplete == false)
    {
      this.color = verreciel.red;
    }
    else if (this.host.isComplete == true)
    {
      this.color = verreciel.cyan;
    }
    
    this.mesh.updateChildrenColors(this.color);
  }
  
  close()
  {
  }
}
