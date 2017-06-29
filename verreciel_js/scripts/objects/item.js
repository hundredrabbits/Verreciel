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
  
  payload()
  {
    return new ConsolePayload([
      new ConsoleData("Item", type),
      new ConsoleData(details),
    ]);
  }
}

Item.like = function(other)
{
  let item = new Item();
  item.name = other.name;
  item.type = other.type;
  item.details = other.details;
  item.isQuest = other.isQuest;
  return item;
}
