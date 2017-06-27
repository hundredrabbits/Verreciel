class Music
{
  constructor()
  {
    this.track_ambient = new Audio();
    this.track_effect = new Audio();
    this.track_record = new Audio();
    this.audio_catalog = {};
    this.ambient_muted = false;
    this.record_muted = false;
  }

  play_effect(name)
  {
    console.log("Effect: ",name);
    this.track_effect = this.fetch_audio(name, "effect", "media/audio/effect/"+name+".ogg");
    this.track_effect.play()
  }

  play_record(name)
  {
    if(this.track_record.name == name){ return; }

    // Fadeout
    $(this.track_record).animate({volume: 0}, 1000, function(){
      console.log("Record: ",name);

      verreciel.music.track_record.pause();
      verreciel.music.track_record = verreciel.music.fetch_audio(name, "record", "media/audio/record/"+name+".mp3", true);
      if(verreciel.music.record_muted == false){ verreciel.music.track_record.play(); }
      $(verreciel.music.track_record).animate({volume: 1}, 1000);
    });
  }

  play_ambient(name)
  {
    if(this.track_ambient.name == name){ return; }

    // Fadeout
    $(this.track_ambient).animate({volume: 0}, 1000, function(){
      console.log("Music: ",name);

      verreciel.music.track_ambient.pause();
      verreciel.music.track_ambient = verreciel.music.fetch_audio(name, "ambient", "media/audio/ambient/"+name+".mp3", true);
      if(verreciel.music.ambient_muted == false){ verreciel.music.track_ambient.play(); }
      $(verreciel.music.track_ambient).animate({volume: 1}, 1000);
    });
  }

  fetch_audio(name, role, src, loop = false)
  {
      var audio_id = role + "_" + name;
      if (!(audio_id in this.audio_catalog))
      {
        var audio = new Audio();
        audio.name = name;
        audio.src = src;
        audio.loop = loop;
        this.audio_catalog[audio_id] = audio;
      }
      this.audio_catalog[audio_id].currentTime = 0;
      return this.audio_catalog[audio_id];
  }

  pause_ambient()
  {
    this.ambient_muted = true;

    $(this.track_ambient).animate({volume: 0}, 1000, function(){
      verreciel.music.track_ambient.pause();
    });
  }

  resume_ambient()
  {
    this.track_ambient.play();
    this.track_ambient.volume = 0;
    $(this.track_ambient).animate({volume: 1}, 1000);
    this.ambient_muted = false;
  }

  pause_record()
  {
    this.record_muted = true;

    $(this.track_record).animate({volume: 0}, 1000, function(){
      verreciel.music.track_record.pause();
    });
  }

  resume_record()
  {
    this.track_record.play();
    this.track_record.volume = 0;
    $(this.track_record).animate({volume: 1}, 1000);
    this.record_muted = false;
  }
}
