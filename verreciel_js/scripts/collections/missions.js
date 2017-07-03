class Missions
{
  constructor()
  {
    assertArgs(arguments, 0);
    this.story = [];
    this.currentMission = new Mission(0, "--");
    
    var m;

    // Loiqe
    
    // MARK: Part 0
    
    m = new Mission(this.story.length, "");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.loiqe_spawn);
      verreciel.battery.onInstallationComplete();
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn]);
      verreciel.universe.valen_bank.addItems([
        verreciel.items.loiqePortalKey,
        verreciel.items.record1,
        Item.like(verreciel.items.waste),
      ]);
    }
    m.quests = [
      new Quest(
        "Route cell to thruster",
        null,
        function() { return verreciel.battery.thrusterPort.isReceivingItemOfType(ItemTypes.battery) == true; },
        function() { verreciel.thruster.install(); }
      ),
      new Quest(
        "Undock with thruster",
        null,
        function() { return verreciel.capsule.location != verreciel.universe.loiqe_spawn && verreciel.universe.loiqe_spawn.isKnown == true; },
        function() {}
      ),
      new Quest(
        "Accelerate with Thruster",
        null,
        function() { return verreciel.capsule.location == null && verreciel.thruster.speed > 0 || verreciel.capsule.location != null; },
        function() { verreciel.intercom.install() ; verreciel.thruster.lock(); }
      ),
      new Quest(
        "Wait for arrival",
        null,
        function() { return verreciel.universe.loiqe_harvest.isKnown == true; },
        function() { verreciel.cargo.install() ; verreciel.thruster.lock(); }
      ),
      new Quest(
        "Route " + verreciel.items.currency1.name + " to cargo", 
        verreciel.universe.loiqe_harvest,
        function() { return verreciel.cargo.containsLike(verreciel.items.currency1); },
        function() { verreciel.console.install() ; verreciel.thruster.unlock(); }
      ),
      new Quest(
        "Route cargo to console",
        null,
        function() { return verreciel.cargo.port.connection != null && verreciel.cargo.port.connection == verreciel.console.port; },
        function() {}
      ),
      new Quest(
        "Undock with thruster",
        null,
        function() { return verreciel.capsule.location != verreciel.universe.loiqe_harvest; },
        function() { verreciel.radar.install(); }
      ),
      new Quest(
        "Wait for arrival",
        null,
        function() { return verreciel.universe.loiqe_city.isKnown == true; },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 1
    
    m = new Mission(this.story.length, "Fragments");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.loiqe_city);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.cargo.addItems([Item.like(verreciel.items.currency1)]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.universe.valen_bank.addItems([verreciel.items.loiqePortalKey,verreciel.items.record1,Item.like(verreciel.items.waste)]);
      verreciel.cargo.port.connect(verreciel.console.port);
    }
    m.predicate = function() { return verreciel.cargo.contains(verreciel.items.valenPortalFragment1) == true; };
    m.quests = [
      new Quest(
        "Route " + verreciel.items.currency1.name + " to verreciel.cargo", 
        verreciel.universe.loiqe_harvest,
        function() { return verreciel.cargo.containsLike(verreciel.items.currency1) || verreciel.capsule.isDockedAtLocation(verreciel.universe.loiqe_city); },
        function() {}
      ),
      new Quest(
        "Route " + verreciel.items.currency1.name + " to trade table", 
        verreciel.universe.loiqe_city,
        function() { return verreciel.universe.loiqe_city.isTradeAccepted == true; },
        function() {}
      ),
      new Quest(
        "Route " + verreciel.items.valenPortalFragment1.name + " to verreciel.cargo",
        null,
        function() { return verreciel.cargo.contains(verreciel.items.valenPortalFragment1) == true; },
        function() { verreciel.progress.install(); }
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 2
    
    m = new Mission(this.story.length, "radar");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.loiqe_city);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.cargo.addItems([verreciel.items.valenPortalFragment1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.universe.valen_bank.addItems([verreciel.items.loiqePortalKey,verreciel.items.record1,Item.like(verreciel.items.waste)]);
      verreciel.cargo.port.connect(verreciel.console.port);
    }
    m.quests = [
      new Quest(
        "Select satellite on radar", 
        verreciel.universe.loiqe_city,
        function() { return verreciel.radar.port.event != null && verreciel.radar.port.event == verreciel.universe.loiqe_satellite; },
        function() { verreciel.pilot.install() ; verreciel.thruster.unlock(); }
      ),
      new Quest(
        "Route Radar to Pilot",
        null,
        function() { return verreciel.pilot.port.origin != null && verreciel.pilot.port.origin == verreciel.radar.port; },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 3
    
    m = new Mission(this.story.length, "portal");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.loiqe_city)
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1)
      verreciel.cargo.addItems([verreciel.items.valenPortalFragment1])
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot])
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city])
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city])
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort)
      verreciel.universe.valen_bank.addItems([verreciel.items.loiqePortalKey,verreciel.items.record1,Item.like(verreciel.items.waste)])
      verreciel.radar.port.connect(verreciel.pilot.port)
      verreciel.cargo.port.connect(verreciel.console.port)
    }
    m.predicate = function() { return verreciel.cargo.contains(verreciel.items.valenPortalKey) == true; };
    m.quests = [
      new Quest(
        "Aquire " + verreciel.items.valenPortalFragment1.name, 
        verreciel.universe.loiqe_city,
        function() { return verreciel.cargo.contains(verreciel.items.valenPortalFragment1) == true || verreciel.capsule.isDockedAtLocation(verreciel.universe.loiqe_horadric) == true; },
        function() {}
      ),
      new Quest(
        "Aquire " + verreciel.items.valenPortalFragment2.name, 
        verreciel.universe.loiqe_satellite,
        function() { return verreciel.cargo.contains(verreciel.items.valenPortalFragment2) == true || verreciel.capsule.isDockedAtLocation(verreciel.universe.loiqe_horadric) == true; },
        function() {}
      ),
      new Quest(
        "Combine fragments", 
        verreciel.universe.loiqe_horadric,
        function() { return verreciel.cargo.contains(verreciel.items.valenPortalKey) == true; },
        function() { verreciel.exploration.install(); }
      )
    ]
    this.story.push(m);
    
    // MARK: Part 4
    
    m = new Mission(this.story.length, "transit");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.loiqe_horadric)
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1)
      verreciel.cargo.addItems([verreciel.items.valenPortalKey])
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration])
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric])
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite])
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort)
      verreciel.universe.valen_bank.addItems([verreciel.items.loiqePortalKey,verreciel.items.record1,Item.like(verreciel.items.waste)])
      verreciel.radar.port.connect(verreciel.pilot.port)
      verreciel.cargo.port.connect(verreciel.console.port)
    }
    m.predicate = function() { return verreciel.universe.valen_portal.isKnown == true; };
    m.quests = [
      new Quest(
        "Route " + verreciel.items.valenPortalKey.name + " to Portal", 
        verreciel.universe.loiqe_portal,
        function() { return verreciel.capsule.isDockedAtLocation(verreciel.universe.loiqe_portal) && verreciel.intercom.port.isReceiving(verreciel.items.valenPortalKey) == true; },
        function() {}
      ),
      new Quest(
        "Align pilot to portal", 
        verreciel.universe.loiqe_portal,
        function() { return verreciel.pilot.port.isReceiving(verreciel.universe.valen_portal) == true; },
        function() {}
      ),
      new Quest(
        "Power Thruster with portal", 
        verreciel.universe.loiqe_portal,
        function() { return verreciel.thruster.port.isReceiving(verreciel.items.warpDrive) == true; },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 5
    
    m = new Mission(this.story.length, "Radio");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.valen_portal);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.cargo.addItems([verreciel.items.valenPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.universe.valen_bank.addItems([verreciel.items.loiqePortalKey,verreciel.items.record1,Item.like(verreciel.items.waste)]);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
    }
    m.predicate = function() { return verreciel.radio.isInstalled == true; };
    m.quests = [
      new Quest(
        "Collect " + verreciel.items.record1.name, 
        verreciel.universe.valen_bank,
        function() { return verreciel.cargo.contains(verreciel.items.record1); },
        function() {}
      ),
      new Quest(
        "Collect second cell", 
        verreciel.universe.valen_cargo,
        function() { return verreciel.battery.hasCell(verreciel.items.battery2) || verreciel.cargo.contains(verreciel.items.battery2); },
        function() { verreciel.battery.cellPort2.enable("empty", verreciel.grey); }
      ),
      new Quest(
        "Collect " + verreciel.items.currency2.name, 
        verreciel.universe.valen_harvest,
        function() { return verreciel.cargo.containsLike(verreciel.items.currency2); },
        function() {}
      ),
      new Quest(
        "Install radio", 
        verreciel.universe.valen_station,
        function() { return verreciel.radio.isInstalled == true; },
        function() { verreciel.journey.install(); }
      )
    ]
    this.story.push(m);
    
    // MARK: Part 6
    
    m = new Mission(this.story.length, "Record");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.valen_station);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.cargo.addItems([verreciel.items.valenPortalKey,verreciel.items.record1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo]);
      verreciel.universe.valen_bank.addItems([verreciel.items.loiqePortalKey,Item.like(verreciel.items.waste)]);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
    }
    m.quests = [
      new Quest(
        "Install cell in battery",
        null,
        function() { return verreciel.battery.hasCell(verreciel.items.battery2); },
        function() {}
      ),
      new Quest(
        "Power radio",
        null,
        function() { return verreciel.battery.isRadioPowered() == true; },
        function() {}
      ),
      new Quest(
        "Route record to radio",
        null,
        function() { return verreciel.radio.port.hasItemOfType(ItemTypes.record); },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 7
    
    m = new Mission(this.story.length, "Hatch");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.valen_station);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.cargo.addItems([verreciel.items.valenPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.universe.valen_bank.addItems([verreciel.items.loiqePortalKey,Item.like(verreciel.items.waste)]);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.port.event = verreciel.items.record1;
    }
    m.predicate = function() { return hatch.count > 0; };
    m.quests = [
      new Quest(
        "Collect Waste", 
        verreciel.universe.valen_bank,
        function() { return verreciel.cargo.containsLike(verreciel.items.waste); },
        function() { verreciel.hatch.install(); }
      ),
      new Quest(
        "Route waste to hatch",
        null,
        function() { return hatch.port.isReceivingItemLike(verreciel.items.waste); },
        function() {}
      ),
      new Quest(
        "Jetison Waste",
        null,
        function() { return hatch.count > 0; },
        function() { verreciel.completion.install(); }
      )
    ]
    this.story.push(m);
    
    // MARK: Part 8
    
    m = new Mission(this.story.length, "Loiqe");
    
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.valen_bank);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.cargo.addItems([verreciel.items.valenPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.hatch,verreciel.completion]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.universe.valen_bank.addItems([verreciel.items.loiqePortalKey]);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.port.event = verreciel.items.record1;
    }
    m.predicate = function() { return verreciel.cargo.containsLike(verreciel.items.loiqePortalKey); };
    m.quests = [
      new Quest(
        "Collect " + verreciel.items.loiqePortalKey.name, 
        verreciel.universe.valen_bank,
        function() { return verreciel.cargo.containsLike(verreciel.items.loiqePortalKey); },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 9
    
    m = new Mission(this.story.length, verreciel.items.currency4.name);
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.valen_station);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.cargo.addItems([verreciel.items.loiqePortalKey,verreciel.items.valenPortalKey,verreciel.items.loiqePortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.port.event = verreciel.items.record1;
    }
    m.predicate = function() { return verreciel.cargo.containsLike(verreciel.items.currency4); };
    m.quests = [
      new Quest(
        "Aquire " + verreciel.items.currency2.name, 
        verreciel.universe.valen_harvest,
        function() { return verreciel.cargo.containsLike(verreciel.items.currency2); },
        function() {}
      ),
      new Quest(
        "Aquire " + verreciel.items.currency1.name, 
        verreciel.universe.loiqe_harvest,
        function() { return verreciel.cargo.containsLike(verreciel.items.currency1); },
        function() {}
      ),
      new Quest(
        "Combine currencies", 
        verreciel.universe.loiqe_horadric,
        function() { return verreciel.cargo.containsLike(verreciel.items.currency4); },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 10
    
    m = new Mission(this.story.length, "Senni");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.loiqe_horadric);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.cargo.addItems([verreciel.items.loiqePortalKey,verreciel.items.valenPortalKey,Item.like(verreciel.items.currency4)]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.port.event = verreciel.items.record1;
    }
    m.predicate = function() { return verreciel.cargo.contains(verreciel.items.senniPortalKey); };
    m.quests = [
      new Quest(
        "Aquire " + verreciel.items.currency4.name,
        null,
        function() { return verreciel.cargo.containsLike(verreciel.items.currency4); },
        function() {}
      ),
      new Quest(
        "Trade " + verreciel.items.currency4.name + " for " + verreciel.items.senniPortalKey.name,
        verreciel.universe.loiqe_port,
        function() { return verreciel.cargo.contains(verreciel.items.senniPortalKey); },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 11
    
    m = new Mission(this.story.length, "Map");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.loiqe_port);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.cargo.addItems([verreciel.items.loiqePortalKey,verreciel.items.valenPortalKey,verreciel.items.senniPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank,verreciel.universe.senni_portal,verreciel.universe.valen_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.loiqe_port]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.port.event = verreciel.items.record1;
    }
    m.predicate = function() { return verreciel.nav.isInstalled == true; };
    m.quests = [
      new Quest(
        "Collect " + verreciel.items.map1.name, 
        verreciel.universe.senni_cargo,
        function() { return verreciel.cargo.contains(verreciel.items.map1); },
        function() {}
      ),
      new Quest(
        "Collect " + verreciel.items.currency3.name, 
        verreciel.universe.senni_harvest,
        function() { return verreciel.cargo.containsLike(verreciel.items.currency3); },
        function() {}
      ),
      new Quest(
        "Install map", 
        verreciel.universe.senni_station,
        function() { return verreciel.nav.isInstalled == true; },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 12
    
    m = new Mission(this.story.length, "fog");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.senni_station);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.cargo.addItems([verreciel.items.loiqePortalKey,verreciel.items.valenPortalKey,verreciel.items.senniPortalKey,verreciel.items.map1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank,verreciel.universe.senni_harvest,verreciel.universe.senni_portal,verreciel.universe.valen_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.loiqe_port,verreciel.universe.senni_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.port.event = verreciel.items.record1;
    }
    m.quests = [
      new Quest(
        "Power Map in battery",
        null,
        function() { return verreciel.battery.isNavPowered() == true; },
        function() {}
      ),
      new Quest(
        "Route fog to map",
        null,
        function() { return verreciel.nav.port.hasItemOfType(ItemTypes.map); },
        function() {}
      ),
      new Quest(
        "Collect third cell", 
        verreciel.universe.senni_fog,
        function() { return verreciel.battery.hasCell(verreciel.items.battery3) || verreciel.cargo.contains(verreciel.items.battery3); },
        function() {  verreciel.battery.cellPort3.enable("empty", verreciel.grey); }
      ),
      new Quest(
        "Install cell in battery",
        null,
        function() { return verreciel.battery.hasCell(verreciel.items.battery3); },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 13
    
    m = new Mission(this.story.length, "Helmet");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.senni_station);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.battery.cellPort3.addEvent(verreciel.items.battery3);
      verreciel.cargo.addItems([verreciel.items.loiqePortalKey,verreciel.items.valenPortalKey,verreciel.items.senniPortalKey,verreciel.items.map1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank,verreciel.universe.senni_harvest,verreciel.universe.senni_portal,verreciel.universe.valen_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.loiqe_port,verreciel.universe.senni_cargo,verreciel.universe.senni_fog,verreciel.universe.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.navPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.port.event = verreciel.items.map1;
      verreciel.radio.port.event = verreciel.items.record2;
      verreciel.universe.valen_bank.addItems([verreciel.items.record1]);
    }
    m.quests = [
      new Quest(
        "Route map to helmet",
        null,
        function() { return player.port.isReceivingFromPanel(verreciel.nav) == true; },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 14
    
    m = new Mission(this.story.length, verreciel.items.usulPortalKey.name);
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.senni_station);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.battery.cellPort3.addEvent(verreciel.items.battery3);
      verreciel.cargo.addItems([verreciel.items.loiqePortalKey,verreciel.items.valenPortalKey,verreciel.items.senniPortalKey,verreciel.items.map1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank,verreciel.universe.senni_harvest,verreciel.universe.senni_portal,verreciel.universe.valen_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.loiqe_port,verreciel.universe.senni_cargo,verreciel.universe.senni_station,verreciel.universe.senni_fog,verreciel.universe.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.navPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.port.event = verreciel.items.map1;
      verreciel.radio.port.event = verreciel.items.record2;
      verreciel.universe.valen_bank.addItems([verreciel.items.record1]);
    }
    m.predicate = function() { return verreciel.cargo.contains(verreciel.items.usulPortalKey); };
    m.quests = [
      new Quest(
        "Collect " + verreciel.items.usulPortalFragment1.name, 
        verreciel.universe.valen_fog,
        function() { return verreciel.cargo.containsLike(verreciel.items.usulPortalFragment1); },
        function() {}
      ),
      new Quest(
        "Collect " + verreciel.items.usulPortalFragment2.name, 
        verreciel.universe.loiqe_fog,
        function() { return verreciel.cargo.containsLike(verreciel.items.usulPortalFragment2); },
        function() {}
      ),
      new Quest(
        "Combine fragments",
        null,
        function() { return verreciel.cargo.containsLike(verreciel.items.usulPortalKey); },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 15
    
    m = new Mission(this.story.length, "Shield");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.loiqe_horadric);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.battery.cellPort3.addEvent(verreciel.items.battery3);
      verreciel.cargo.addItems([verreciel.items.loiqePortalKey,verreciel.items.valenPortalKey,verreciel.items.senniPortalKey,verreciel.items.usulPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank,verreciel.universe.senni_harvest,verreciel.universe.senni_portal,verreciel.universe.valen_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.loiqe_port,verreciel.universe.senni_cargo,verreciel.universe.senni_station,verreciel.universe.valen_fog,verreciel.universe.loiqe_fog,verreciel.universe.senni_fog,verreciel.universe.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.navPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.port.event = verreciel.items.map1;
      verreciel.radio.port.event = verreciel.items.record2;
      verreciel.universe.valen_bank.addItems([verreciel.items.record1]);
    }
    m.predicate = function() { return shield.isInstalled == true; };
    m.quests = [
      new Quest(
        "Install shield", 
        verreciel.universe.usul_station,
        function() { return shield.isInstalled == true; },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 16
    
    m = new Mission(this.story.length, verreciel.items.endPortalKey.name);
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.usul_station);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.battery.cellPort3.addEvent(verreciel.items.battery3);
      verreciel.cargo.addItems([verreciel.items.loiqePortalKey,verreciel.items.valenPortalKey,verreciel.items.senniPortalKey,verreciel.items.usulPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav,verreciel.shield]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank,verreciel.universe.senni_harvest,verreciel.universe.senni_portal,verreciel.universe.valen_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.loiqe_port,verreciel.universe.senni_cargo,verreciel.universe.valen_fog,verreciel.universe.senni_station,verreciel.universe.loiqe_fog,verreciel.universe.usul_station,verreciel.universe.senni_fog,verreciel.universe.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.navPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.shieldPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.port.event = verreciel.items.map1;
      verreciel.radio.port.event = verreciel.items.record2;
      verreciel.universe.valen_bank.addItems([verreciel.items.record1]);
    }
    m.predicate = function() { return verreciel.cargo.contains(verreciel.items.endPortalKey); };
    m.quests = [
      new Quest(
        "Create " + verreciel.items.endPortalKeyFragment1.name,
        null,
        function() { return verreciel.cargo.contains(verreciel.items.endPortalKeyFragment1); },
        function() {}
      ),
      new Quest(
        "Create " + verreciel.items.endPortalKeyFragment2.name,
        null,
        function() { return verreciel.cargo.contains(verreciel.items.endPortalKeyFragment2); },
        function() {}
      ),
      new Quest(
        "Combine fragments",
        null,
        function() { return verreciel.cargo.containsLike(verreciel.items.endPortalKey); },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 17
    
    m = new Mission(this.story.length, "Shield");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.senni_horadric);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.battery.cellPort3.addEvent(verreciel.items.battery3);
      verreciel.cargo.addItems([verreciel.items.endPortalKey,Item.like(verreciel.items.currency4),Item.like(verreciel.items.currency5)]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav,verreciel.shield]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank,verreciel.universe.senni_harvest,verreciel.universe.senni_portal,verreciel.universe.valen_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.loiqe_port,verreciel.universe.senni_cargo,verreciel.universe.valen_fog,verreciel.universe.senni_station,verreciel.universe.loiqe_fog,verreciel.universe.usul_station,verreciel.universe.senni_fog,verreciel.universe.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.navPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.port.event = verreciel.items.map1;
      verreciel.radio.port.event = verreciel.items.record2;
      verreciel.universe.valen_bank.addItems([verreciel.items.record1]);
    }
    m.quests = [
      new Quest(
        "Collect " + verreciel.items.map2.name, 
        verreciel.universe.usul_telescope,
        function() { return verreciel.nav.port.hasEvent(verreciel.items.map2) || verreciel.cargo.contains(verreciel.items.map2); },
        function() {}
      ),
      new Quest(
        "Route " + verreciel.items.map2.name + " to map",
        null,
        function() { return verreciel.nav.port.hasEvent(verreciel.items.map2); },
        function() {}
      ),
      new Quest(
        "Collect " + verreciel.items.shield.name, 
        verreciel.universe.usul_silence,
        function() { return verreciel.shield.port.hasEvent(verreciel.items.shield) || verreciel.cargo.contains(verreciel.items.shield); },
        function() {}
      ),
      new Quest(
        "Route " + verreciel.items.shield.name + " to shield",
        null,
        function() { return verreciel.shield.port.hasEvent(verreciel.items.shield); },
        function() {}
      ),
      new Quest(
        "Power Shield in battery",
        null,
        function() { return verreciel.battery.isShieldPowered() == true; },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 18
    
    m = new Mission(this.story.length, "mechanism");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.usul_silence);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.battery.cellPort3.addEvent(verreciel.items.battery3);
      verreciel.cargo.addItems([verreciel.items.endPortalKey,verreciel.items.map1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav,verreciel.shield]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank,verreciel.universe.senni_harvest,verreciel.universe.senni_portal,verreciel.universe.valen_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.loiqe_port,verreciel.universe.senni_cargo,verreciel.universe.valen_fog,verreciel.universe.senni_station,verreciel.universe.loiqe_fog,verreciel.universe.usul_station,verreciel.universe.senni_fog,verreciel.universe.senni_wreck,verreciel.universe.usul_telescope,verreciel.universe.usul_silence]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.navPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.shieldPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.port.event = verreciel.items.map2;
      verreciel.radio.port.event = verreciel.items.record3;
      verreciel.shield.port.event = verreciel.items.shield;
      verreciel.universe.valen_bank.addItems([verreciel.items.record1,verreciel.items.record2]);
    }
    m.quests = [
      new Quest(
        "Extinguish the sun", 
        verreciel.universe.loiqe,
        function() { return verreciel.universe.loiqe.isComplete == true; },
        function() {}
      ),
      new Quest(
        "Extinguish the sun", 
        verreciel.universe.valen,
        function() { return verreciel.universe.valen.isComplete == true; },
        function() {}
      ),
      new Quest(
        "Extinguish the sun", 
        verreciel.universe.senni,
        function() { return verreciel.universe.senni.isComplete == true; },
        function() {}
      ),
      new Quest(
        "Extinguish the sun", 
        verreciel.universe.usul,
        function() { return verreciel.universe.usul.isComplete == true; },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 19
    
    m = new Mission(this.story.length, "At the close");
    m.state = function() {
      verreciel.capsule.beginAtLocation(verreciel.universe.usul_transit);
      verreciel.battery.cellPort1.addEvent(verreciel.items.battery1);
      verreciel.battery.cellPort2.addEvent(verreciel.items.battery2);
      verreciel.battery.cellPort3.addEvent(verreciel.items.battery3);
      verreciel.cargo.addItems([verreciel.items.endPortalKey,verreciel.items.map1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav,verreciel.shield]);
      verreciel.missions.setToKnown([verreciel.universe.loiqe_spawn,verreciel.universe.loiqe_harvest,verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.loiqe_horadric,verreciel.universe.loiqe_portal,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.valen_bank,verreciel.universe.senni_harvest,verreciel.universe.senni_portal,verreciel.universe.valen_portal]);
      verreciel.missions.setToCompleted([verreciel.universe.loiqe_city,verreciel.universe.loiqe_satellite,verreciel.universe.valen_station,verreciel.universe.valen_cargo,verreciel.universe.loiqe_port,verreciel.universe.senni_cargo,verreciel.universe.valen_fog,verreciel.universe.senni_station,verreciel.universe.loiqe_fog,verreciel.universe.usul_station,verreciel.universe.senni_fog,verreciel.universe.senni_wreck,verreciel.universe.usul_telescope,verreciel.universe.usul_silence,verreciel.universe.loiqe,verreciel.universe.valen,verreciel.universe.senni,verreciel.universe.usul]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.navPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.shieldPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.port.event = verreciel.items.map2;
      verreciel.radio.port.event = verreciel.items.record3;
      verreciel.shield.port.event = verreciel.items.shield;
      verreciel.universe.valen_bank.addItems([verreciel.items.record1,verreciel.items.record2]);
    }
    m.quests = [
      new Quest(
        "Witness", 
        verreciel.universe.close,
        function() { return verreciel.universe.close.isComplete == true; },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 20
    
    m = new Mission(this.story.length, "End");
    m.state = function() {
      verreciel.capsule.at = new THREE.Vector2(0,100);
      verreciel.helmet.addWarning("mechanism is closed", null, 60, "end");
    }
    m.quests = [
      new Quest(
        "Stop", 
        verreciel.universe.close,
        function() { return (1 > 2) == true; },
        function() {}
      )
    ]
    this.story.push(m);
  }
  
  // MARK: Tools -
  
  setToInstalled(panels)
  {
    assertArgs(arguments, 1);
    for (let panel of panels)
    {
      panel.onInstallationComplete();
    }
  }
  
  setToKnown(locations)
  {
    assertArgs(arguments, 1);
    for (let location of locations)
    {
      location.isKnown = true;
    }
  }
  
  setToCompleted(locations)
  {
    assertArgs(arguments, 1);
    for (let location of locations)
    {
      if (location.isComplete == false)
      {
        location.onComplete();
      }
      location.isKnown = true;
    }
    verreciel.intercom.locationPanel.empty();
  }
  
  refresh()
  {
    assertArgs(arguments, 0);
    this.currentMission.validate();
    if (this.currentMission.isCompleted == true)
    {
      this.updateCurrentMission();
      verreciel.helmet.addWarning(this.currentMission.name, verreciel.cyan, 3, "mission");
    }
  }
  
  updateCurrentMission()
  {
    assertArgs(arguments, 0);
    for (let mission of this.story)
    {
      if (mission.isCompleted == false)
      {
        this.currentMission = mission;
        console.log("# ---------------------------");
        console.log("# MISSION  | Reached: " + this.currentMission.id);
        console.log("# ---------------------------");
        verreciel.game.save(this.currentMission.id);
        return
      }
    }
  }
}
