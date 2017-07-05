class Game
{
  constructor()
  {
    assertArgs(arguments, 0);
    console.log("^ Game | Init");
    this.time = 0;
  }
  
  whenStart()
  {
    assertArgs(arguments, 0);
    console.log("+ Game | Start");
    setTimeout(this.onTic.bind(this), 50);
    setTimeout(this.whenSecond.bind(this), 1000);
    this.load(this.state);
  }
  
  save(id)
  {
    assertArgs(arguments, 1);
    if (DEBUG_DONT_SAVE) { return; }
    console.log("@ GAME     | Saved State to " + id);
    for (let c of document.cookie.split(";"))
    {
      document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/");
    }
    localStorage.state = id;
    localStorage.version = verreciel.version;
  }
  
  load(id)
  {
    assertArgs(arguments, 1);
    id = (id == 20) ? 0 : id;
    
    console.log("@ GAME     | Loaded State to " + id);
    
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
    assertArgs(arguments, 0);
    if ("state" in localStorage)
    {
      return parseInt(localStorage.state);
    }
    return 0;
  }
  
  erase()
  {
    assertArgs(arguments, 0);
    console.log("$ GAME     | Erase");
    localStorage.clear();
  }
  
  whenSecond()
  {
    assertArgs(arguments, 0);
    setTimeout(this.whenSecond.bind(this), 1000);
    verreciel.capsule.whenSecond();
    verreciel.missions.refresh();
  }
  
  onTic()
  {
    assertArgs(arguments, 0);
    setTimeout(this.onTic.bind(this), 50);
    this.time += 1;
    verreciel.space.whenTime();
  }
}
