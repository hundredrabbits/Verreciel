class Locations
{
  constructor()
  {
    this.loiqe = new Loiqe(new THREE.Vector2( 0, -3));
    this.usul  = new  Usul(new THREE.Vector2(-3,  0));
    this.valen = new Valen(new THREE.Vector2( 3,  0));
    this.senni = new Senni(new THREE.Vector2( 0,  3));
    this.close = new Close(new THREE.Vector2( 0,  0));
  }
}

class Loiqe
{
  constructor(offset)
  {
    this.system = Systems.loiqe;
    this.offset = offset;
  }
  
  star()
  {
    return new LocationStar("Loiqe", this.system, this.offset);
  }
  
  spawn()
  {
    return new LocationSatellite("spawn", this.system, new THREE.Vector2(this.offset.x, this.offset.y - 2.75), "Are you sure$that you are in$space.", verreciel.items.teapot, verreciel.items.map2);
  }
  
  harvest()
  {
    return new LocationHarvest("Harvest", this.system, new THREE.Vector2(this.offset.x, this.offset.y - 2), new Item(verreciel.items.currency1));
  }
  
  city()
  {
    return new LocationTrade("City", this.system, new THREE.Vector2(this.offset.x, this.offset.y - 1), verreciel.items.currency1, verreciel.items.valenPortalFragment1);
  }
  
  horadric()
  {
    return new LocationHoradric("Horadric", this.system, new THREE.Vector2(this.offset.x + 2, this.offset.y));
  }
  
  portal()
  {
    return new LocationPortal("portal", this.system, new THREE.Vector2(this.offset.x, this.offset.y + 1));
  }
  
  satellite()
  {
    return new LocationSatellite("satellite", this.system, new THREE.Vector2(this.offset.x + 1, this.offset.y), "something broken$half lost", verreciel.items.valenPortalFragment2);
  }
  
  port()
  {
    return new LocationTrade("port", this.system, new THREE.Vector2(this.offset.x - 1, this.offset.y), verreciel.items.currency4, verreciel.items.senniPortalKey);
  }
  
  // MARK: Fog
  
  transit()
  {
    return new LocationTransit("transit", this.system, new THREE.Vector2(this.offset.x, this.offset.y + 2), verreciel.items.map1);
  }
  
  fog()
  {
    return new LocationTrade("fog", this.system, new THREE.Vector2(this.offset.x - 2, this.offset.y), verreciel.items.currency5, verreciel.items.usulPortalFragment2, verreciel.items.map1);
  }
  
  // Constellations
  
  c_1()
  {
    return new LocationConstellation("", this.system, new THREE.Vector2(this.offset.x, this.offset.y - 1.5), new StructureTunnel());
  }
}

class Usul
{
  constructor(offset)
  {
    this.system = Systems.usul;
    this.offset = offset;
  }
  
  star()
  {
    return new LocationStar("Usul", this.system, this.offset);
  }
  
  portal()
  {
    return new LocationPortal("portal", this.system, new THREE.Vector2(this.offset.x + 1, this.offset.y));
  }
  
  // MARK: Fog
  
  transit()
  {
    return new LocationTransit("transit", this.system, new THREE.Vector2(this.offset.x + 2, this.offset.y), verreciel.items.map1);
  }
  
  station()
  {
    return new LocationStation("station", this.system, new THREE.Vector2(this.offset.x, this.offset.y + 1), verreciel.items.currency5, function(){ verreciel.shield.install(); }, "shield", verreciel.items.map1);
  }
  
  telescope()
  {
    return new LocationSatellite("telescope", this.system, new THREE.Vector2(this.offset.x, this.offset.y - 1), "extra sight$map format", verreciel.items.map2, verreciel.items.map1);
  }
  
  // MARK: Blind
  
  silence()
  {
    return new LocationTrade("silence", this.system, new THREE.Vector2(this.offset.x - 1, this.offset.y), verreciel.items.currency6, verreciel.items.shield, verreciel.items.map2);
  }
}

class Valen
{
  constructor(offset)
  {
    this.system = Systems.valen;
    this.offset = offset;
  }
  
  star()
  {
    return new LocationStar("Valen", this.system, this.offset);
  }
  
  bank()
  {
    return new LocationBank("Bank", this.system, new THREE.Vector2(this.offset.x, this.offset.y + 1));
  }
  
  portal()
  {
    return new LocationPortal("portal", this.system, new THREE.Vector2(this.offset.x - 1, this.offset.y));
  }
  
