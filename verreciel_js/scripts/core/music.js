class Music
{
  constructor()
  {
    assertArgs(arguments, 0);
    this.trackEffect = new Audio();
    this.trackMusic = new Audio();
    this.audioCatalog = {};
  }

  playEffect(name)
  {
    assertArgs(arguments, 1);
    // console.log("Effect: ",name);
    this.trackEffect = this.fetchAudio(name, "effect", "media/audio/effect/"+name+".ogg", false);
    this.trackEffect.play()
  }

  playMusic(name, role)
  {
    assertArgs(arguments, 1);
    if (this.trackMusic.name == name)
    {
      return;
    }

    if (DEBUG_NO_MUSIC == true)
    {
      console.log(role, ":", name, " (off by debug)");
      return;
    }

    console.log(role, ":", name);

    this.trackMusic.pause();
    this.trackMusic = this.fetchAudio(name, role, "media/audio/" + role + "/" + name + ".mp3", true);
    this.trackMusic.currentTime = 0;
    this.trackMusic.play();
  }

  fetchAudio(name, role, src, loop)
  {
    assertArgs(arguments, 3);
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
