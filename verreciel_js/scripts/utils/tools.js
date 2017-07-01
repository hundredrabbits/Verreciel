function degToRad(degrees)
{
  assertArgs(arguments, 1);
  return degrees / 180 * Math.PI;
}

function radToDeg(value)
{
  assertArgs(arguments, 1);
  return value * 180 / Math.PI;
}

function distanceBetweenTwoPoints(point1, point2)
{
  assertArgs(arguments, 2);
  let xDist = point2.x - point1.x;
  let yDist = point2.y - point1.y;
  return Math.sqrt((xDist * xDist) + (yDist * yDist));
}

function angleBetweenTwoPoints(point1, point2, center)
{
  assertArgs(arguments, 3);
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

function sanitizeAngle(angle)
{
  while (angle.x < -Math.PI * 2) { angle.x += Math.PI * 2; }
  while (angle.x >  Math.PI * 2) { angle.x -= Math.PI * 2; }
  // TODO: the simpler implementation
  return angle;
}

function delay(seconds, callback)
{
  assertArgs(arguments, 2);
  setTimeout(callback, seconds * 1000);
}

function assertArgs(args, length, exact = false)
{
  if (args.length < length || (exact && args.length != length))
  {
    console.warn("INCORRECT ARGS: " + args.length + " != " + length + "\n" + getStackTrace());
  }
}

function getStackTrace()
{
  var record = {};
  Error.captureStackTrace(record, getStackTrace);
  return record.stack;
};