  harvest()
  {
    return new LocationHarvest("harvest", this.system, new THREE.Vector2(this.offset.x, this.offset.y + 2), new Item(verreciel.items.currency2));
  }
  
  station()
  {
    return new LocationStation("station", this.system, new THREE.Vector2(this.offset.x + 1, this.offset.y + 1), verreciel.items.currency2, function(){ verreciel.radio.install(); }, "Radio");
  }
  
  cargo()
  {
    return new LocationSatellite("cargo", this.system, new THREE.Vector2(this.offset.x + 1, this.offset.y + 2), "Extra power$battery format", verreciel.items.battery2);
  }
  
  market()
  {
    return new LocationTrade("market", this.system, new THREE.Vector2(this.offset.x + 1, this.offset.y - 1), verreciel.items.waste, verreciel.items.kelp);
  }
  
  // MARK: Fog
  
  transit()
  {
    return new LocationTransit("transit", this.system, new THREE.Vector2(this.offset.x - 2, this.offset.y), verreciel.items.map1);
  }
  
  fog()
  {
    return new LocationSatellite("fog", this.system, new THREE.Vector2(this.offset.x, this.offset.y - 1), "something broken$half lost", verreciel.items.usulPortalFragment1, verreciel.items.map1);
  }
  
  beacon()
  {
    return new LocationBeacon("beacon", this.system, new THREE.Vector2(this.offset.x, this.offset.y - 2), "scribbles$scribbles$scrib..", verreciel.items.map1);
  }
  
  c_1()
  {
    return new LocationConstellation("", this.system, new THREE.Vector2(this.offset.x + 0.5, this.offset.y + 1.5), new StructureDoor());
  }
  
  // MARK: Blind
  
  void()
  {
    return new LocationTrade("void", this.system, new THREE.Vector2(this.offset.x + 1, this.offset.y - 2), verreciel.items.teapot, verreciel.items.kelp, verreciel.items.map2);
  }
  
  wreck()
  {
    return new LocationSatellite("wreck", this.system, new THREE.Vector2(this.offset.x + 2, this.offset.y), "Memories$radio format", verreciel.items.record3, verreciel.items.map2);
  }
}

class Senni
{
  constructor(offset)
  {
    this.system = Systems.senni;
    this.offset = offset;
  }
  
  star()
  {
    return new LocationStar("Senni", this.system, this.offset);
  }
  
  portal()
  {
    return new LocationPortal("portal", this.system, new THREE.Vector2(this.offset.x, this.offset.y - 1));
  }
  
  cargo()
  {
    return new LocationSatellite("cargo", this.system, new THREE.Vector2(this.offset.x - 1, this.offset.y), "extra sight$map format", verreciel.items.map1);
  }
  
  harvest()
  {
    return new LocationHarvest("harvest", this.system, new THREE.Vector2(this.offset.x, this.offset.y + 1), new Item(verreciel.items.currency3));
  }
  
  station()
  {
    return new LocationStation("station", this.system, new THREE.Vector2(this.offset.x + 1, this.offset.y), verreciel.items.currency3, function(){ verreciel.nav.install(); }, "Map");
  }
  
  // MARK: Fog
  
  transit()
  {
    return new LocationTransit("transit", this.system, new THREE.Vector2(this.offset.x, this.offset.y - 2), verreciel.items.map1);
  }
  
  horadric()
  {
    return new LocationHoradric("Horadric", this.system, new THREE.Vector2(this.offset.x, this.offset.y + 2), verreciel.items.map1);
  }
  
  fog()
  {
    return new LocationSatellite("fog", this.system, new THREE.Vector2(this.offset.x + 2, this.offset.y), "Extra power$battery format", verreciel.items.battery3, verreciel.items.map1);
  }
  
  wreck()
  {
    return new LocationSatellite("wreck", this.system, new THREE.Vector2(this.offset.x - 2, this.offset.y), "Memories$radio format", verreciel.items.record2, verreciel.items.map1);
  }
  
  // MARK: Silence
  
  bog()
  {
    return new LocationTrade("bog", this.system, new THREE.Vector2(this.offset.x + 1, this.offset.y + 1), verreciel.items.kelp, verreciel.items.record_oquonie, verreciel.items.map2);
  }
}

class Close
{
  constructor(offset)
  {
    this.system = Systems.close;
    this.offset = offset;
  }
  
  void()
  {
    return new LocationClose("close", this.system, this.offset, verreciel.items.map2);
  }
}
