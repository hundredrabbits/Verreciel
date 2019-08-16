//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Locations {
  constructor () {
    // assertArgs(arguments, 0);
    this.loiqe = new Loiqe(new THREE.Vector2(0, -3))
    this.usul = new Usul(new THREE.Vector2(-3, 0))
    this.valen = new Valen(new THREE.Vector2(3, 0))
    this.senni = new Senni(new THREE.Vector2(0, 3))
    this.aitasla = new Aitasla(new THREE.Vector2(0, 0))
  }
}

class Loiqe {
  constructor (offset) {
    // assertArgs(arguments, 1);
    this.system = Systems.loiqe
    this.offset = offset
  }

  star () {
    // assertArgs(arguments, 0);
    return new LocationStar('Loiqe', this.system, this.offset)
  }

  spawn () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'spawn',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y - 2.75),
      'Are you sure$that you are in$space.',
      verreciel.items.teapot,
      verreciel.items.map2
    )
  }

  harvest () {
    // assertArgs(arguments, 0);
    return new LocationHarvest(
      'Harvest',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y - 2),
      Item.like(verreciel.items.currency1)
    )
  }

  city () {
    // assertArgs(arguments, 0);
    return new LocationTrade(
      'City',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y - 1),
      verreciel.items.currency1,
      verreciel.items.valenPortalFragment1
    )
  }

  horadric () {
    // assertArgs(arguments, 0);
    return new LocationHoradric(
      'Horadric',
      this.system,
      new THREE.Vector2(this.offset.x + 2, this.offset.y)
    )
  }

  portal () {
    // assertArgs(arguments, 0);
    return new LocationPortal(
      'portal',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y + 1)
    )
  }

  satellite () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'satellite',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y),
      'something broken$somewhen lost',
      verreciel.items.valenPortalFragment2
    )
  }

  port () {
    // assertArgs(arguments, 0);
    return new LocationTrade(
      'port',
      this.system,
      new THREE.Vector2(this.offset.x - 1, this.offset.y),
      verreciel.items.currency4,
      verreciel.items.senniPortalKey
    )
  }

  // MARK: Fog

  transit () {
    // assertArgs(arguments, 0);
    return new LocationTransit(
      'transit',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y + 2),
      verreciel.items.map2
    )
  }

  fog () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'fog',
      this.system,
      new THREE.Vector2(this.offset.x - 2, this.offset.y),
      'something broken$somehow lost',
      verreciel.items.usulPortalFragment2,
      verreciel.items.map1
    )
  }

  transmitter () {
    // assertArgs(arguments, 0);
    return new LocationTransmitter(
      'transmitter',
      this.system,
      new THREE.Vector2(this.offset.x - 1, this.offset.y - 1),
      verreciel.items.map1
    )
  }

  // Map2

  cargo () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'cargo',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y - 1),
      'le soleil est noir',
      verreciel.items.veil1
    )
  }

  // Constellations

  c_1 () {
    // assertArgs(arguments, 0);
    return new LocationConstellation(
      '',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y - 1.5),
      new StructureTunnel()
    )
  }
}

class Valen {
  constructor (offset) {
    // assertArgs(arguments, 1);
    this.system = Systems.valen
    this.offset = offset
  }

  star () {
    // assertArgs(arguments, 0);
    return new LocationStar('Valen', this.system, this.offset)
  }

  bank () {
    // assertArgs(arguments, 0);
    return new LocationBank(
      'Bank',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y + 1)
    )
  }

  portal () {
    // assertArgs(arguments, 0);
    return new LocationPortal(
      'portal',
      this.system,
      new THREE.Vector2(this.offset.x - 1, this.offset.y)
    )
  }

  harvest () {
    // assertArgs(arguments, 0);
    return new LocationHarvest(
      'harvest',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y + 2),
      Item.like(verreciel.items.currency2)
    )
  }

  station () {
    // assertArgs(arguments, 0);
    return new LocationStation(
      'station',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y + 1),
      verreciel.items.currency2,
      function () {
        verreciel.radio.install()
      },
      'Radio'
    )
  }

  cargo () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'cargo',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y + 2),
      'Extra power$battery format',
      verreciel.items.battery2
    )
  }

  market () {
    // assertArgs(arguments, 0);
    return new LocationTrade(
      'market',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y - 1),
      verreciel.items.waste,
      verreciel.items.kelp
    )
  }

  // MARK: Fog

  transit () {
    // assertArgs(arguments, 0);
    return new LocationTransit(
      'transit',
      this.system,
      new THREE.Vector2(this.offset.x - 2, this.offset.y),
      verreciel.items.map2
    )
  }

  fog () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'fog',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y - 1),
      'something broken$somehow lost',
      verreciel.items.usulPortalFragment1,
      verreciel.items.map1
    )
  }

  antenna () {
    // assertArgs(arguments, 0);
    return new LocationAntenna(
      'antenna',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y - 1),
      function () {
        verreciel.veil.install()
      },
      'veil',
      verreciel.items.map2
    )
  }

  c_1 () {
    // assertArgs(arguments, 0);
    return new LocationConstellation(
      '',
      this.system,
      new THREE.Vector2(this.offset.x + 0.5, this.offset.y + 1.5),
      new StructureDoor()
    )
  }

  // MARK: Blind

  void () {
    // assertArgs(arguments, 0);
    return new LocationTrade(
      'void',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y - 2),
      verreciel.items.teapot,
      verreciel.items.kelp,
      verreciel.items.map2
    )
  }
}

