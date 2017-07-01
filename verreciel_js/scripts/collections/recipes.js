class Recipes
{
  constructor()
  {
    assertArgs(arguments, 0);
    this.horadric = [];

    this.horadric.push( new Recipe([verreciel.items.record1, verreciel.items.record2], verreciel.items.record3) );
    
    // Keys
    
    this.horadric.push( new Recipe([verreciel.items.valenPortalFragment1, verreciel.items.valenPortalFragment2], verreciel.items.valenPortalKey) );
    this.horadric.push( new Recipe([verreciel.items.usulPortalFragment1, verreciel.items.usulPortalFragment2], verreciel.items.usulPortalKey) );
    
    this.horadric.push( new Recipe([verreciel.items.valenPortalKey, verreciel.items.usulPortalKey], verreciel.items.endPortalKeyFragment1) );
    this.horadric.push( new Recipe([verreciel.items.loiqePortalKey, verreciel.items.senniPortalKey], verreciel.items.endPortalKeyFragment2) );
    this.horadric.push( new Recipe([verreciel.items.endPortalKeyFragment1, verreciel.items.endPortalKeyFragment2], verreciel.items.endPortalKey) );
    
    // Currencies
    
    this.horadric.push( new Recipe([verreciel.items.currency1, verreciel.items.currency2], Item.like(verreciel.items.currency4)) );
    this.horadric.push( new Recipe([verreciel.items.currency2, verreciel.items.currency3], Item.like(verreciel.items.currency5)) );
    this.horadric.push( new Recipe([verreciel.items.currency4, verreciel.items.currency5], Item.like(verreciel.items.currency6)) );
    
    //
    
    this.horadric.push( new Recipe([verreciel.items.record1, verreciel.items.record2], verreciel.items.record4) );
  }
}
