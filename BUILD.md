## Build

Don't forget to ```npm cache clean```!

### Build Linux64 / Darwin64 / Windows64(Offsite)

```
cd /xxiivv/Nataniev/public/public.projects/sources/Verreciel/

rm -r /xxiivv/Nataniev/public/public.projects/builds/Verreciel-linux-x64/ 
rm /xxiivv/Nataniev/public/public.projects/builds/verreciel_lin64.zip
electron-packager . Verreciel --platform=linux --arch=x64 --out /xxiivv/Nataniev/public/public.projects/builds --overwrite --electron-version=1.7.5 --icon=icon.ico

rm -r /xxiivv/Nataniev/public/public.projects/builds/Verreciel-win32-x64/ 
rm /xxiivv/Nataniev/public/public.projects/builds/verreciel_win64.zip
electron-packager . Verreciel --platform=win32 --arch=x64 --out /xxiivv/Nataniev/public/public.projects/builds --overwrite --electron-version=1.7.5 --icon=icon.ico

rm -r /xxiivv/Nataniev/public/public.projects/builds/Verreciel-darwin-x64/
rm /xxiivv/Nataniev/public/public.projects/builds/verreciel_osx64.zip
electron-packager . Verreciel --platform=darwin --arch=x64 --out /xxiivv/Nataniev/public/public.projects/builds --overwrite --electron-version=1.7.5 --icon=icon.icns

cd /xxiivv/Nataniev/public/public.projects/builds/

~/butler push /xxiivv/Nataniev/public/public.projects/builds/Verreciel-linux-x64/ hundredrabbits/verreciel:linux-64
~/butler push /xxiivv/Nataniev/public/public.projects/builds/Verreciel-win32-x64/ hundredrabbits/verreciel:windows-64
~/butler push /xxiivv/Nataniev/public/public.projects/builds/Verreciel-darwin-x64/ hundredrabbits/verreciel:osx-64

rm -r /xxiivv/Nataniev/public/public.projects/builds/Verreciel-darwin-x64/
rm -r /xxiivv/Nataniev/public/public.projects/builds/Verreciel-linux-x64/
rm -r /xxiivv/Nataniev/public/public.projects/builds/Verreciel-win32-x64/

~/butler status hundredrabbits/verreciel
```

### Build Linux64 / Darwin64 / Windows64(Local)
```
cd /Users/VillaMoirai/Desktop/
rm -r /Users/VillaMoirai/Desktop/Verreciel-darwin-x64/ 
rm -r /Users/VillaMoirai/Desktop/Verreciel-linux-x64/ 
rm -r /Users/VillaMoirai/Desktop/Verreciel-win32-x64/ 

cd /Users/VillaMoirai/Github/HundredRabbits/Verreciel/
electron-packager . Verreciel --platform=darwin --arch=x64 --out /Users/VillaMoirai/Desktop/ --overwrite --electron-version=1.7.5 --icon=icon.icns

cd /Users/VillaMoirai/Github/HundredRabbits/Verreciel/
electron-packager . Verreciel --platform=linux --arch=x64 --out /Users/VillaMoirai/Desktop/ --overwrite --electron-version=1.7.5 --icon=icon.ico

cd /Users/VillaMoirai/Github/HundredRabbits/Verreciel/
electron-packager . Verreciel --platform=win32 --arch=x64 --out /Users/VillaMoirai/Desktop/ --overwrite --electron-version=1.7.5 --icon=icon.ico
```
