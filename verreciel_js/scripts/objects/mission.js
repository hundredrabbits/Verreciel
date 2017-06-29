class Mission
{
  constructor(id, name, requirement = function(){ return true; }, state = function(){ } )
  {
    this.isCompleted = false;
    this.quests = [];
    this.predicate = function(){ return false; };
    this.id = id;
    this.name = name;
    this.requirement = requirement;
    this.state = state;
  }
  
  validate()
  {
    if (this.currentQuest == null)
    {
      this.currentQuest = this.quests[0];
    }
    if (this.predicate() == true)
    {
      this.complete();
    }
    
    for (let quest of this.quests)
    {
      quest.validate();
      if (quest.isCompleted == false)
      {
        this.currentQuest = quest;
        this.prompt();
        return;
      }
    }
    this.isCompleted = true;
  }
  
  prompt()
  {
    if (this.currentQuest.location != null)
    {
      if (capsule.isDockedAtLocation(this.currentQuest.location))
      {
        verreciel.helmet.addMessage(this.currentQuest.name)
      }
      else if (verreciel.capsule.system == this.currentQuest.location.system)
      {
        if (this.currentQuest.location.system == this.currentQuest.location.name)
        {
          verreciel.helmet.addMessage("Reach " + this.currentQuest.location.name, verreciel.red);
        }
        else
        {
          verreciel.helmet.addMessage("Reach " + this.currentQuest.location.system + " " + this.currentQuest.location.name, verreciel.red);
        }
      }
      else
      {
        verreciel.helmet.addMessage("Reach the " + this.currentQuest.location.system + " system", verreciel.cyan);
      }
    }
    else
    {
      verreciel.helmet.addMessage(this.currentQuest.name);
    }
  }
  
  onComplete()
  {
    verreciel.completion.refresh();
  }
  
  complete()
  {
    this.isCompleted = true;
    for (let quest of this.quests)
    {
      quest.complete();
    }
  }
}
