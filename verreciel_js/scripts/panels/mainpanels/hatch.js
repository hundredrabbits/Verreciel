class Hatch extends MainPanel
{
  constructor()
  {
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
    
    this.mainNode.add(new SceneTrigger(this, new THREE.Vector2(2, 2)));
    
    this.decals.empty();
    
    this.detailsLabel.update("empty", verreciel.grey);
  }
  
  whenStart()
  {
    super.whenStart();
    
    this.update();
  }

  touch(id = 0)
  {
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
    var load = (this.port.origin == null) ? null : this.port.origin.event;
    
    if (load != null)
    {
      if (load.isQuest == true || (load instanceof Item) == false)
      {
        this.detailsLabel.update("error", verreciel.red);
        this.outline.updateChildrenColors(verreciel.red);
      }
      else
      {
        this.detailsLabel.update("jetison", verreciel.cyan);
        this.outline.updateChildrenColors(verreciel.cyan);
      }
    }
    else
    {
      this.detailsLabel.update("empty", verreciel.grey);
      this.outline.updateChildrenColors(verreciel.grey);
    }
  }
  
  onConnect()
  {
    super.onConnect();
    
    if (this.port.origin == null && this.port.origin.host == null && this.port.origin.host == verreciel.pilot)
    {
      this.detailsLabel.update("erase game ?", verreciel.red);
      this.outline.updateChildrenColors(verreciel.red);
    }
  }
  
  onDisconnect()
  {
    this.update();
  }
  
  onInstallationBegin()
  {
    super.onInstallationBegin();
    
    verreciel.player.lookAt(-315);
  }
}
