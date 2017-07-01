class Items
{
  constructor()
  {
    assertArgs(arguments, 0);
    // Misc
    this.waste = new Item("waste", ItemTypes.waste, "useless", "waste", false, null);
    this.kelp = new Item("space kelp", ItemTypes.waste, "useless", "kelp", false, null);
    
    // Keys
    this.loiqePortalKey = new Item("loiqe key", ItemTypes.key, "complete key", "loiqe-key", true, null);
    
    this.valenPortalKey = new Item("valen key", ItemTypes.key, "complete key", "valen-key", true, null);
    this.valenPortalFragment1 = new Item("valen part 1", ItemTypes.fragment, "half Portal key", "valen-key-1", true, null);
    this.valenPortalFragment2 = new Item("valen part 2", ItemTypes.fragment, "half Portal key", "valen-key-2", true, null);
    
    this.senniPortalKey = new Item("senni key", ItemTypes.key, "complete key", "senni-key", true, null);
    
    this.usulPortalKey = new Item("usul key", ItemTypes.key, "complete key", "usul-key", true, null);
    this.usulPortalFragment1 = new Item("usul Part 1", ItemTypes.fragment, "half Portal key", "usul-key-1", true, null);
    this.usulPortalFragment2 = new Item("usul Part 2", ItemTypes.fragment, "half Portal key", "usul-key-2", true, null);
    
    this.endPortalKey = new Item("End Key", ItemTypes.key, "[missing]", "end-key", true, null);
    this.endPortalKeyFragment1 = new Item("horizontal part", ItemTypes.fragment, "half Portal key", "end-key-1", true, null);
    this.endPortalKeyFragment2 = new Item("vertical part", ItemTypes.fragment, "half Portal key", "end-key-2", true, null);
    
    // Etc..
    
    this.warpDrive = new Item("warpdrive", ItemTypes.drive, "local warpdrive", "warp", true, null);
    
    // Records
    this.record1 = new Item("record", ItemTypes.record, "audio format", Records.record1, true, null);
    this.record2 = new Item("disk", ItemTypes.record, "audio format", Records.record2, true, null);
    this.record3 = new Item("cassette", ItemTypes.record, "audio format", Records.record3, true, null);
    this.record4 = new Item("drive", ItemTypes.record, "audio format", Records.record4, true, null);
    
    this.record_oquonie = new Item("record", ItemTypes.record, "wet", Records.record5, true, null);
    
    // Maps
    this.map1 = new Item("Fog Map", ItemTypes.map, "map expension", "map-1", true, null);
    this.map2 = new Item("Blind Map", ItemTypes.map, "map expension", "map-2", true, null);
    
    // Shields(fields)
    this.shield = new Item("glass", ItemTypes.shield, "star sand", "shield-1", true, null);
    
    // Harvest
    this.currency1 = new Item("alta", ItemTypes.currency, "trading currency", "currency-1", false, null);
    this.currency2 = new Item("ikov", ItemTypes.currency, "trading currency", "currency-2", false, null);
    this.currency3 = new Item("eral", ItemTypes.currency, "trading currency", "currency-3", false, null);
    this.currency4 = new Item("altiov", ItemTypes.currency, "From 1 & 2", "currency-4", false, null);
    this.currency5 = new Item("ikeral", ItemTypes.currency, "From 2 & 3", "currency-5", false, null);
    this.currency6 = new Item("echo", ItemTypes.currency, "From 4 & 5", "currency-6", false, null);
    
    // Batteries
    this.battery1  = new Item("cell", ItemTypes.battery, "power source", "battery-1", true, null);
    this.battery2  = new Item("cell", ItemTypes.battery, "power source", "battery-2", true, null);
    this.battery3  = new Item("cell", ItemTypes.battery, "power source", "battery-3", true, null);
    
    // Echoes
    this.teapot     = new Item("a teapot", ItemTypes.unknown, "is paradise", "echoes-1", true, null);
  }
  
  whenStart()
  {
    assertArgs(arguments, 0);
    this.loiqePortalKey.location = verreciel.universe.loiqe_portal;
    this.valenPortalKey.location = verreciel.universe.valen_portal;
    this.senniPortalKey.location = verreciel.universe.senni_portal;
    this.usulPortalKey.location = verreciel.universe.usul_portal;
  }
}
