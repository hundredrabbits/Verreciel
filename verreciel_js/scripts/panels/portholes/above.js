class Above extends Panel
{
  constructor()
  {
    // assertArgs(arguments, 0);
    super();
    
    let aim = new Empty();
    var i = 0;
    while (i < 3)
    {
      let test = new SceneLine([new THREE.Vector3(0,Templates.radius * -2,0.75), new THREE.Vector3(0,Templates.radius * -2,0.95)], verreciel.white);
      test.rotation.y = degToRad(120 * i);
      aim.add(test);
      aim.rotation.y = degToRad(0);
      i += 1;
    }
    this.root.add(aim);
  }
  
  whenSecond()
  {
    // assertArgs(arguments, 0);
    super.whenSecond();
    
    if (verreciel.thruster.speed > 0)
    {
      this.root.updateChildrenColors(verreciel.white);
    }
    else
    {
      this.root.updateChildrenColors(verreciel.grey);
    }
    
    verreciel.animator.begin();
    verreciel.animator.animationDuration = 0.5;
    this.rotation.y = degToRad(Math.floor((radToDeg(verreciel.player.rotation.y)+22.5)/45) * 45);
    verreciel.animator.commit();
  }
}
