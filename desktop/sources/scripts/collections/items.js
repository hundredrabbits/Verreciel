//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Items {
  constructor () {
    // assertArgs(arguments, 0);
    // Misc
    this.kelp = new Item(
      'space kelp',
      ItemTypes.waste,
      null,
      'useless',
      false,
      'kelp'
    )
    this.waste = new Item(
      'waste',
      ItemTypes.waste,
      null,
      'useless',
      false,
      'waste'
    )

    // "Keys"
    this.endPortalKey = new Item(
      'aitasla key',
      ItemTypes.key,
      null,
      'aitasla warp key',
      true,
      'end-key'
    )
    this.endPortalKeyFragment1 = new Item(
      'horizontal part',
      ItemTypes.fragment,
      null,
      'half Portal key',
      true,
      'end-key-1'
    )
    this.endPortalKeyFragment2 = new Item(
      'vertical part',
      ItemTypes.fragment,
      null,
      'half Portal key',
      true,
      'end-key-2'
    )
    this.loiqePortalKey = new Item(
      'loiqe key',
      ItemTypes.key,
      null,
      'complete key',
      true,
      'loiqe-key'
    )
    this.senniPortalKey = new Item(
      'senni key',
      ItemTypes.key,
      null,
      'complete key',
      true,
      'senni-key'
    )
    this.usulPortalFragment1 = new Item(
      'usul Part 1',
      ItemTypes.fragment,
      null,
      'half Portal key',
      true,
      'usul-key-1'
    )
    this.usulPortalFragment2 = new Item(
      'usul Part 2',
      ItemTypes.fragment,
      null,
      'half Portal key',
      true,
      'usul-key-2'
    )
    this.usulPortalKey = new Item(
      'usul key',
      ItemTypes.key,
      null,
      'complete key',
      true,
      'usul-key'
    )
    this.valenPortalFragment1 = new Item(
      'valen part 1',
      ItemTypes.fragment,
      null,
      'half Portal key',
      true,
      'valen-key-1'
    )
    this.valenPortalFragment2 = new Item(
      'valen part 2',
      ItemTypes.fragment,
      null,
      'half Portal key',
      true,
      'valen-key-2'
    )
    this.valenPortalKey = new Item(
      'valen key',
      ItemTypes.key,
      null,
      'complete key',
      true,
      'valen-key'
    )

    // "Etc.."
    this.warpDrive = new Item(
      'warpdrive',
      ItemTypes.drive,
      null,
      'local warpdrive',
      true,
      'warp'
    )

    // "Records"
    this.record1 = new Item(
      'record',
      ItemTypes.record,
      null,
      'audio format',
      true,
      'record1'
    )
    this.record2 = new Item(
      'disk',
      ItemTypes.record,
      null,
      'audio format',
      true,
      'record2'
    )
    this.record3 = new Item(
      'tape',
      ItemTypes.record,
      null,
      'audio format',
      true,
      'record3'
    )
    this.record4 = new Item(
      'drive',
      ItemTypes.record,
      null,
      'audio format',
      true,
      'record4'
    )

    // "Maps"
    this.map1 = new Item(
      'Red Map',
      ItemTypes.map,
      null,
      'map expension',
      true,
      'map-1'
    )
    this.map2 = new Item(
      'Cyan Map',
      ItemTypes.map,
      null,
      'map expension',
      true,
      'map-2'
    )
    this.map3 = new Item(
      'Opal Map',
      ItemTypes.map,
      null,
      'map expension',
      true,
      'map-3'
    )

    // "Shields(fields)"

    // "Harvest"
    this.currency1 = new Item(
      'metal',
      ItemTypes.currency,
      null,
      'trading currency',
      false,
      'currency-1'
    )
    this.currency2 = new Item(
      'sutal',
      ItemTypes.currency,
      null,
      'trading currency',
      false,
      'currency-2'
    )
    this.currency3 = new Item(
      'vital',
      ItemTypes.currency,
      null,
      'trading currency',
      false,
      'currency-3'
    )
    this.currency4 = new Item(
      'meseta',
      ItemTypes.currency,
      null,
      'From 1 & 2',
      false,
      'currency-4'
    )
    this.currency5 = new Item(
      'suveta',
      ItemTypes.currency,
      null,
      'From 2 & 3',
      false,
      'currency-5'
    )
    this.currency6 = new Item(
      'icon',
      ItemTypes.currency,
      null,
      'From 4 & 5',
      false,
      'currency-6'
    )
    this.record_oquonie = new Item(
      'record',
      ItemTypes.record,
      null,
      'wet',
      true,
      'record5'
    )
    this.shield = new Item(
      'glass',
      ItemTypes.shield,
      null,
      'star sand',
      true,
      'shield-1'
    )
    this.shield2 = new Item(
      'mirror',
      ItemTypes.shield,
      null,
      'red mirror',
      true,
      'shield-2'
    )

    // "Batteries"
    this.battery1 = new Item(
      'cell',
      ItemTypes.battery,
      null,
      'power source',
      true,
      'battery-1'
    )
    this.battery2 = new Item(
      'cell',
      ItemTypes.battery,
      null,
      'power source',
      true,
      'battery-2'
    )
    this.battery3 = new Item(
      'cell',
      ItemTypes.battery,
      null,
      'power source',
      true,
      'battery-3'
    )
    // Veils

    this.veil1 = new Item(
      'sphere veil',
      ItemTypes.veil,
      null,
      'dyson sphere',
      true,
      'veil-1'
    )

    // "Echoes"
    this.teapot = new Item(
      'a teapot',
      ItemTypes.unknown,
      null,
      'is paradise',
      true,
      'echoes-1'
    )
  }

  whenStart () {
    // assertArgs(arguments, 0);
    this.loiqePortalKey.location = verreciel.universe.loiqe_portal
    this.valenPortalKey.location = verreciel.universe.valen_portal
    this.senniPortalKey.location = verreciel.universe.senni_portal
    this.usulPortalKey.location = verreciel.universe.usul_portal
    this.endPortalKey.location = verreciel.universe.aitasla
  }
}
