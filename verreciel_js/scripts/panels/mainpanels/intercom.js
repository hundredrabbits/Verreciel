class Intercom extends MainPanel
{

  // MARK: Default -
  
  constructor()
  {
    super();
    
    this.name = "mission";
    this.details = "displays informations";

    this.selector = new SceneLabel(">", Alignment.left);
  
    this.locationPanel = new Panel();
    this.mainNode.add(this.locationPanel);
    
    this.defaultPanel = new Empty();
    this.defaultPanel.position.set(0,0,0);
    
    this.systemLabel = new SceneLabel("system", Alignment.right, verreciel.grey);
    this.defaultPanel.add(this.systemLabel);
    this.systemValueLabel = new SceneLabel("Loiqe", Alignment.left, verreciel.white);
    this.defaultPanel.add(this.systemValueLabel);
    
    this.systemLabel.position.set(-0.1,1 - 0.2,0);
    this.systemValueLabel.position.set(0.1,1 - 0.2,0);
    
    this.distanceLabel = new SceneLabel("distance", Alignment.right, verreciel.grey);
    this.defaultPanel.add(this.distanceLabel);
    this.distanceValueLabel = new SceneLabel("324.4", Alignment.left, verreciel.white);
    this.defaultPanel.add(this.distanceValueLabel);
    
    this.distanceLabel.position.set(-0.1,1 - 0.6,0);
    this.distanceValueLabel.position.set(0.1,1 - 0.6,0);
    
    this.typeLabel = new SceneLabel("type", Alignment.right, verreciel.grey);
    this.defaultPanel.add(this.typeLabel);
    this.typeValueLabel = new SceneLabel("harvest", Alignment.left, verreciel.white);
    this.defaultPanel.add(this.typeValueLabel);
    
    this.typeLabel.position.set(-0.1,1 - 1.0,0);
    this.typeValueLabel.position.set(0.1,1 - 1.0,0);
    
    this.statusLabel = new SceneLabel("status", Alignment.right, verreciel.grey);
    this.defaultPanel.add(this.statusLabel);
    this.statusValueLabel = new SceneLabel("completed", Alignment.left, verreciel.white);
    this.defaultPanel.add(this.statusValueLabel);
    
    this.statusLabel.position.set(-0.1,1 - 1.4,0);
    this.statusValueLabel.position.set(0.1,1 - 1.4,0);
    
    this.detailLabel = new SceneLabel("details", 0.075, Alignment.right, verreciel.grey);
    this.defaultPanel.add(this.detailLabel);
    this.detailValueLabel = new SceneLabel("key", 0.075, Alignment.left, verreciel.white);
    this.defaultPanel.add(this.detailValueLabel);
    
    this.detailLabel.position.set(-0.1,1 - 1.8,0);
    this.detailValueLabel.position.set(0.1,1 - 1.8,0);
    
    this.mainNode.add(this.defaultPanel);
    
    this.footer.add(new SceneHandle(new THREE.Vector3(0,0,1), this));
    
    this.locationPanel.hide();
  }
  
  whenRenderer()
  {
    super.whenRenderer();
    
    if (verreciel.capsule.isDocked && 
        verreciel.capsule.location.isComplete != null && 
        verreciel.capsule.location.isComplete == false
      )
    {
      this.locationPanel.update();
    }
    else if (verreciel.capsule.location != null || verreciel.radar.port.hasEvent() == true)
    {
      let target = (verreciel.radar.port.hasEvent() == true ) ? verreciel.radar.port.event : verreciel.capsule.location;
      
      this.systemValueLabel.update(target.system);
      this.distanceLabel.update("Distance");
      this.distanceValueLabel.update( (verreciel.capsule.isDockedAtLocation(target) ? "docked" : (target.distance * 19).toFixed(2)) );
      this.typeLabel.update("type");
      this.typeValueLabel.update(target.name);
      this.detailValueLabel.update(target.details);
      
      if (target.isComplete == null)
      {
        this.statusValueLabel.update("--", verreciel.white);
      }
      else if (target.isComplete == true)
      {
        this.statusValueLabel.update("complete", verreciel.cyan);
      }
      else if (target.isComplete == false)
      {
        this.statusValueLabel.update("quest", verreciel.red);
      }
    }
    else
    {
      this.systemValueLabel.update(verreciel.capsule.system);
      this.distanceLabel.update("Position");
      this.distanceValueLabel.update(verreciel.capsule.at.x.toFixed(0) + "," + verreciel.capsule.at.y.toFixed(0));
      this.typeValueLabel.update("--");
      this.statusValueLabel.update("in flight", verreciel.white);
      this.detailValueLabel.update("--");
    }
  }
  
  touch(id)
  {
    this.refresh();
    this.music.playEffect("click3");
    return false;
  }
  
  refresh()
  {
    if( this.isInstalled == true )
    {
      if (verreciel.capsule.location == null)
      {
        this.nameLabel.update("mission", verreciel.white);
      }
      else if (verreciel.capsule.location.isComplete == null)
      {
        this.nameLabel.update(verreciel.capsule.location.name, verreciel.white);
      }
      else if (verreciel.capsule.location.isComplete == true)
      {
        this.nameLabel.update(verreciel.capsule.location.name, verreciel.cyan);
      }
      else
      {
        this.nameLabel.update(verreciel.capsule.location.name, verreciel.red);
      }
    }
  }
  
  // MARK: Custom -
  
  complete()
  {
    // Animate
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // this.locationPanel.position.set(0,0,-0.5);
    // this.locationPanel.hide();
    
    // SCNTransaction.completionBlock = {

      // this.defaultPanel.position.set(0,0,-0.5);
      
      // TODO: SCNTransaction

      // SCNTransaction.begin()
      // SCNTransaction.animationDuration = 0.5
      
      // this.defaultPanel.position.set(0,0,0);
      // this.defaultPanel.show();
      
      // SCNTransaction.completionBlock = {
        // this.refresh();
      // }
      // SCNTransaction.commit()
    // }
    // SCNTransaction.commit()
  }
  
  connectToLocation(location)
  {
    this.locationPanel.empty();
    if (location.panel() != null)
    {
      this.locationPanel.add(location.panel());
    }
    else
    {
      return;
    }
    
    // Animate
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // this.defaultPanel.position.set(0,0,-0.5);
    // this.defaultPanel.hide();
    
    // SCNTransaction.completionBlock = {
      
      // this.locationPanel.position.set(0,0,-0.5);
      
      // if (verreciel.capsule.location != null)
      // {
        // this.nameLabel.update();
      // }
      
      // SCNTransaction.begin()
      // SCNTransaction.animationDuration = 0.5
      
      // this.locationPanel.position.set(0,0,0);
      // this.locationPanel.show();
      // this.refresh();
      
      // SCNTransaction.commit()
    // }
    // SCNTransaction.commit()
    
    this.port.addEvent(location);
    
    if (location.isPortEnabled == true)
    {
      this.port.enable();
    }
    else
    {
      this.port.disable();
    }
  }
  
  disconnectFromLocation()
  {
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // this.locationPanel.position.set(0,0,-0.5);
    // this.locationPanel.hide();
    
    // SCNTransaction.completionBlock = {
      
      // this.defaultPanel.position.set(0,0,-0.5);
      
      // SCNTransaction.begin()
      // SCNTransaction.animationDuration = 0.5
      
      // this.defaultPanel.position.set(0,0,0);
      // this.defaultPanel.show();
      // this.refresh();
      
      // SCNTransaction.completionBlock = {
        // this.locationPanel.empty();
      // }
      // SCNTransaction.commit()
    // }
    // SCNTransaction.commit()
    
    this.port.removeEvent();
  }
  
  onInstallationBegin()
  {
    super.onInstallationBegin();
    
    verreciel.player.lookAt(-180);
  }
  
  onInstallationComplete()
  {
    super.onInstallationComplete();
    
    this.touch(1);
  }
  
  onConnect()
  {
    if (verreciel.capsule.isDocked == true)
    {
      verreciel.capsule.location.onConnect();
    }
  }
  
  onDisconnect()
  {
    if (verreciel.capsule.isDocked == true)
    {
      verreciel.capsule.location.onDisconnect();
    }
  }
}
