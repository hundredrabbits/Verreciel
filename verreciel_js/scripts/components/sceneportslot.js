class ScenePortSlot extends ScenePort
{
  constructor(host = new Empty(), align = Alignment.left, hasDetails = false, placeholder = "Empty")
  {
    super(host);

    this.placeholder = placeholder;
    this.hasDetails = hasDetails;
    this.uploadPercentage = 0;
    
    // TODO: THREEJS

    // this.geometry = SCNPlane(width: 0.3, height: 0.3)
    // this.geometry?.firstMaterial?.diffuse.contents = clear
    
    this.trigger = new SceneTrigger(this, new THREE.Vector2(1, 1));
    this.trigger.position.set(0,0,-0.1);
    this.add(this.trigger);
    
    this.label = new SceneLabel(placeholder, 0.1, align, verreciel.grey);
    this.add(this.label);
    
    this.detailsLabel = new SceneLabel("", 0.075, align, verreciel.grey);
    this.add(this.detailsLabel);
    
    this.host = host;
    
    if (align == null)
    {
      this.label.hide();
      this.detailsLabel.hide();
    }
    else if (align == Alignment.left)
    {
      this.label.position.set(0.3,0,0);
      this.detailsLabel.position.set(0.3,-0.3,0);
    }
    else if (align == Alignment.right)
    {
      this.label.position.set(-0.3,0,0);
      this.detailsLabel.position.set(-0.3,-0.3,0);
    }
    else if (align == Alignment.center)
    {
      this.label.position.set(0,-0.5,0);
      this.detailsLabel.position.set(0,-0.8,0);
    }
    
    this.disable();
  }
  
  whenRenderer()
  {
    super.whenRenderer();
    
    if (this.isEnabled == false)
    {
      this.sprite_input.updateColor(verreciel.clear);
    }
    else if (this.event != null)
    {
      this.sprite_input.updateColor(verreciel.clear);
    }
    else
    {
      this.sprite_input.updateColor(verreciel.grey);
    }
  }
  
  refresh()
  {
    this.detailsLabel.visible = this.hasDetails;
    
    if (this.event != null)
    {
      this.label.update(this.event.name);
      this.detailsLabel.update(this.event.details);
    }
    else
    {
      this.label.update(this.placeholder);
      this.detailsLabel.update("--");
    }
    
    if (this.isEnabled == false)
    {
      this.label.update(verreciel.grey);
    }
    else if (this.requirement != null && this.event != null && this.requirement.name == this.event.name)
    {
      this.label.update(verreciel.cyan);
    }
    else if (this.requirement != null && this.event != null && this.requirement.name != this.event.name)
    {
      this.label.update(verreciel.red);
    }
    else if (this.event != null)
    {
      this.label.update(verreciel.white);
    }
    else
    {
      this.label.update(grey);
    }
  }
  
  removeEvent()
  {
    super.removeEvent();
    this.refresh();
  }
  
  onConnect()
  {
    super.onConnect();

    if (this.origin != null && this.origin.event != null && this.event == null)
    {
      if (this.origin.event instanceof Item && this.origin.event.type != ItemTypes.cargo)
      {
        this.upload(this.origin.event);
      }
    }
  }
  
  onDisconnect()
  {
    super.onDisconnect();
    this.host.onDisconnect();
  }
  
  addEvent(event)
  {
    super.addEvent(event);
    this.refresh();
  }
  
  // MARK: Upload -
  
  upload(item)
  {
    this.upload = item;
    uploadProgress();
  }
  
  uploadProgress()
  {
    if (this.origin == null)
    {
      this.uploadCancel();
      return;
    }
    
    this.uploadPercentage += Math.random() * 6;
    if (this.uploadPercentage > 100)
    {
      this.origin.wire.isUploading = false;
      this.uploadComplete();
    }
    else
    {
      this.origin.wire.isUploading = true;
      this.label.update(this.uploadPercentage.toFixed(0) + "%", verreciel.grey);
      delay(0.05, this.uploadProgress.bind(this));
    }
  }
  
  enableAndShow(text, color = null)
  {
    super.enable();
    if (color != null)
    {
      this.label.update(text, color);
    }
    else
    {
      this.label.update(text);
    }
  }
  
  disableAndShow(text, color = null)
  {
    super.disable();
    if (color != null)
    {
      this.label.update(text, color);
    }
    else
    {
      this.label.update(text);
    }
  }
  
  uploadComplete()
  {
    if (this.origin != null)
    {
      this.addEvent(this.syphon());
    }
    this.uploadPercentage = 0;
    this.refresh();
    this.host.onUploadComplete();
  }
  
  uploadCancel()
  {
    this.uploadPercentage = 0;
    this.refresh();
  }
}
