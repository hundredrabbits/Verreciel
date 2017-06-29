class Items
{
  constructor()
  {
    // Misc
    this.waste = new Item("waste", ItemTypes.waste, "useless", "waste");
    this.kelp = new Item("space kelp", ItemTypes.waste, "useless", "kelp");
    
    // Keys
    this.loiqePortalKey = new Item("loiqe key", ItemTypes.key, "complete key", true, "loiqe-key");
    
    this.valenPortalKey = new Item("valen key", ItemTypes.key, "complete key", true, "valen-key");
    this.valenPortalFragment1 = new Item("valen part 1", ItemTypes.fragment, "half Portal key", true, "valen-key-1");
    this.valenPortalFragment2 = new Item("valen part 2", ItemTypes.fragment, "half Portal key", true, "valen-key-2");
    
    this.senniPortalKey = new Item("senni key", ItemTypes.key, "complete key", true, "senni-key");
    
    this.usulPortalKey = new Item("usul key", ItemTypes.key, "complete key", true, "usul-key");
    this.usulPortalFragment1 = new Item("usul Part 1", ItemTypes.fragment, "half Portal key", true, "usul-key-1");
    this.usulPortalFragment2 = new Item("usul Part 2", ItemTypes.fragment, "half Portal key", true, "usul-key-2");
    
    this.endPortalKey = new Item("End Key", ItemTypes.key, "[missing]", true, "end-key");
    this.endPortalKeyFragment1 = new Item("horizontal part", ItemTypes.fragment, "half Portal key", true, "end-key-1");
    this.endPortalKeyFragment2 = new Item("vertical part", ItemTypes.fragment, "half Portal key", true, "end-key-2");
    
    // Etc..
    
    this.warpDrive = new Item("warpdrive", ItemTypes.drive, "local warpdrive", true, "warp");
    
    // Records
    this.record1 = new Item("record", ItemTypes.record, "audio format", true, Records.record1);
    this.record2 = new Item("disk", ItemTypes.record, "audio format", true, Records.record2);
    this.record3 = new Item("cassette", ItemTypes.record, "audio format", true, Records.record3);
    this.record4 = new Item("drive", ItemTypes.record, "audio format", true, Records.record4);
    
    this.record_oquonie = new Item("record", ItemTypes.record, "wet", true, Records.record5);
    
    // Maps
    this.map1 = new Item("Fog Map", ItemTypes.map, "map expension", true, "map-1");
    this.map2 = new Item("Blind Map", ItemTypes.map, "map expension", true, "map-2");
    
    // Shields(fields)
    this.shield = new Item("glass", ItemTypes.shield, "star sand", true, "shield-1");
    
    // Harvest
    this.currency1 = new Item("alta", ItemTypes.currency, "trading currency", "currency-1");
    this.currency2 = new Item("ikov", ItemTypes.currency, "trading currency", "currency-2");
    this.currency3 = new Item("eral", ItemTypes.currency, "trading currency", "currency-3");
    this.currency4 = new Item("altiov", ItemTypes.currency, "From 1 & 2", "currency-4");
    this.currency5 = new Item("ikeral", ItemTypes.currency, "From 2 & 3", "currency-5");
    this.currency6 = new Item("echo", ItemTypes.currency, "From 4 & 5", "currency-6");
    
    // Batteries
    this.battery1  = new Item("cell", ItemTypes.battery, "power source", true, "battery-1");
    this.battery2  = new Item("cell", ItemTypes.battery, "power source", true, "battery-2");
    this.battery3  = new Item("cell", ItemTypes.battery, "power source", true, "battery-3");
    
    // Echoes
    this.teapot     = new Item("a teapot", ItemTypes.unknown, "is paradise", true, "echoes-1");
  }
  
  whenStart()
  {
    this.loiqePortalKey.location = verreciel.universe.loiqe_portal;
    this.valenPortalKey.location = verreciel.universe.valen_portal;
    this.senniPortalKey.location = verreciel.universe.senni_portal;
    this.usulPortalKey.location = verreciel.universe.usul_portal;
  }
}
