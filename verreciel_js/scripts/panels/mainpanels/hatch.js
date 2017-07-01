class Hatch extends MainPanel
{
  constructor()
  {
    assertArgs(arguments, 0);
    super();

    this.outline = new Empty();
    this.count = 0;
    
    this.name = "hatch";
    this.details = "jetisons items";
    
    this.mainNode.add(new SceneLine([new THREE.Vector3( 0, 0.7,  0),  new THREE.Vector3(0.7, 0, 0),], verreciel.grey));
    this.mainNode.add(new SceneLine([new THREE.Vector3( 0.7, 0,  0), new THREE.Vector3(0, -0.7, 0),], verreciel.grey));
    this.mainNode.add(new SceneLine([new THREE.Vector3( -0.7, 0,  0), new THREE.Vector3(0, 0.7, 0),], verreciel.grey));
    this.mainNode.add(new SceneLine([new THREE.Vector3( -0.7, 0,  0), new THREE.Vector3(0, -0.7, 0),], verreciel.grey));
    
    let outline1 = new SceneLine([new THREE.Vector3( 0, 0.5,  0), new THREE.Vector3(0.5, 0, 0),], verreciel.red);
    this.outline.add(outline1);
    let outline2 = new SceneLine([new THREE.Vector3( 0.5, 0,  0), new THREE.Vector3(0, -0.5, 0),], verreciel.red);
    this.outline.add(outline2);
    let outline3 = new SceneLine([new THREE.Vector3( -0.5, 0,  0), new THREE.Vector3(0, 0.5, 0),], verreciel.red);
    this.outline.add(outline3);
    let outline4 = new SceneLine([new THREE.Vector3( -0.5, 0,  0), new THREE.Vector3(0, -0.5, 0),], verreciel.red);
    this.outline.add(outline4);
    
    this.mainNode.add(this.outline);
    
    // Trigger
    
    this.mainNode.add(new SceneTrigger(this, 2, 2));
    
    this.decals.empty();
    
    this.detailsLabel.updateText("empty", verreciel.grey);
  }
  
  whenStart()
  {
    assertArgs(arguments, 0);
    super.whenStart();
    
    this.update();
  }

  touch(id = 0)
  {
    assertArgs(arguments, 1);
    if (this.port.isReceiving() == false)
    {
      return false;
    }
    if (this.port.origin.event.isQuest == true)
    {
      return false;
    }
    
    if (this.port.origin.host == verreciel.pilot)
    {
      this.game.erase();
      return true;
    }
    
    this.port.origin.removeEvent();
    this.count += 1;
    this.update();
    verreciel.missions.refresh();
    verreciel.music.playEffect("click3");
    return true;
  }
  
  update()
  {
    assertArgs(arguments, 0);
    var load = (this.port.origin == null) ? null : this.port.origin.event;
    
    if (load != null)
    {
      if (load.isQuest == true || (load instanceof Item) == false)
      {
        this.detailsLabel.updateText("error", verreciel.red);
        this.outline.updateChildrenColors(verreciel.red);
      }
      else
      {
        this.detailsLabel.updateText("jetison", verreciel.cyan);
        this.outline.updateChildrenColors(verreciel.cyan);
      }
    }
    else
    {
      this.detailsLabel.updateText("empty", verreciel.grey);
      this.outline.updateChildrenColors(verreciel.grey);
    }
  }
  
  onConnect()
  {
    assertArgs(arguments, 0);
    super.onConnect();
    
    if (this.port.origin == null && this.port.origin.host == null && this.port.origin.host == verreciel.pilot)
    {
      this.detailsLabel.updateText("erase game ?", verreciel.red);
      this.outline.updateChildrenColors(verreciel.red);
    }
  }
  
  onDisconnect()
  {
    assertArgs(arguments, 0);
    this.update();
  }
  
  onInstallationBegin()
  {
    assertArgs(arguments, 0);
    super.onInstallationBegin();
    
    verreciel.player.lookAt(-315);
  }
}
