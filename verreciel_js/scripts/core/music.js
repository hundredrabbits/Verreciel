class Music
{
  constructor()
  {
    assertArgs(arguments, 0);
    this.trackAmbience = new Audio();
    this.trackEffect = new Audio();
    this.trackRecord = new Audio();
    this.audioCatalog = {};
    this.ambienceMuted = false;
    this.recordMuted = false;
  }

  playEffect(name)
  {
    assertArgs(arguments, 1);
    console.log("Effect: ",name);
    this.trackEffect = this.fetchAudio(name, "effect", "media/audio/effect/"+name+".ogg");
    this.trackEffect.play()
  }

  playRecord(name)
  {
    assertArgs(arguments, 1);
    if (this.trackRecord.name == name)
    {
      return;
    }

    // Fadeout
    $(this.trackRecord).animate({volume: 0}, 1000, function()
    {
      console.log("Record: ",name);

      verreciel.music.trackRecord.pause();
      verreciel.music.trackRecord = verreciel.music.fetchAudio(name, "record", "media/audio/record/"+name+".mp3", true);
      if (verreciel.music.recordMuted == false)
      {
        verreciel.music.trackRecord.play();
      }
      verreciel.music.trackRecord.volume = 0;
      $(verreciel.music.trackRecord).animate({volume: 1}, 1000);
    });
  }

  playAmbience(name)
  {
    assertArgs(arguments, 1);
    if (this.trackAmbience.name == name)
    {
      return;
    }

    // Fadeout
    $(this.trackAmbience).animate({volume: 0}, 1000, function()
    {
      console.log("Music: ",name);

      verreciel.music.trackAmbience.pause();
      verreciel.music.trackAmbience = verreciel.music.fetchAudio(name, "ambience", "media/audio/ambience/"+name+".mp3", true);
      if (verreciel.music.ambienceMuted == false)
      {
        verreciel.music.trackAmbience.play();
      }
      verreciel.music.trackAmbience.volume = 0;
      $(verreciel.music.trackAmbience).animate({volume: 1}, 1000);
    });
  }

  fetchAudio(name, role, src, loop = false)
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

  pauseAmbience()
  {
    assertArgs(arguments, 0);
    this.ambienceMuted = true;
    $(this.trackAmbience).animate({volume: 0}, 1000, function()
    {
      verreciel.music.trackAmbience.pause();
    });
  }

  resumeAmbience()
  {
    assertArgs(arguments, 0);
    this.trackAmbience.play();
    this.trackAmbience.volume = 0;
    $(this.trackAmbience).animate({volume: 1}, 1000);
    this.ambienceMuted = false;
  }

  pauseRecord()
  {
    assertArgs(arguments, 0);
    this.recordMuted = true;

    $(this.trackRecord).animate({volume: 0}, 1000, function()
    {
      verreciel.music.trackRecord.pause();
    });
  }

  resumeRecord()
  {
    assertArgs(arguments, 0);
    this.trackRecord.play();
    this.trackRecord.volume = 0;
    $(this.trackRecord).animate({volume: 1}, 1000);
    this.recordMuted = false;
  }
}
