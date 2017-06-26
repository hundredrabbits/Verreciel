function Music()
{
  this.track_ambient = new Audio();
  this.track_effect = new Audio();
  this.track_record = new Audio();
  
  this.audio_catalog = {};

  this.is_muted = false;

  this.play_effect = function(name)
  {
    console.log("Effect: ",name);
    this.track_effect = this.fetch_audio(name, "effect", "media/audio/effect/"+name+".ogg");
    this.track_effect.play()
  }

  this.play_record = function(name)
  {
    console.log("Record: ",name);
    this.track_record = this.fetch_audio(name, "record", "media/audio/record/"+name+".ogg");
    this.track_record.play()
  }

  this.play_ambient = function(name)
  {
    if(this.track_ambient.name == name){ return; }
    if(DEBUG){ return; }

    // Fadeout
    $(this.track_ambient).animate({volume: 0}, 1000, function(){
      console.log("Music: ",name);

      oquonie.music.track_ambient.pause();
      oquonie.music.track_ambient = oquonie.music.fetch_audio(name, "ambient", "media/audio/ambient/"+name+".mp3", true);
      if(oquonie.music.is_muted == false){ oquonie.music.track_ambient.play(); }
      $(oquonie.music.track_ambient).animate({volume: 1}, 1000);
    });
  }

  this.fetch_audio = function(name, role, src, loop = false)
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

  this.pause_ambience = function()
  {
    this.is_muted = true;

    $(this.track_ambient).animate({volume: 0}, 1000, function(){
      oquonie.music.track_ambient.pause();
    });
  }

  this.resume_ambience = function()
  {
    this.track_ambient.play();
    this.track_ambient.volume = 0;
    $(this.track_ambient).animate({volume: 1}, 1000);
    this.is_muted = false;
  }
}