class Senni {
  constructor (offset) {
    // assertArgs(arguments, 1);
    this.system = Systems.senni
    this.offset = offset
  }

  star () {
    // assertArgs(arguments, 0);
    return new LocationStar('Senni', this.system, this.offset)
  }

  portal () {
    // assertArgs(arguments, 0);
    return new LocationPortal(
      'portal',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y - 1)
    )
  }

  cargo () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'cargo',
      this.system,
      new THREE.Vector2(this.offset.x - 1, this.offset.y),
      'extra sight$map format',
      verreciel.items.map1
    )
  }

  harvest () {
    // assertArgs(arguments, 0);
    return new LocationHarvest(
      'harvest',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y + 1),
      Item.like(verreciel.items.currency3)
    )
  }

  station () {
    // assertArgs(arguments, 0);
    return new LocationStation(
      'station',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y),
      verreciel.items.currency3,
      function () {
        verreciel.nav.install()
      },
      'Map'
    )
  }

  transmitter () {
    // assertArgs(arguments, 0);
    return new LocationTransmitter(
      'transmitter',
      this.system,
      new THREE.Vector2(this.offset.x - 1, this.offset.y + 1)
    )
  }

  // MARK: Fog

  transit () {
    // assertArgs(arguments, 0);
    return new LocationTransit(
      'transit',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y - 2),
      verreciel.items.map2
    )
  }

  horadric () {
    // assertArgs(arguments, 0);
    return new LocationHoradric(
      'Horadric',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y + 2),
      verreciel.items.map1
    )
  }

  fog () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'fog',
      this.system,
      new THREE.Vector2(this.offset.x + 2, this.offset.y),
      'Extra power$battery format',
      verreciel.items.battery3,
      verreciel.items.map1
    )
  }

  wreck () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'wreck',
      this.system,
      new THREE.Vector2(this.offset.x - 2, this.offset.y),
      'Memories$of misfortune',
      verreciel.items.record2,
      verreciel.items.map1
    )
  }

  // MARK: Silence

  bog () {
    // assertArgs(arguments, 0);
    return new LocationTrade(
      'bog',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y + 1),
      verreciel.items.kelp,
      verreciel.items.record_oquonie,
      verreciel.items.map2
    )
  }
}

class Usul {
  constructor (offset) {
    // assertArgs(arguments, 1);
    this.system = Systems.usul
    this.offset = offset
  }

  star () {
    // assertArgs(arguments, 0);
    return new LocationStar('usul', this.system, this.offset)
  }

  portal () {
    // assertArgs(arguments, 0);
    return new LocationPortal(
      'portal',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y)
    )
  }

  // MARK: Fog

  transit () {
    // assertArgs(arguments, 0);
    return new LocationTransit(
      'transit',
      this.system,
      new THREE.Vector2(this.offset.x + 2, this.offset.y),
      verreciel.items.map2
    )
  }

  cargo () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'cargo',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y + 1),
      'as above$so below',
      verreciel.items.map2,
      verreciel.items.map1
    )
  }

  telescope () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'telescope',
      this.system,
      new THREE.Vector2(this.offset.x - 1, this.offset.y),
      'star injection$glass capsule',
      verreciel.items.shield,
      verreciel.items.map1
    )
  }

  antenna () {
    // assertArgs(arguments, 0);
    return new LocationAntenna(
      'antenna',
      this.system,
      new THREE.Vector2(this.offset.x, this.offset.y - 1),
      function () {
        verreciel.shield.install()
      },
      'shield',
      verreciel.items.map1
    )
  }

  transmitter () {
    // assertArgs(arguments, 0);
    return new LocationTransmitter(
      'transmitter',
      this.system,
      new THREE.Vector2(this.offset.x + 1, this.offset.y - 1),
      verreciel.items.map1
    )
  }

  // MARK: Blind

  silence () {
    // assertArgs(arguments, 0);
    return new LocationTrade(
      'silence',
      this.system,
      new THREE.Vector2(this.offset.x - 2, this.offset.y),
      verreciel.items.currency6,
      verreciel.items.shield,
      verreciel.items.map2
    )
  }

  annex () {
    // assertArgs(arguments, 0);
    return new LocationSatellite(
      'annex',
      this.system,
      new THREE.Vector2(this.offset.x - 1, this.offset.y + 1),
      'A vivid moment$on repeat',
      verreciel.items.record4,
      verreciel.items.map2
    )
  }
}

class Aitasla {
  constructor (offset) {
    // assertArgs(arguments, 1);
    this.system = Systems.aitasla
    this.offset = offset
  }

  void () {
    // assertArgs(arguments, 0);
    return new LocationAitasla(
      'aitasla',
      this.system,
      this.offset,
      verreciel.items.map2
    )
  }
}
