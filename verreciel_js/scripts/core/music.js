class Music
{
  constructor()
  {
    this.trackAmbient = new Audio();
    this.trackEffect = new Audio();
    this.trackRecord = new Audio();
    this.audioCatalog = {};
    this.ambientMuted = false;
    this.recordMuted = false;
  }

  playEffect(name)
  {
    console.log("Effect: ",name);
    this.trackEffect = this.fetchAudio(name, "effect", "media/audio/effect/"+name+".ogg");
    this.trackEffect.play()
  }

  playRecord(name)
  {
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

  playAmbient(name)
  {
    if (this.trackAmbient.name == name)
    {
      return;
    }

    // Fadeout
    $(this.trackAmbient).animate({volume: 0}, 1000, function()
    {
      console.log("Music: ",name);

      verreciel.music.trackAmbient.pause();
      verreciel.music.trackAmbient = verreciel.music.fetchAudio(name, "ambient", "media/audio/ambient/"+name+".mp3", true);
      if (verreciel.music.ambientMuted == false)
      {
        verreciel.music.trackAmbient.play();
      }
      verreciel.music.trackAmbient.volume = 0;
      $(verreciel.music.trackAmbient).animate({volume: 1}, 1000);
    });
  }

  fetchAudio(name, role, src, loop = false)
  {
      var audioId = role + "_" + name;
      if (!(audioId in this.audioCatalog))
      {
        var audio = new Audio();
        audio.name = name;
        audio.src = src;
        audio.loop = loop;
        this.audioCatalog[audioId] = audio;
      }
      this.audioCatalog[audioId].currentTime = 0;
      return this.audioCatalog[audioId];
  }

  pauseAmbient()
  {
    this.ambientMuted = true;
    $(this.trackAmbient).animate({volume: 0}, 1000, function()
    {
      verreciel.music.trackAmbient.pause();
    });
  }

  resumeAmbient()
  {
    this.trackAmbient.play();
    this.trackAmbient.volume = 0;
    $(this.trackAmbient).animate({volume: 1}, 1000);
    this.ambientMuted = false;
  }

  pauseRecord()
  {
    this.recordMuted = true;

    $(this.trackRecord).animate({volume: 0}, 1000, function()
    {
      verreciel.music.trackRecord.pause();
    });
  }

  resumeRecord()
  {
    this.trackRecord.play();
    this.trackRecord.volume = 0;
    $(this.trackRecord).animate({volume: 1}, 1000);
    this.recordMuted = false;
  }
}
