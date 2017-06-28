class Item extends Event
{
  constructor(name = "", type = ItemTypes.generic, location = null, details = "", isQuest = false, code)
  {
    super();
    
    this.name = name;
    this.type = type;
    this.details = details;
    this.isQuest = isQuest;
    this.location = location;
    this.code = code;
  }
  
  /*
  constructor(like)
  {
    super.init()
    
    self.name = like.name
    self.type = like.type
    self.details = like.details
    self.isQuest = like.isQuest
  }
  */
  
  payload()
  {
    return new ConsolePayload([
      new ConsoleData("Item", type),
      new ConsoleData(details),
    ]);
  }
}
