//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class Quest
{
  constructor(name, location, predicate, result)
  {
    // assertArgs(arguments, 4);
    this.isCompleted = false;
    this.isSkipped = false;

    this.name = name;
    this.location = location;
    this.predicate = predicate;
    this.result = result;
  }

  validate()
  {
    // assertArgs(arguments, 0);
    if (this.isSkipped == true)
    {
      this.isCompleted = true;
    }
    else if (this.predicate())
    {
      this.complete();
    }
    else
    {
      this.isCompleted = false;
    }
  }
  
  complete()
  {
    // assertArgs(arguments, 0);
    if (this.isCompleted == true)
    {
      return;
    }
    this.isCompleted = true;
    this.result();
  }
}
