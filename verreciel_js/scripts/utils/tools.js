function degToRad(degrees)
{
  return degrees / 180 * Math.PI;
}

function radToDeg(value)
{
  return value * 180 / Math.PI;
}

function distanceBetweenTwoPoints(point1, point2)
{
  let xDist = point2.x - point1.x;
  let yDist = point2.y - point1.y;
  return Math.sqrt((xDist * xDist) + (yDist * yDist));
}

function angleBetweenTwoPoints(point1, point2, center)
{
  let dx1 = point1.x - center.x;
  let dy1 = point1.y - center.y;
  let dx2 = point2.x - center.x;
  let dy2 = point2.y - center.y;
  let angle = Math.atan2(dy2, dx2) - Math.atan2(dy1, dx1);
  
  var deg = angle * 180 / Math.PI;
  if (deg < 0)
  {
    deg += 360;
  }
  
  return deg;
}

function delay(seconds, callback)
{
  setTimeout(callback, seconds * 1000);
}

function assertArgs(args, length)
{
  if (args.length != length)
  {
    throw "INCORRECT ARGS: " + args.length + " != " + length;
  }
}
