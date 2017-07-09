class SceneLabel extends Empty
{
  constructor(text = "", scale = 0.1, align = Alignment.left, color = verreciel.white)
  {
    assertArgs(arguments, 1);
    super();

    this.nodeOffset = new Empty();
    this.color = color;
    this.activeText = text;
    this.activeScale = scale;
    this.activeAlignment = align;
    
    this.addLetters(this.activeText, this.activeScale);
    this.adjustAlignment();
    
    this.add(this.nodeOffset);
  }
  
  adjustAlignment()
  {
    assertArgs(arguments, 0);
    if (this.activeAlignment == Alignment.center)
    {
      let wordLength = this.activeText.length * this.activeScale * 1.5;
      this.nodeOffset.position.setNow((-wordLength/2), 0, 0);
    }
    else if (this.activeAlignment == Alignment.right)
    {
      let wordLength = this.activeText.length * this.activeScale * 1.5;
      this.nodeOffset.position.setNow(-wordLength + (this.activeScale * 0.5), 0, 0);
    }
  }
  
  addLetters(text, scale)
  {
    assertArgs(arguments, 2);
    var letterPos = 0;
    var linePos = 0;
    for (let letterCur of text)
    {
      if (letterCur == "$")
      {
        linePos += 1;
        letterPos = 0;
        continue;
      }
      let letterNode = this.letter(letterCur, scale);
      letterNode.position.setNow(scale * 1.5 * letterPos, scale * linePos * -4.15, 0);
      this.nodeOffset.add(letterNode);
      letterPos += 1;
    }
  }
  
  removeLetters()
  {
    assertArgs(arguments, 0);
    while (this.nodeOffset.children.length > 0)
    {
      this.nodeOffset.remove(this.nodeOffset.children[0]);
    }
  }
  
  updateText(text, color = null)
  {
    assertArgs(arguments, 1);

    if (text == null)
    {
      text = this.activeText;
    }

    if (color == null)
    {
      color = this.color;
    }
    
    if (this.activeText != text || !this.color.equals(color))
    {
      this.removeLetters();
      this.activeText = text;
      this.color = color;
      this.addLetters(this.activeText, this.activeScale);
      this.adjustAlignment();
    }
  }
  
  updateScale(scale)
  {
    assertArgs(arguments, 1);
    this.activeScale = scale;
    this.removeLetters();
    this.addLetters(this.activeText, this.activeScale);
    this.adjustAlignment();
  }
  
  updateColor(color)
  {
    assertArgs(arguments, 1);
    if (this.color.equals(color))
    {
      return;
    }
    this.color = color;
    this.removeLetters();
    this.addLetters(this.activeText, this.activeScale);
    this.adjustAlignment()
  }
  
  letter(char, scale)
  {
    assertArgs(arguments, 2);
    let pivot = new Empty();
    switch (char.toLowerCase())
    {
      case "a":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "b":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "c":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "d":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "e":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0)], this.color));
        break;
      case "f":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0)], this.color));
        break;
      case "g":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale, 0, 0)], this.color));
        break;
      case "h":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "i":
        pivot.add(new SceneLine([new THREE.Vector3(scale/2, scale, 0), new THREE.Vector3(scale/2, -scale, 0)], this.color));
        break;
      case "j":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale/2, scale, 0), new THREE.Vector3(scale/2, -scale, 0), new THREE.Vector3(scale/2, -scale, 0), new THREE.Vector3(0, -scale, 0)], this.color));
        break;
      case "k":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "l":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "m":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale/2, scale, 0), new THREE.Vector3(scale/2, 0, 0)], this.color));
        break;
      case "n":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "o":
        pivot.add(new SceneLine([new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0)], this.color));
        break;
      case "p":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(0, 0, 0)], this.color));
        break;
      case "q":
        pivot.add(new SceneLine([new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "r":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "s":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "t":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale/2, scale, 0), new THREE.Vector3(scale/2, -scale, 0)], this.color));
        break;
      case "u":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, scale, 0)], this.color));
        break;
      case "v":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale/2, -scale, 0), new THREE.Vector3(scale/2, -scale, 0), new THREE.Vector3(scale, scale, 0)], this.color));
        break;
      case "w":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale/2, -scale, 0)], this.color));
        break;
      case "x":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, scale, 0)], this.color));
        break;
      case "y":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale/2, -scale, 0)], this.color));
        break;
      case "z":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "1":
        pivot.add(new SceneLine([new THREE.Vector3(scale/2, scale, 0), new THREE.Vector3(scale/2, -scale, 0)], this.color));
        break;
      case "2":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "3":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "4":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "5":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "6":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(0, 0, 0)], this.color));
        break;
      case "7":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "8":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case "9":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0)], this.color));
        break;
      case "0":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0)], this.color));
        break;
      case ":":
        pivot.add(new SceneLine([new THREE.Vector3(scale/2, scale/2, 0), new THREE.Vector3(scale/2, -scale/2, 0)], this.color));
        break;
      case " ":
        break;
      case "~":
        break;
      case "/":
        pivot.add(new SceneLine([new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, scale, 0)], this.color));
        break;
      case "-":
        pivot.add(new SceneLine([new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0)], this.color));
        break;
      case "&":
      case "+":
        pivot.add(new SceneLine([new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale/2, scale, 0), new THREE.Vector3(scale/2, -scale, 0)], this.color));
        break;
      case ">":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, 0, 0)], this.color));
        break;
      case "<":
        pivot.add(new SceneLine([new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, 0, 0)], this.color));
        break;
      case ",":
        pivot.add(new SceneLine([new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale/2, -scale, 0)], this.color));
        break;
      case "?":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale/2, -scale / 4, 0), new THREE.Vector3(scale/2, -scale / 2, 0), new THREE.Vector3(scale/2, -scale, 0)], this.color));
        break;
      case ".":
        pivot.add(new SceneLine([new THREE.Vector3(scale/2, 0, 0), new THREE.Vector3(scale/2, -scale, 0)], this.color));
        break;
      case "'":
        pivot.add(new SceneLine([new THREE.Vector3(scale/2, scale, 0), new THREE.Vector3(scale/2, 0, 0)], this.color));
        break;
      case "%":
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, 0, 0), new THREE.Vector3(scale, 0, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0)], this.color));
        break;
      default:
        console.warn("Bad letter: [" + char.toLowerCase() + "]");
        pivot.add(new SceneLine([new THREE.Vector3(0, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(0, -scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(0, scale, 0), new THREE.Vector3(scale, -scale, 0), new THREE.Vector3(scale, scale, 0), new THREE.Vector3(scale, -scale, 0)], verreciel.red));
        break;
    }

    return pivot;
  }
}
