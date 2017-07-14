//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class ScenePortSlot extends ScenePort
{
  constructor(host = new Empty(), align = Alignment.left, hasDetails = false, placeholder = "Empty")
  {
    // assertArgs(arguments, 1);
    super(host);

    this.placeholder = placeholder;
    this.hasDetails = hasDetails;
    this.uploadPercentage = 0;
    
    this.trigger = new SceneTrigger(this, 1, 1);
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
  
  inputColor()
  {
    if (this.isEnabled == false)
    {
      return verreciel.clear;
    }
    else if (this.event != null)
    {
      return verreciel.clear;
    }
    
    return verreciel.grey;
  }
  
  refresh()
  {
    // assertArgs(arguments, 0);
    this.detailsLabel.opacity = this.hasDetails == true ? 1 : 0;
    
    if (this.event != null)
    {
      this.label.updateText(this.event.name);
      this.detailsLabel.updateText(this.event.details);
    }
    else
    {
      this.label.updateText(this.placeholder);
      this.detailsLabel.updateText("--");
    }
    
    if (this.isEnabled == false)
    {
      this.label.color = verreciel.grey;
    }
    else if (this.requirement != null && this.event != null && this.requirement.name == this.event.name)
    {
      this.label.color = verreciel.cyan;
    }
    else if (this.requirement != null && this.event != null && this.requirement.name != this.event.name)
    {
      this.label.color = verreciel.red;
    }
    else if (this.event != null)
    {
      this.label.color = verreciel.white;
    }
    else
    {
      this.label.color = verreciel.grey;
    }
  }
  
  removeEvent()
  {
    // assertArgs(arguments, 0);
    super.removeEvent();
    this.refresh();
  }
  
  onConnect()
  {
    // assertArgs(arguments, 0);
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
    // assertArgs(arguments, 0);
    super.onDisconnect();
    this.host.onDisconnect();
  }
  
  addEvent(event)
  {
    // assertArgs(arguments, 1);
    super.addEvent(event);
    this.refresh();
  }
  
  // MARK: Upload -
  
  upload(item)
  {
    // assertArgs(arguments, 1);
    this.uploadedItem = item;
    this.uploadProgress();
  }
  
  uploadProgress()
  {
    // assertArgs(arguments, 0);
    if (this.origin == null)
    {
      this.uploadCancel();
      return;
    }
    
    this.uploadPercentage += Math.random() * 6;
    this.uploadPercentage += 1; // Faster!
    if (this.uploadPercentage > 100)
    {
      this.origin.wire.isUploading = false;
      this.uploadComplete();
    }
    else
    {
      this.origin.wire.isUploading = true;
      this.label.updateText(this.uploadPercentage.toFixed(0) + "%", verreciel.grey);
      delay(0.05, this.uploadProgress.bind(this));
    }
  }
  
  updateText(text, color = null)
  {
    // assertArgs(arguments, 1);
    this.label.updateText(text, color);
  }
  
  uploadComplete()
  {
    // assertArgs(arguments, 0);
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
    // assertArgs(arguments, 0);
    this.uploadPercentage = 0;
    this.refresh();
  }
}
