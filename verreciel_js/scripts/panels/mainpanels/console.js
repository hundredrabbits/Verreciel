class Console extends MainPanel
{
  constructor()
  {
    super();
    
    this.lines = [
      new ConsoleLine(),
      new ConsoleLine(),
      new ConsoleLine(),
      new ConsoleLine(),
      new ConsoleLine(),
      new ConsoleLine(),
    ];

    this.name = "console";
    this.details = "inspects events"
    
    this.lines[0].position.set( Templates.leftMargin,  Templates.lineSpacing * 2.5,  0);
    this.lines[1].position.set( Templates.leftMargin,  Templates.lineSpacing * 1.5,  0);
    this.lines[2].position.set( Templates.leftMargin,  Templates.lineSpacing * 0.5,  0);
    this.lines[3].position.set( Templates.leftMargin,  -Templates.lineSpacing * 0.5,  0);
    this.lines[4].position.set( Templates.leftMargin,  -Templates.lineSpacing * 1.5,  0);
    this.lines[5].position.set( Templates.leftMargin,  -Templates.lineSpacing * 2.5,  0);
    
    for (let line of this.lines)
    {
      this.mainNode.add(line);
    }
    
    this.footer.add(new SceneHandle(new THREE.Vector3(-1,0,0), this));
  }
  
  onConnect()
  {
    super.onDisconnect();
    
    this.nameLabel.update(this.port.origin.host.name + " > Port", verreciel.cyan);
    
    if (this.port.origin.event != null)
    {
      this.inject(this.port.origin.event.payload());
    }
    else if (this.port.origin.host != null)
    {
      this.inject(this.port.origin.host.payload());
    }
  }
  
  onDisconnect()
  {
    super.onDisconnect();
    
    this.nameLabel.update("Console", verreciel.grey);
    this.inject(this.defaultPayload());
  }
  
  whenStart()
  {
    super.whenStart();
    
    this.nameLabel.update(verreciel.grey);
    this.inject(this.defaultPayload());
  }
  
  whenTime()
  {
    super.whenTime();
    
    
  }
  
  clear()
  {
    for (let line of this.lines) 
    {
      line.update(new ConsoleData());
    }
  }
  
  inject(payload)
  {
    this.clear();
    
    var id = 0;
    for (let data in payload.data)
    {
      this.lines[id].update(data);
      id += 1;
    }
    
    // Animate
    
    var count = 0;
    for (let line of this.lines ) 
    {
      line.position.z = count * -0.1;
      line.visible = false;
      count += 1;
    }
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // for (let line of this.lines) 
    // {
      // line.position.z = 0;
      // line.visible = true;
    // }
    
    // SCNTransaction.commit()
  }
  
  defaultPayload()
  {
    return new ConsolePayload([
      new ConsoleData("nataniev os", "OK", verreciel.white),
      new ConsoleData("systems", verreciel.capsule.systemsInstalledCount() + "/" + verreciel.capsule.systemsCount() ,verreciel.grey),
      new ConsoleData("", "",verreciel.grey),
      new ConsoleData("",verreciel.grey),
      new ConsoleData("",verreciel.grey),
      new ConsoleData("",verreciel.grey),
    ])
  }
  
  onInstallationBegin()
  {
    super.onInstallationBegin();
    
    this.player.lookAt(-270);
  }
  
  onInstallationComplete()
  {
    super.onInstallationComplete();
    
    this.inject(this.defaultPayload());
  }
}

class ConsoleLine extends Empty
{
  constructor(data = null)
  {
    super();
    
    this.port = new ScenePortRedirect(this);
    this.port.position.set(0, 0, 0);
    this.port.hide();
    this.add(this.port);
    
    this.textLabel = new SceneLabel("", 0.1, Alignment.left);
    this.textLabel.position.set(0.3, 0, 0);
    this.add(this.textLabel);
    
    this.detailsLabel = new SceneLabel("", 0.075, Alignment.right, verreciel.grey);
    this.detailsLabel.position.set(3.2, 0, 0);
    this.add(this.detailsLabel);
  }
  
  update(data)
  {
    this.detailsLabel.update(data.details);
    
    if (data.event != null)
    {
      this.textLabel.update(data.text, data.color);
      this.port.addEvent(data.event);
      this.port.enable();
      this.port.show();
      this.textLabel.position.set(0.3, 0, 0);
    }
    else
    {
      this.textLabel.update("> " + data.text, data.color);
      this.port.disable();
      this.port.hide();
      this.textLabel.position.set(0, 0, 0);
    }
  }
}

class ConsoleData
{
  constructor(text = "", details = "", event = null, color = verreciel.white)
  {
    this.text = text;
    this.details = details;
    this.event = event;
    this.color = color;
  }
}

class ConsolePayload
{
  constructor(data)
  {
    this.data = data;
  }
}

