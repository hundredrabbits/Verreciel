class Cargo extends MainPanel
{
  constructor()
  {
    assertArgs(arguments, 0);
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
    
    this.trigger = new SceneTrigger(this, 2, 2, 1);
    this.mainNode.add(this.trigger);
    
    this.decals.empty();
    
    this.detailsLabel.updateText("Empty", verreciel.grey);
  }
  
  contains(event)
  {
    assertArgs(arguments, 1);
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
    assertArgs(arguments, 1);
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
    assertArgs(arguments, 2);
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
    assertArgs(arguments, 1);
    for (let item of items)
    {
      this.addItem(item);
    }
    this.refresh();
  }
  
  addItem(item)
  {
    assertArgs(arguments, 1);
    this.cargohold.content.push(item);
    this.refresh();
  }

  removeItem(target)
  {
    assertArgs(arguments, 1);
    if (this.cargohold.content.length == 1)
    {
      this.line1.position.x = 0.25;
    }
    if (this.cargohold.content.length == 2)
    {
      this.line2.position.x = 0.25;
    }
    if (this.cargohold.content.length == 3)
    {
      this.line3.position.x = 0.25;
    }
    if (this.cargohold.content.length == 4)
    {
      this.line4.position.x = 0.25;
    }
    if (this.cargohold.content.length == 5)
    {
      this.line5.position.x = 0.25;
    }
    if (this.cargohold.content.length == 6)
    {
      this.line6.position.x = 0.25;
    }
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    if (this.cargohold.content.length == 1)
    {
      this.line1.position.x = 0;
    }
    if (this.cargohold.content.length == 2)
    {
      this.line2.position.x = 0;
    }
    if (this.cargohold.content.length == 3)
    {
      this.line3.position.x = 0;
    }
    if (this.cargohold.content.length == 4)
    {
      this.line4.position.x = 0;
    }
    if (this.cargohold.content.length == 5)
    {
      this.line5.position.x = 0;
    }
    if (this.cargohold.content.length == 6)
    {
      this.line6.position.x = 0;
    }
    
    verreciel.animator.completionBlock = function(){ this.removeTransfer(target) }.bind(this);
    verreciel.animator.commit();
  }
  
  removeTransfer(target)
  {
    assertArgs(arguments, 1);
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
    assertArgs(arguments, 1);
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
    assertArgs(arguments, 0);
    let newCargohold = new CargoHold();
    for (let item of this.cargohold.content)
    {
      newCargohold.content.push(item);
    }
    this.port.event = newCargohold;
    
    // Animate
    
    this.line1.updateColor(verreciel.grey);
    this.line2.updateColor(verreciel.grey);
    this.line3.updateColor(verreciel.grey);
    this.line4.updateColor(verreciel.grey);
    this.line5.updateColor(verreciel.grey);
    this.line6.updateColor(verreciel.grey);
    
    if (this.cargohold.content.length > 0)
    {
      this.line1.updateColor( this.cargohold.content[0].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.length > 1)
    {
      this.line2.updateColor( this.cargohold.content[1].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.length > 2)
    {
      this.line3.updateColor( this.cargohold.content[2].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.length > 3)
    {
      this.line4.updateColor( this.cargohold.content[3].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.length > 4)
    {
      this.line5.updateColor( this.cargohold.content[4].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    if (this.cargohold.content.length > 5)
    {
      this.line6.updateColor( this.cargohold.content[5].isQuest == true ? verreciel.cyan : verreciel.white )
    }
    
    if (this.cargohold.content.length == 0)
    {
      this.detailsLabel.updateText("Empty", verreciel.grey);
    }
    else if (this.cargohold.content.length == 6)
    {
      this.detailsLabel.updateText("FULL", verreciel.red);
    }
    else
    {
      this.detailsLabel.updateText(this.cargohold.content.length + "/6", verreciel.white);
    }
  }
  
  onUploadComplete()
  {
    assertArgs(arguments, 0);
    this.refresh();
    
    if (this.port.isConnectedToPanel(verreciel.console) == true)
    {
      verreciel.console.onConnect();
    }
    
    verreciel.music.playEffect("click3");
  }
  
  onConnect()
  {
    assertArgs(arguments, 0);
    if (this.port.isReceivingEventOfTypeItem() == false)
    {
      this.detailsLabel.updateText("ERROR",verreciel.red);
      return;
    }
    if (this.port.event == null)
    {
      return;
    }
    if (this.port.origin != null && this.port.origin.host != null && (this.port.origin.host instanceof ConsoleLine))
    {
      this.detailsLabel.updateText("ERROR",verreciel.red);
      return;
    }
    
    if (this.cargohold.content.length < 6)
    {
      this.upload(this.port.event);
    }
  }
  
  // MARK: Upload -
  
  upload(item)
  {
    assertArgs(arguments, 1);
    this.uploadedItem = item;
    this.uploadProgress();
  }
  
  uploadProgress()
  {
    assertArgs(arguments, 0);
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
      this.detailsLabel.updateText(this.uploadPercentage.toFixed(0) + "%", verreciel.grey);
    }

    delay(0.05, this.uploadProgress.bind(this));
  }
  
  uploadComplete()
  {
    assertArgs(arguments, 0);
    if (this.cargohold.content.length == 0)
    {
      this.line1.position.x = -0.25;
    }
    if (this.cargohold.content.length == 1)
    {
      this.line2.position.x = -0.25;
    }
    if (this.cargohold.content.length == 2)
    {
      this.line3.position.x = -0.25;
    }
    if (this.cargohold.content.length == 3)
    {
      this.line4.position.x = -0.25;
    }
    if (this.cargohold.content.length == 4)
    {
      this.line5.position.x = -0.25;
    }
    if (this.cargohold.content.length == 5)
    {
      this.line6.position.x = -0.25;
    }
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    
    if (this.cargohold.content.length == 0)
    {
      this.line1.position.x = 0;
    }
    if (this.cargohold.content.length == 1)
    {
      this.line2.position.x = 0;
    }
    if (this.cargohold.content.length == 2)
    {
      this.line3.position.x = 0;
    }
    if (this.cargohold.content.length == 3)
    {
      this.line4.position.x = 0;
    }
    if (this.cargohold.content.length == 4)
    {
      this.line5.position.x = 0;
    }
    if (this.cargohold.content.length == 5)
    {
      this.line6.position.x = 0;
    }
    
    verreciel.animator.completionBlock = function(){ this.uploadTransfer() }.bind(this);
    verreciel.animator.commit();
  }
  
  uploadTransfer()
  {
    assertArgs(arguments, 0);
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
    assertArgs(arguments, 0);
    this.uploadPercentage = 0;
    this.refresh();
  }
  
  // MARK: Installation -
  
  onInstallationBegin()
  {
    assertArgs(arguments, 0);
    super.onInstallationBegin();
    
    verreciel.player.lookAt(-225);
  }
}

class CargoHold extends Item
{
  constructor()
  {
    assertArgs(arguments, 0);
    super("cargo", ItemTypes.cargo, null, "storage", true, null);

    this.content = [];
  }
  
  payload()
  {
    assertArgs(arguments, 0);
    var data = [];
    
    for (let item of this.content)
    {
      data.push(new ConsoleData(item.name, item.type, item));
    }
    
    var i = 0;
    while (i < 6 - this.content.length)
    {
      data.push(new ConsoleData("--", "", null, verreciel.grey));
      i += 1;
    }
    
    return new ConsolePayload(data);
  }
}
