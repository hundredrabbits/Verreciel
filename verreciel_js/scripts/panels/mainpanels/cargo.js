class Cargo extends MainPanel
{
  constructor()
  {
    super();

    this.cargohold = new CargoHold();
    
    this.name = "cargo";
    this.details = "stores items";
    this.port.event = this.cargohold;
    this.uploadPercentage = 0;
    
    this.mainNode.position.set(0, 0, Templates.radius);

    // Quantity
    
    this.line1 = new SceneLine([new THREE.Vector3(-0.5, -0.5, 0),  new THREE.Vector3(0.5, -0.5, 0)],verreciel.grey);
    this.line2 = new SceneLine([new THREE.Vector3(-0.5, -0.3, 0),  new THREE.Vector3(0.5, -0.3, 0)],verreciel.grey);
    this.line3 = new SceneLine([new THREE.Vector3(-0.5, -0.1, 0),  new THREE.Vector3(0.5, -0.1, 0)],verreciel.grey);
    this.line4 = new SceneLine([new THREE.Vector3(-0.5, 0.1, 0),  new THREE.Vector3(0.5, 0.1, 0)],verreciel.grey);
    this.line5 = new SceneLine([new THREE.Vector3(-0.5, 0.3, 0),  new THREE.Vector3(0.5, 0.3, 0)],verreciel.grey);
    this.line6 = new SceneLine([new THREE.Vector3(-0.5, 0.5, 0),  new THREE.Vector3(0.5, 0.5, 0)],verreciel.grey);
    
    this.mainNode.add(this.line1);
    this.mainNode.add(this.line2);
    this.mainNode.add(this.line3);
    this.mainNode.add(this.line4);
    this.mainNode.add(this.line5);
    this.mainNode.add(this.line6);
    
    // Trigger
    
    this.trigger = new SceneTrigger(this, new THREE.Vector2(2, 2), 1);
    this.mainNode.add(this.trigger);
    
    this.decals.empty();
    
    this.detailsLabel.update("Empty", verreciel.grey);
  }
  
  contains(event)
  {
    for (let item of this.cargohold.content)
    {
      if (item == event)
      {
        return true;
      }
    }
    return false;
  }
  
  containsLike(target)
  {
    for (let item of this.cargohold.content)
    {
      if (item.name == target.name && item.type == target.type)
      {
        return true;
      }
    }
    return false;
  }
  
  containsCount(count, target)
  {
    var count_actual = 0;
    for (let item of this.cargohold.content)
    {
      if (item.name == target.name && item.type == target.type)
      {
        count_actual += 1;
      }
    }
    if (count == count_actual)
    {
      return true;
    }
    return false;
  }
  
  // MARK: Add - 
  
  addItems(items)
  {
    for (let item of items)
    {
      this.addItem(item);
    }
    this.refresh();
  }
  
  addItem(item)
  {
    this.cargohold.content.push(item);
    this.refresh();
  }

  removeItem(target)
  {
    if (this.cargohold.content.count == 1)
    {
      this.line1.position.x = 0.25;
    }
    if (this.cargohold.content.count == 2)
    {
      this.line2.position.x = 0.25;
    }
    if (this.cargohold.content.count == 3)
    {
      this.line3.position.x = 0.25;
    }
    if (this.cargohold.content.count == 4)
    {
      this.line4.position.x = 0.25;
    }
    if (this.cargohold.content.count == 5)
    {
      this.line5.position.x = 0.25;
    }
    if (this.cargohold.content.count == 6)
    {
      this.line6.position.x = 0.25;
    }
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // if (this.cargohold.content.count == 1)
    // {
      // this.line1.position.x = 0;
    // }
    // if (this.cargohold.content.count == 2)
    // {
      // this.line2.position.x = 0;
    // }
    // if (this.cargohold.content.count == 3)
    // {
      // this.line3.position.x = 0;
    // }
    // if (this.cargohold.content.count == 4)
    // {
      // this.line4.position.x = 0;
    // }
    // if (this.cargohold.content.count == 5)
    // {
      // this.line5.position.x = 0;
    // }
    // if (this.cargohold.content.count == 6)
    // {
      // this.line6.position.x = 0;
    // }
    
    // SCNTransaction.completionBlock = { this.removeTransfer(target) }
    // SCNTransaction.commit()
  }
  
  removeTransfer(target)
  {
    let history = this.cargohold.content;
    this.cargohold.content = [];
    for (let event of history)
    {
      if (event == target)
      {
        continue;
      }
      this.cargohold.content.push(event);
    }
    
    this.refresh();
  }
  
  touch(id = 0)
  {
    this.refresh();
    
    if (this.port.isConnectedToPanel(verreciel.console) == true)
    {
      verreciel.console.onConnect();
    }
    
    verreciel.music.playEffect("click4");
        
    return true;
  }
  
  refresh()
  {
    let newCargohold = new CargoHold();
    for (let item of this.cargohold.content)
    {
      newCargohold.content.push(item);
    }
    this.port.event = newCargohold;
    
    // Animate
    
    this.line1.applyColor(verreciel.grey);
    this.line2.applyColor(verreciel.grey);
    this.line3.applyColor(verreciel.grey);
    this.line4.applyColor(verreciel.grey);
    this.line5.applyColor(verreciel.grey);
    this.line6.applyColor(verreciel.grey);
    
    if (this.cargohold.content.count > 0)
    {
      this.line1.applyColor( this.cargohold.content[0].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.count > 1)
    {
      this.line2.applyColor( this.cargohold.content[1].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.count > 2)
    {
      this.line3.applyColor( this.cargohold.content[2].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.count > 3)
    {
      this.line4.applyColor( this.cargohold.content[3].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.count > 4)
    {
      this.line5.applyColor( this.cargohold.content[4].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.count > 5)
    {
      this.line6.applyColor( this.cargohold.content[5].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    
    if (this.cargohold.content.count == 0)
    {
      this.detailsLabel.update("Empty", verreciel.grey);
    }
    else if (this.cargohold.content.count == 6)
    {
      this.detailsLabel.update("FULL", verreciel.red);
    }
    else
    {
      this.detailsLabel.update(this.cargohold.content.count + "/6", verreciel.white);
    }
  }
  
  onUploadComplete()
  {
    this.refresh();
    
    if (this.port.isConnectedToPanel(verreciel.console) == true)
    {
      verreciel.console.onConnect();
    }
    
    verreciel.music.playEffect("click3");
  }
  
  onConnect()
  {
    if (this.port.isReceivingEventOfTypeItem() == false)
    {
      this.detailsLabel.update("ERROR",verreciel.red);
      return;
    }
    if (this.port.event == null)
    {
      return;
    }
    if (this.port.origin != null && this.port.origin.host != null && (this.port.origin.host instanceof ConsoleLine))
    {
      this.detailsLabel.update("ERROR",verreciel.red);
      return;
    }
    
    if (this.cargohold.content.count < 6)
    {
      this.upload(this.port.event);
    }
  }
  
  // MARK: Upload -
  
  upload(item)
  {
    this.uploadedItem = item;
    this.uploadProgress();
  }
  
  uploadProgress()
  {
    if (this.port.origin == null)
    {
      this.uploadCancel();
      return;
    }
    
    this.uploadPercentage += Math.random() * 60/10;
    if (this.uploadPercentage > 100)
    {
      this.uploadComplete();
    }
    else
    {
      this.detailsLabel.update(this.uploadPercentage.toFixed(0) + "%", verreciel.grey);
    }

    delay(0.05, this.uploadProgress.bind(this));
  }
  
  uploadComplete()
  {
    if (this.cargohold.content.count == 0)
    {
      this.line1.position.x = -0.25;
    }
    if (this.cargohold.content.count == 1)
    {
      this.line2.position.x = -0.25;
    }
    if (this.cargohold.content.count == 2)
    {
      this.line3.position.x = -0.25;
    }
    if (this.cargohold.content.count == 3)
    {
      this.line4.position.x = -0.25;
    }
    if (this.cargohold.content.count == 4)
    {
      this.line5.position.x = -0.25;
    }
    if (this.cargohold.content.count == 5)
    {
      this.line6.position.x = -0.25;
    }
    
    // TODO: SCNTransaction

    // SCNTransaction.begin()
    // SCNTransaction.animationDuration = 0.5
    
    // if (this.cargohold.content.count == 0)
    // {
      // this.line1.position.x = 0;
    // }
    // if (this.cargohold.content.count == 1)
    // {
      // this.line2.position.x = 0;
    // }
    // if (this.cargohold.content.count == 2)
    // {
      // this.line3.position.x = 0;
    // }
    // if (this.cargohold.content.count == 3)
    // {
      // this.line4.position.x = 0;
    // }
    // if (this.cargohold.content.count == 4)
    // {
      // this.line5.position.x = 0;
    // }
    // if (this.cargohold.content.count == 5)
    // {
      // this.line6.position.x = 0;
    // }
    
    // SCNTransaction.completionBlock = { this.uploadTransfer() }
    // SCNTransaction.commit()
  }
  
  uploadTransfer()
  {
    if (this.port.origin != null)
    {
      let origin = this.port.origin.host;
      this.cargohold.content.push(this.port.syphon());
      if (origin != null)
      {
        origin.onUploadComplete();
      }
      this.onUploadComplete();
    }
    this.uploadPercentage = 0;
    this.refresh();
  }
  
  uploadCancel()
  {
    this.uploadPercentage = 0;
    this.refresh();
  }
  
  // MARK: Installation -
  
  onInstallationBegin()
  {
    super.onInstallationBegin();
    
    verreciel.player.lookAt(-225);
  }
}

class CargoHold extends Item
{
  constructor()
  {
    super("cargo");

    this.content = [];
    
    this.name = "cargo";
    this.type = ItemTypes.cargo;
    this.details = "storage";
    this.isQuest = true;
  }
  
  payload()
  {
    var data = [];
    
    for (let item of this.content)
    {
      data.push(new ConsoleData(item.name, item.type, item));
    }
    
    var i = 0;
    while (i < 6 - this.content.count)
    {
      data.push(new ConsoleData("--", verreciel.grey));
      i += 1;
    }
    
    return new ConsolePayload(data);
  }
}
