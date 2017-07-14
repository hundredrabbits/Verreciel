//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Nav extends Widget
{
  constructor()
  {
    // assertArgs(arguments, 0);
    super();
    this.name = "map";
    this.details = "disk drive";
    this.requirement = ItemTypes.map;
    this.isPowered = function() { return verreciel.battery.isNavPowered(); };
    this.label.updateText(this.name);
  }
  
  setMap(map)
  {
    // assertArgs(arguments, 1);
    if (!this.hasMap(map))
    {
      this.port.addEvent(map);
    }
  }

  hasMap(map)
  {
    // assertArgs(arguments, 1);
    if (this.port.hasEvent() == false)
    {
      return false;
    }
    if (this.port.event == map)
    {
      return true;
    }
    return false;
  }
  
  onUploadComplete()
  {
    // assertArgs(arguments, 0);
    super.onUploadComplete();
  }
  
  onInstallationBegin()
  {
    // assertArgs(arguments, 0);
    super.onInstallationBegin();
    
    verreciel.player.lookAt(-90);
  }
  
  onInstallationComplete()
  {
    // assertArgs(arguments, 0);
    super.onInstallationComplete();
    verreciel.battery.installNav();
  }
}
