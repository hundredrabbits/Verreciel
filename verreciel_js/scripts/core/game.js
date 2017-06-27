class Game
{
  constructor()
  {
    console.log("^ Game | Init");
    this.time = 0;
    setTimeout(this.onTic.bind(this), 50);
    setTimeout(this.whenSecond.bind(this), 1000);
  }
  
  whenStart()
  {
    console.log("+ Game | Start");
    this.load(this.state);
  }
  
  save(id)
  {
    console.log("@ GAME     | Saved State to \(id)");
    for (c of document.cookie.split(";"))
    {
      document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/");
    }
    localStorage.state = id;
    localStorage.version = version;
  }
  
  load(id)
  {
    id = (id == 20) ? 0 : id;
    
    console.log("@ GAME     | Loaded State to \(id)");
    
    for (let mission of verreciel.missions.story)
    {
      if (mission.id < id)
      {
        mission.complete();
      }
    }
    verreciel.missions.story[id].state();
  }
  
  get state()
  {
    if ("state" in localStorage)
    {
      return parseInt(localStorage.state);
    }
    return 0;
  }
  
  erase()
  {
    console.log("$ GAME     | Erase");
    localStorage.clear();
  }
  
  whenSecond()
  {
    setTimeout(this.whenSecond.bind(this), 1000);
    verreciel.capsule.whenSecond();
    verreciel.missions.refresh();
  }
  
  onTic()
  {
    setTimeout(this.onTic.bind(this), 50);
    this.time += 1;
    verreciel.space.whenTime();
  }
}
