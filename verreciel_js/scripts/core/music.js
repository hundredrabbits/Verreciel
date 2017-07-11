class Music
{
  constructor()
  {
    // assertArgs(arguments, 0);
    this.track = null;
    this.audioCatalog = {};
  }

  playEffect(name)
  {
    // assertArgs(arguments, 1);
    // console.log("Effect: ",name);
    this.fetchAudio(name, "effect", "media/audio/effect/"+name+".ogg", false).play();
  }

  playMusic(name, role)
  {
    // assertArgs(arguments, 1);
    if (this.track != null && this.track.name == name)
    {
      return;
    }

    if (DEBUG_NO_MUSIC == true)
    {
      console.log(role, ":", name, " (off by debug)");
      return;
    }

    console.log(role, ":", name);

    if (this.track != null)
    {
      this.track.pause();
    }
    this.track = this.fetchAudio(name, role, "media/audio/" + role + "/" + name + ".mp3", true);
    this.track.currentTime = 0;
    this.track.play();
  }

  stopMusic()
  {
    if (this.track != null)
    {
      this.track.pause();
      this.track = null;
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
