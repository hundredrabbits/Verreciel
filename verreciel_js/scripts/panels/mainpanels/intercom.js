//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Intercom extends MainPanel
{

  // MARK: Default -
  
  constructor()
  {
    // assertArgs(arguments, 0);
    super();
    
    this.name = "mission";
    this.details = "displays informations";

    this.selector = new SceneLabel(">", 0.1, Alignment.left);
  
    this.locationPanel = new Empty();
    this.mainNode.add(this.locationPanel);
    
    this.defaultPanel = new Empty();
    this.defaultPanel.position.set(0,0,0);
    
    this.systemLabel = new SceneLabel("system", 0.1, Alignment.right, verreciel.grey);
    this.defaultPanel.add(this.systemLabel);
    this.systemValueLabel = new SceneLabel("Loiqe", 0.1, Alignment.left, verreciel.white);
    this.defaultPanel.add(this.systemValueLabel);
    
    this.systemLabel.position.set(-0.1,1 - 0.2,0);
    this.systemValueLabel.position.set(0.1,1 - 0.2,0);
    
    this.distanceLabel = new SceneLabel("distance", 0.1, Alignment.right, verreciel.grey);
    this.defaultPanel.add(this.distanceLabel);
    this.distanceValueLabel = new SceneLabel("324.4", 0.1, Alignment.left, verreciel.white);
    this.defaultPanel.add(this.distanceValueLabel);
    
    this.distanceLabel.position.set(-0.1,1 - 0.6,0);
    this.distanceValueLabel.position.set(0.1,1 - 0.6,0);
    
    this.typeLabel = new SceneLabel("type", 0.1, Alignment.right, verreciel.grey);
    this.defaultPanel.add(this.typeLabel);
    this.typeValueLabel = new SceneLabel("harvest", 0.1, Alignment.left, verreciel.white);
    this.defaultPanel.add(this.typeValueLabel);
    
    this.typeLabel.position.set(-0.1,1 - 1.0,0);
    this.typeValueLabel.position.set(0.1,1 - 1.0,0);
    
    this.statusLabel = new SceneLabel("status", 0.1, Alignment.right, verreciel.grey);
    this.defaultPanel.add(this.statusLabel);
    this.statusValueLabel = new SceneLabel("completed", 0.1, Alignment.left, verreciel.white);
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
    this.drawDecals();
    this.locationPanel.hide();
  }
  
  whenRenderer()
  {
    // assertArgs(arguments, 0);
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
      
      this.systemValueLabel.updateText(target.system);
      this.distanceLabel.updateText("Distance");
      this.distanceValueLabel.updateText(verreciel.capsule.isDockedAtLocation(target) ? "docked" : verreciel.space.printDistance(target.distance));
      this.typeLabel.updateText("type");
      this.typeValueLabel.updateText(target.name);
      this.detailValueLabel.updateText(target.details);
      
      if (target.isComplete == null)
      {
        this.statusValueLabel.updateText("--", verreciel.white);
      }
      else if (target.isComplete == true)
      {
        this.statusValueLabel.updateText("complete", verreciel.cyan);
      }
      else if (target.isComplete == false)
      {
        this.statusValueLabel.updateText("quest", verreciel.red);
      }
    }
    else
    {
      this.systemValueLabel.updateText(verreciel.capsule.system);
      this.distanceLabel.updateText("Position");
      this.distanceValueLabel.updateText(verreciel.space.printPosition(verreciel.capsule.at));
      this.typeValueLabel.updateText("--");
      this.statusValueLabel.updateText("in flight", verreciel.white);
      this.detailValueLabel.updateText("--");
    }
  }
  
  touch(id)
  {
    // assertArgs(arguments, 1);
    this.refresh();
    verreciel.music.playEffect("click3");
    return false;
  }
  
  refresh()
  {
    // assertArgs(arguments, 0);
    if( this.isInstalled == true )
    {
      if (verreciel.capsule.location == null)
      {
        this.nameLabel.updateText("mission", verreciel.white);
      }
      else if (verreciel.capsule.location.isComplete == null)
      {
        this.nameLabel.updateText(verreciel.capsule.location.name, verreciel.white);
      }
      else if (verreciel.capsule.location.isComplete == true)
      {
        this.nameLabel.updateText(verreciel.capsule.location.name, verreciel.cyan);
      }
      else
      {
        this.nameLabel.updateText(verreciel.capsule.location.name, verreciel.red);
      }
    }
  }
  
  // MARK: Custom -
  
  complete()
  {
    // assertArgs(arguments, 0);
    // Animate

    if (this.isCompleting)
    {
      return;
    }
    this.isCompleting = true;
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    this.locationPanel.position.set(0,0,-0.5);
    this.locationPanel.hide();
    
    verreciel.animator.completionBlock = function(){

      // this.defaultPanel.position.set(0,0,-0.5);
      
      verreciel.animator.begin();
      verreciel.animator.animationDuration = 0.5;
      
      this.defaultPanel.position.set(0,0,0);
      this.defaultPanel.show();
      
      verreciel.animator.completionBlock = function(){
        this.refresh();
      }.bind(this);
      verreciel.animator.commit();
    }.bind(this);
    verreciel.animator.commit();
    this.isCompleting = false;
  }
  
  connectToLocation(location)
  {
    // assertArgs(arguments, 1);
    this.locationPanel.empty();
    let panel = location.panel;
    if (panel != null)
    {
      this.locationPanel.add(panel);
    }
    else
    {
      return;
    }
    
    // Animate
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    this.defaultPanel.position.set(0,0,-0.5);
    this.defaultPanel.hide();
    
    verreciel.animator.completionBlock = function(){
      
      this.locationPanel.position.set(0,0,-0.5);
      
      if (verreciel.capsule.location != null)
      {
        this.nameLabel.updateText(null); // TODO: Surely this is meant to contain something?
      }
      
      verreciel.animator.begin();
      verreciel.animator.animationDuration = 0.5;
      
      this.locationPanel.position.set(0,0,0);
      this.locationPanel.show();
      this.refresh();
      
      verreciel.animator.commit();
    }.bind(this);
    verreciel.animator.commit();
    
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
    // assertArgs(arguments, 0);
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    this.locationPanel.position.set(0,0,-0.5);
    this.locationPanel.hide();
    
    verreciel.animator.completionBlock = function(){
      
      this.defaultPanel.position.set(0,0,-0.5);
      
      verreciel.animator.begin();
      verreciel.animator.animationDuration = 0.5;
      
      this.defaultPanel.position.set(0,0,0);
      this.defaultPanel.show();
      this.refresh();
      
      verreciel.animator.completionBlock = function(){
        this.locationPanel.empty();
      }.bind(this);
      verreciel.animator.commit();
    }.bind(this);
    verreciel.animator.commit();
    
    this.port.removeEvent();
  }
  
  onInstallationBegin()
  {
    // assertArgs(arguments, 0);
    super.onInstallationBegin();
    
    verreciel.player.lookAt(-180);
  }
  
  onInstallationComplete()
  {
    // assertArgs(arguments, 0);
    super.onInstallationComplete();
    
    this.touch(1);
  }
  
  onConnect()
  {
    // assertArgs(arguments, 0);
    if (verreciel.capsule.isDocked == true)
    {
      verreciel.capsule.location.onConnect();
    }
  }
  
  onDisconnect()
  {
    // assertArgs(arguments, 0);
    if (verreciel.capsule.isDocked == true)
    {
      verreciel.capsule.location.onDisconnect();
    }
  }
}
