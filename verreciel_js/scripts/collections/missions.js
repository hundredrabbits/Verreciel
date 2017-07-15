//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Missions
{
  constructor()
  {
    // assertArgs(arguments, 0);
    this.story = [];
    this.currentMission = new Mission(0, "--");

    let u = verreciel.universe;
    let i = verreciel.items;
    
    var m;

    // Loiqe
    
    // MARK: Part 0
    
    m = new Mission(this.story.length, "");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.loiqe_spawn);
      verreciel.battery.onInstallationComplete();
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.missions.setToKnown([u.loiqe_spawn]);
      u.valen_bank.addItems([
        i.loiqePortalKey,
        i.record1,
        Item.like(i.waste),
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
        function() { return verreciel.capsule.location != u.loiqe_spawn && u.loiqe_spawn.isKnown == true; },
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
        function() { return u.loiqe_harvest.isKnown == true; },
        function() { verreciel.cargo.install() ; verreciel.thruster.lock(); }
      ),
      new Quest(
        "Route " + i.currency1.name + " to cargo", 
        u.loiqe_harvest,
        function() { return verreciel.cargo.containsLike(i.currency1); },
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
        function() { return verreciel.capsule.location != u.loiqe_harvest; },
        function() { verreciel.radar.install(); }
      ),
      new Quest(
        "Wait for arrival",
        null,
        function() { return u.loiqe_city.isKnown == true; },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 1
    
    m = new Mission(this.story.length, "Fragments");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.loiqe_city);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.cargo.addItems([Item.like(i.currency1)]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      u.valen_bank.addItems([i.loiqePortalKey,i.record1,Item.like(i.waste)]);
      verreciel.cargo.port.connect(verreciel.console.port);
    }
    m.predicate = function() { return verreciel.cargo.contains(i.valenPortalFragment1) == true; };
    m.quests = [
      new Quest(
        "Route " + i.currency1.name + " to verreciel.cargo", 
        u.loiqe_harvest,
        function() { return verreciel.cargo.containsLike(i.currency1) || verreciel.capsule.isDockedAtLocation(u.loiqe_city); },
        function() {}
      ),
      new Quest(
        "Route " + i.currency1.name + " to trade table", 
        u.loiqe_city,
        function() { return u.loiqe_city.isTradeAccepted == true; },
        function() {}
      ),
      new Quest(
        "Route " + i.valenPortalFragment1.name + " to verreciel.cargo",
        null,
        function() { return verreciel.cargo.contains(i.valenPortalFragment1) == true; },
        function() { verreciel.progress.install(); }
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 2
    
    m = new Mission(this.story.length, "radar");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.loiqe_city);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.cargo.addItems([i.valenPortalFragment1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city]);
      verreciel.missions.setToCompleted([u.loiqe_city]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      u.valen_bank.addItems([i.loiqePortalKey,i.record1,Item.like(i.waste)]);
      verreciel.cargo.port.connect(verreciel.console.port);
    }
    m.quests = [
      new Quest(
        "Select satellite on radar", 
        u.loiqe_city,
        function() { return verreciel.radar.port.event != null && verreciel.radar.port.event == u.loiqe_satellite; },
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
      verreciel.capsule.beginAtLocation(u.loiqe_city)
      verreciel.battery.cellPort1.addEvent(i.battery1)
      verreciel.cargo.addItems([i.valenPortalFragment1])
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot])
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city])
      verreciel.missions.setToCompleted([u.loiqe_city])
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort)
      u.valen_bank.addItems([i.loiqePortalKey,i.record1,Item.like(i.waste)])
      verreciel.radar.port.connect(verreciel.pilot.port)
      verreciel.cargo.port.connect(verreciel.console.port)
    }
    m.predicate = function() { return verreciel.cargo.contains(i.valenPortalKey) == true; };
    m.quests = [
      new Quest(
        "Aquire " + i.valenPortalFragment1.name, 
        u.loiqe_city,
        function() { return verreciel.cargo.contains(i.valenPortalFragment1) == true || verreciel.capsule.isDockedAtLocation(u.loiqe_horadric) == true; },
        function() {}
      ),
      new Quest(
        "Aquire " + i.valenPortalFragment2.name, 
        u.loiqe_satellite,
        function() { return verreciel.cargo.contains(i.valenPortalFragment2) == true || verreciel.capsule.isDockedAtLocation(u.loiqe_horadric) == true; },
        function() {}
      ),
      new Quest(
        "Combine fragments", 
        u.loiqe_horadric,
        function() { return verreciel.cargo.contains(i.valenPortalKey) == true; },
        function() { verreciel.exploration.install(); }
      )
    ]
    this.story.push(m);
    
    // MARK: Part 4
    
    m = new Mission(this.story.length, "transit");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.loiqe_horadric)
      verreciel.battery.cellPort1.addEvent(i.battery1)
      verreciel.cargo.addItems([i.valenPortalKey])
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration])
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric])
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite])
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort)
      u.valen_bank.addItems([i.loiqePortalKey,i.record1,Item.like(i.waste)])
      verreciel.radar.port.connect(verreciel.pilot.port)
      verreciel.cargo.port.connect(verreciel.console.port)
    }
    m.predicate = function() { return u.valen_portal.isKnown == true; };
    m.quests = [
      new Quest(
        "Route " + i.valenPortalKey.name + " to Portal", 
        u.loiqe_portal,
        function() { return verreciel.capsule.isDockedAtLocation(u.loiqe_portal) && verreciel.intercom.port.isReceivingEvent(i.valenPortalKey) == true; },
        function() {}
      ),
      new Quest(
        "Align pilot to portal", 
        u.loiqe_portal,
        function() { return verreciel.pilot.port.isReceivingEvent(u.valen_portal) == true; },
        function() {}
      ),
      new Quest(
        "Power Thruster with portal", 
        u.loiqe_portal,
        function() { return verreciel.thruster.port.isReceivingEvent(i.warpDrive) == true; },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 5
    
    m = new Mission(this.story.length, "Radio");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.valen_portal);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.cargo.addItems([i.valenPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      u.valen_bank.addItems([i.loiqePortalKey,i.record1,Item.like(i.waste)]);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
    }
    m.predicate = function() { return verreciel.radio.isInstalled == true; };
    m.quests = [
      new Quest(
        "Collect " + i.record1.name, 
        u.valen_bank,
        function() { return verreciel.cargo.contains(i.record1); },
        function() {}
      ),
      new Quest(
        "Collect second cell", 
        u.valen_cargo,
        function() { return verreciel.battery.hasCell(i.battery2) || verreciel.cargo.contains(i.battery2); },
        function() { verreciel.battery.cellPort2.enable("empty", verreciel.grey); }
      ),
      new Quest(
        "Collect " + i.currency2.name, 
        u.valen_harvest,
        function() { return verreciel.cargo.containsLike(i.currency2); },
        function() {}
      ),
      new Quest(
        "Install radio", 
        u.valen_station,
        function() { return verreciel.radio.isInstalled == true; },
        function() { verreciel.journey.install(); }
      )
    ]
    this.story.push(m);
    
    // MARK: Part 6
    
    m = new Mission(this.story.length, "Record");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.valen_station);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.cargo.addItems([i.valenPortalKey,i.record1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo]);
      u.valen_bank.addItems([i.loiqePortalKey,Item.like(i.waste)]);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
    }
    m.quests = [
      new Quest(
        "Install cell in battery",
        null,
        function() { return verreciel.battery.hasCell(i.battery2); },
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
      verreciel.capsule.beginAtLocation(u.valen_station);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.cargo.addItems([i.valenPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      u.valen_bank.addItems([i.loiqePortalKey,Item.like(i.waste)]);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.setRecord(i.record1);
    }
    m.predicate = function() { return verreciel.hatch.count > 0; };
    m.quests = [
      new Quest(
        "Collect Waste", 
        u.valen_bank,
        function() { return verreciel.cargo.containsLike(i.waste); },
        function() { verreciel.hatch.install(); }
      ),
      new Quest(
        "Route waste to hatch",
        null,
        function() { return verreciel.hatch.port.isReceivingItemLike(i.waste); },
        function() {}
      ),
      new Quest(
        "Jetison Waste",
        null,
        function() { return verreciel.hatch.count > 0; },
        function() { verreciel.completion.install(); }
      )
    ]
    this.story.push(m);
    
    // MARK: Part 8
    
    m = new Mission(this.story.length, "Loiqe");
    
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.valen_bank);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.cargo.addItems([i.valenPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.hatch,verreciel.completion]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      u.valen_bank.addItems([i.loiqePortalKey]);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.setRecord(i.record1);
    }
    m.predicate = function() { return verreciel.cargo.containsLike(i.loiqePortalKey); };
    m.quests = [
      new Quest(
        "Collect " + i.loiqePortalKey.name, 
        u.valen_bank,
        function() { return verreciel.cargo.containsLike(i.loiqePortalKey); },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 9
    
    m = new Mission(this.story.length, i.currency4.name);
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.valen_station);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.cargo.addItems([i.valenPortalKey,i.loiqePortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.setRecord(i.record1);
    }
    m.predicate = function() { return verreciel.cargo.containsLike(i.currency4); };
    m.quests = [
      new Quest(
        "Aquire " + i.currency2.name, 
        u.valen_harvest,
        function() { return verreciel.cargo.containsLike(i.currency2); },
        function() {}
      ),
      new Quest(
        "Aquire " + i.currency1.name, 
        u.loiqe_harvest,
        function() { return verreciel.cargo.containsLike(i.currency1); },
        function() {}
      ),
      new Quest(
        "Combine currencies", 
        u.loiqe_horadric,
        function() { return verreciel.cargo.containsLike(i.currency4); },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 10
    
    m = new Mission(this.story.length, "Senni");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.loiqe_horadric);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.cargo.addItems([i.loiqePortalKey,i.valenPortalKey,Item.like(i.currency4)]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.setRecord(i.record1);
    }
    m.predicate = function() { return verreciel.cargo.contains(i.senniPortalKey); };
    m.quests = [
      new Quest(
        "Aquire " + i.currency4.name,
        null,
        function() { return verreciel.cargo.containsLike(i.currency4); },
        function() {}
      ),
      new Quest(
        "Trade " + i.currency4.name + " for " + i.senniPortalKey.name,
        u.loiqe_port,
        function() { return verreciel.cargo.contains(i.senniPortalKey); },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 11
    
    m = new Mission(this.story.length, "Map");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.loiqe_port);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.cargo.addItems([i.loiqePortalKey,i.valenPortalKey,i.senniPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank,u.senni_portal,u.valen_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo,u.loiqe_port]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.setRecord(i.record1);
    }
    m.predicate = function() { return verreciel.nav.isInstalled == true; };
    m.quests = [
      new Quest(
        "Collect " + i.map1.name, 
        u.senni_cargo,
        function() { return verreciel.cargo.contains(i.map1); },
        function() {}
      ),
      new Quest(
        "Collect " + i.currency3.name, 
        u.senni_harvest,
        function() { return verreciel.cargo.containsLike(i.currency3); },
        function() {}
      ),
      new Quest(
        "Install map", 
        u.senni_station,
        function() { return verreciel.nav.isInstalled == true; },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 12
    
    m = new Mission(this.story.length, "fog");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.senni_station);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.cargo.addItems([i.loiqePortalKey,i.valenPortalKey,i.senniPortalKey,i.map1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank,u.senni_harvest,u.senni_portal,u.valen_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo,u.loiqe_port,u.senni_station,u.senni_cargo]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.radio.setRecord(i.record1);
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
        u.senni_fog,
        function() { return verreciel.battery.hasCell(i.battery3) || verreciel.cargo.contains(i.battery3); },
        function() {  verreciel.battery.cellPort3.enable("empty", verreciel.grey); }
      ),
      new Quest(
        "Install cell in battery",
        null,
        function() { return verreciel.battery.hasCell(i.battery3); },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 13
    
    m = new Mission(this.story.length, "Helmet");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.senni_station);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.battery.cellPort3.addEvent(i.battery3);
      verreciel.cargo.addItems([i.loiqePortalKey,i.valenPortalKey,i.senniPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank,u.senni_harvest,u.senni_portal,u.valen_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo,u.loiqe_port,u.senni_cargo,u.senni_station,u.senni_fog,u.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.navPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.setMap(i.map1);
      verreciel.radio.setRecord(i.record2);
      u.valen_bank.addItems([i.record1]);
    }
    m.quests = [
      new Quest(
        "Route map to helmet",
        null,
        function() { return verreciel.player.port.isReceivingFromPanel(verreciel.nav) == true; },
        function() {}
      )
    ]
    this.story.push(m);
    
    // MARK: Part 14
    
    m = new Mission(this.story.length, i.usulPortalKey.name);
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.senni_station);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.battery.cellPort3.addEvent(i.battery3);
      verreciel.cargo.addItems([i.loiqePortalKey,i.valenPortalKey,i.senniPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank,u.senni_harvest,u.senni_portal,u.valen_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo,u.loiqe_port,u.senni_cargo,u.senni_station,u.senni_fog,u.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.navPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.setMap(i.map1);
      verreciel.radio.setRecord(i.record2);
      u.valen_bank.addItems([i.record1]);
    }
    m.predicate = function() { return verreciel.cargo.contains(i.usulPortalKey); };
    m.quests = [
      new Quest(
        "Collect " + i.usulPortalFragment1.name, 
        u.valen_fog,
        function() { return verreciel.cargo.containsLike(i.usulPortalFragment1); },
        function() {}
      ),
      new Quest(
        "Collect " + i.usulPortalFragment2.name, 
        u.loiqe_fog,
        function() { return verreciel.cargo.containsLike(i.usulPortalFragment2); },
        function() {}
      ),
      new Quest(
        "Combine fragments",
        null,
        function() { return verreciel.cargo.containsLike(i.usulPortalKey); },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 15
    
    m = new Mission(this.story.length, "Shield");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.loiqe_horadric);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.battery.cellPort3.addEvent(i.battery3);
      verreciel.cargo.addItems([i.loiqePortalKey,i.valenPortalKey,i.senniPortalKey,i.usulPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank,u.senni_harvest,u.senni_portal,u.valen_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo,u.loiqe_port,u.senni_cargo,u.senni_station,u.valen_fog,u.loiqe_fog,u.senni_fog,u.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.navPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.setMap(i.map1);
      verreciel.radio.setRecord(i.record2);
      u.valen_bank.addItems([i.record1]);
    }
    m.predicate = function() { return verreciel.shield.isInstalled == true; };
    m.quests = [
      new Quest(
        "Install shield", 
        u.usul_station,
        function() { return verreciel.shield.isInstalled == true; },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 16
    
    m = new Mission(this.story.length, i.endPortalKey.name);
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.usul_station);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.battery.cellPort3.addEvent(i.battery3);
      verreciel.cargo.addItems([i.loiqePortalKey,i.valenPortalKey,i.senniPortalKey,i.usulPortalKey]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav,verreciel.shield]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank,u.senni_harvest,u.senni_portal,u.valen_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo,u.loiqe_port,u.senni_cargo,u.valen_fog,u.senni_station,u.loiqe_fog,u.usul_station,u.senni_fog,u.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.navPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.shieldPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.setMap(i.map1);
      verreciel.radio.setRecord(i.record2);
      u.valen_bank.addItems([i.record1]);
    }
    m.predicate = function() { return verreciel.cargo.contains(i.endPortalKey); };
    m.quests = [
      new Quest(
        "Create " + i.endPortalKeyFragment1.name,
        null,
        function() { return verreciel.cargo.contains(i.endPortalKeyFragment1); },
        function() {}
      ),
      new Quest(
        "Create " + i.endPortalKeyFragment2.name,
        null,
        function() { return verreciel.cargo.contains(i.endPortalKeyFragment2); },
        function() {}
      ),
      new Quest(
        "Combine fragments",
        null,
        function() { return verreciel.cargo.containsLike(i.endPortalKey); },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 17
    
    m = new Mission(this.story.length, "Shield");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.senni_horadric);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.battery.cellPort3.addEvent(i.battery3);
      verreciel.cargo.addItems([i.endPortalKey,Item.like(i.currency4),Item.like(i.currency5)]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav,verreciel.shield]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank,u.senni_harvest,u.senni_portal,u.valen_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo,u.loiqe_port,u.senni_cargo,u.valen_fog,u.senni_station,u.loiqe_fog,u.usul_station,u.senni_fog,u.senni_wreck]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      // verreciel.battery.cellPort2.connect(verreciel.battery.radioPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.navPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.setMap(i.map1);
      verreciel.radio.setRecord(i.record2);
      u.valen_bank.addItems([i.record1]);
    }
    m.quests = [
      new Quest(
        "Collect " + i.map2.name, 
        u.usul_telescope,
        function() { return verreciel.nav.port.hasEvent(i.map2) || verreciel.cargo.contains(i.map2); },
        function() {}
      ),
      new Quest(
        "Route " + i.map2.name + " to map",
        null,
        function() { return verreciel.nav.port.hasEvent(i.map2); },
        function() {}
      ),
      new Quest(
        "Collect " + i.shield.name, 
        u.usul_silence,
        function() { return verreciel.shield.port.hasEvent(i.shield) || verreciel.cargo.contains(i.shield); },
        function() {}
      ),
      new Quest(
        "Route " + i.shield.name + " to shield",
        null,
        function() { return verreciel.shield.port.hasEvent(i.shield); },
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
      verreciel.capsule.beginAtLocation(u.usul_silence);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.battery.cellPort3.addEvent(i.battery3);
      verreciel.cargo.addItems([i.endPortalKey,i.map1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav,verreciel.shield]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank,u.senni_harvest,u.senni_portal,u.valen_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo,u.loiqe_port,u.senni_cargo,u.valen_fog,u.senni_station,u.loiqe_fog,u.usul_station,u.senni_fog,u.senni_wreck,u.usul_telescope,u.usul_silence,u.usul_annex]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.navPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.shieldPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.setMap(i.map2);
      verreciel.radio.setRecord(i.record4);
      verreciel.shield.setShield(i.shield);
      u.valen_bank.addItems([i.record1,i.record2]);
    }
    m.quests = [
      new Quest(
        "Extinguish the sun", 
        u.loiqe,
        function() { return u.loiqe.isComplete == true; },
        function() {}
      ),
      new Quest(
        "Extinguish the sun", 
        u.valen,
        function() { return u.valen.isComplete == true; },
        function() {}
      ),
      new Quest(
        "Extinguish the sun", 
        u.senni,
        function() { return u.senni.isComplete == true; },
        function() {}
      ),
      new Quest(
        "Extinguish the sun", 
        u.usul,
        function() { return u.usul.isComplete == true; },
        function() {}
      ),
    ]
    this.story.push(m);
    
    // MARK: Part 19
    
    m = new Mission(this.story.length, "At the close");
    m.state = function() {
      verreciel.capsule.beginAtLocation(u.usul_transit);
      verreciel.battery.cellPort1.addEvent(i.battery1);
      verreciel.battery.cellPort2.addEvent(i.battery2);
      verreciel.battery.cellPort3.addEvent(i.battery3);
      verreciel.cargo.addItems([i.endPortalKey,i.map1]);
      verreciel.missions.setToInstalled([verreciel.battery,verreciel.thruster,verreciel.console,verreciel.radar,verreciel.progress,verreciel.pilot,verreciel.exploration,verreciel.radio,verreciel.journey,verreciel.nav,verreciel.shield]);
      verreciel.missions.setToKnown([u.loiqe_spawn,u.loiqe_harvest,u.loiqe_city,u.loiqe_satellite,u.loiqe_horadric,u.loiqe_portal,u.valen_station,u.valen_cargo,u.valen_bank,u.senni_harvest,u.senni_portal,u.valen_portal]);
      verreciel.missions.setToCompleted([u.loiqe_city,u.loiqe_satellite,u.valen_station,u.valen_cargo,u.loiqe_port,u.senni_cargo,u.valen_fog,u.senni_station,u.loiqe_fog,u.usul_station,u.senni_fog,u.senni_wreck,u.usul_telescope,u.usul_silence,u.usul_annex,u.loiqe,u.valen,u.senni,u.usul]);
      verreciel.battery.cellPort1.connect(verreciel.battery.thrusterPort);
      verreciel.battery.cellPort2.connect(verreciel.battery.navPort);
      verreciel.battery.cellPort3.connect(verreciel.battery.shieldPort);
      verreciel.radar.port.connect(verreciel.pilot.port);
      verreciel.cargo.port.connect(verreciel.console.port);
      verreciel.nav.setMap(i.map2);
      verreciel.radio.setRecord(i.record4);
      verreciel.shield.setShield(i.shield);
      u.valen_bank.addItems([i.record1,i.record2]);
    }
    m.quests = [
      new Quest(
        "Witness", 
        u.close,
        function() { return u.close.isComplete == true; },
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
        u.close,
        function() { return (1 > 2) == true; },
        function() {}
      )
    ]
    this.story.push(m);
  }
  
  // MARK: Tools -
  
  setToInstalled(panels)
  {
    // assertArgs(arguments, 1);
    for (let panel of panels)
    {
      panel.onInstallationComplete();
    }
  }
  
  setToKnown(locations)
  {
    // assertArgs(arguments, 1);
    for (let location of locations)
    {
      location.isKnown = true;
    }
  }
  
  setToCompleted(locations)
  {
    // assertArgs(arguments, 1);
    for (let location of locations)
    {
      if (location.isComplete == false)
      {
        location.onComplete();
      }
      location.isKnown = true;
    }
  }
  
  refresh()
  {
    // assertArgs(arguments, 0);
    this.currentMission.validate();
    if (this.currentMission.isCompleted == true)
    {
      this.updateCurrentMission();
      verreciel.helmet.addWarning(this.currentMission.name, verreciel.cyan, 3, "mission");
    }
  }
  
  updateCurrentMission()
  {
    // assertArgs(arguments, 0);
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
