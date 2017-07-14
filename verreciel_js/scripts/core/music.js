//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Music
{
  constructor()
  {
    // assertArgs(arguments, 0);
    this.track = null;
    this.audioCatalog = {};
    this.ambience = null;
    this.record = null;
  }

  playEffect(name)
  {
    // assertArgs(arguments, 1);
    // console.log("Effect: ",name);
    this.fetchAudio(name, "effect", "media/audio/effect/"+name+".ogg", false).play();
  }

  setAmbience(name)
  {
    if (this.ambience == name)
    {
      return;
    }
    this.ambience = name;
    if (this.track == null)
    {
      this.playAmbience();
    }
  }

  setRecord(name)
  {
    if (this.record == name)
    {
      return;
    }
    this.record = name;
    if (this.track == null)
    {
      this.playRecord();
    }
  }

  playRecord()
  {
    this.switchAudio("record", this.record);
  }

  playAmbience()
  {
    this.switchAudio("ambience", this.ambience);
  }

  switchAudio(role, name)
  {
    if (this.track != null)
    {
      if (this.track.name == name)
      {
        return;
      }
      this.track.pause();
    }

    if (name != null)
    {
      this.track = this.fetchAudio(name, role, "media/audio/" + role + "/" + name + ".mp3", true);
      this.track.currentTime = 0;
      if (DEBUG_NO_MUSIC)
      {
        console.log(role, ":", name, "(off by debug)");
      }
      else
      {
        console.log(role, ":", name);
        this.track.play();
      }
    }
  }

  fetchAudio(name, role, src, loop)
  {
    // assertArgs(arguments, 3);
    var audioId = role + "_" + name;
    if (!(audioId in this.audioCatalog))
    {
      var audio = new Audio();
      audio.name = name;
      audio.src = src;
      audio.loop = loop;
      this.audioCatalog[audioId] = audio;
    }
    this.audioCatalog[audioId].currenceTime = 0;
    return this.audioCatalog[audioId];
  }
}
