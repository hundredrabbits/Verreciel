## Loiqe

Start capsule with battery
Start capsule with battery 1

### 0. Tutorial

Route cell to thruster
Undock with thruster
Accelerate with Thruster
Wait for arrival
Route [currency1] to cargo
Route cargo to console
Undock with thruster
Wait for arrival

### 1. Fragments
Route [currency1] to verreciel.cargo
Route [currency1] to trade table
Route [valenPortalFragment1] to verreciel.cargo

### 2. Radar
Select satellite on radar
Route Radar to Pilot

### 3. Portal
Aquire [valenPortalFragment1]
Aquire [valenPortalFragment2]
Combine fragments

## 4. Transit
Route [valenPortalKey] to Portal
Align pilot to portal
Power Thruster with portal

## Valen

### 5. Valen
Collect [record1]
Collect second cell
Collect [currency2]
Install radio

### 6. Record
Install cell in battery
Power radio
Route record to radio

### 7. Hatch
Collect Waste
Route waste to hatch
Jetison Waste

### 8. Currencies
Collect [loiqePortalKey]
Aquire [currency2]
Aquire [currency1]
Combine currencies

## Senni

## 9. Senni
Aquire [currency4]
Trade [currency4] for [senniPortalKey]

### 10. Map
Collect [map1]
Collect [currency3]
Install map

### 11. Fog
Power Map in battery
Route fog to map
Collect third cell
Install cell in battery

### 12. Helmet
Route map to helmet

## Usul 

### 13. Usul
Collect [usulPortalFragment1]
Collect [usulPortalFragment2]
Combine fragments

### 14. Shield
Align senni transmitter to Usul Radar
Align loiqe transmitter to Usul Radar
Install shield
Collect glass
Route glass to shield
Power Shield

### 15. Veil
Aquire Map 2
Combine maps
Install Veil

### 16. Extinguish
Extinguish loiqe
Extinguish valen
Extinguish senni
Extinguish usul

### 15. End Key
Create [endPortalKeyFragment1]
Create [endPortalKeyFragment2]
Combine fragments

### 16. Aitasla
Extinguish the Loiqe sun
Extinguish the Valen sun
Extinguish the Senni sun
Extinguish the Usul sun

### 16. At the close[TODO]

Witness

## MISSION: End
Stop

## Recipes

### Currencies

```
metal(cur1) --+
              | meseta(cur4) --+
sutal(cur2) --+                | icon(cur6)
              | suveta(cur5) --+
vital(cur3) --+
```

### Tracks

```
record(track1) --+
                 | archive(track5) --+
disk(track2)   --+                   |
                                     | story(track7)
tape(track3)   --+                   |
                 | volume(track6)  --+
drive(track4)  --+
```

### Maps

red(map1)  --+
             > opal(map3)
cyan(map2) --+

### Harvest Points

- Loiqe: metal
- Valen: sutal
- Senni: vital

### Old Currencies

- metal(alta)
- sutal(ikov)
- vital(eral)
- meseta(alitov)
- suveta(ikeral)
- icon(echo)

Mission(14), create cur4.

## Origins & References

- The Horadric location, comes from diablo.
- the Meseta currency, comes from phantasy star online.

## Notes

It's weird when the helmet gives old quest instructions for the current mission
  I don't mean in response to mistakes, I mean when the player's doing the right thing

Routing the helmet into the console could allow the user to type in commands.

-------

beacons
  One in south valen, one in south usul
  starts red, pressing button turns it grey
    takes three times as long as harvest
    50% chance of no result
  Returns cipher
  cipher 1 & cipher 2 = key to Nevic

Nevic
  South of loiqe
  Not sure what to do there though
  Maybe work veil into it?
  Green space, black stars
  Black approachable sun
    It’s always night$under the$ultraviolet sun
    Give LocationStar another parameter
