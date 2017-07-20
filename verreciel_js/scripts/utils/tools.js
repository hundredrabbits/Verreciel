//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

function degToRad(degrees) {
  // assertArgs(arguments, 1);
  return degrees / 180 * Math.PI;
}

function radToDeg(value) {
  // assertArgs(arguments, 1);
  return value * 180 / Math.PI;
}

function distanceBetweenTwoPoints(point1, point2) {
  // assertArgs(arguments, 2);
  let xDist = point2.x - point1.x;
  let yDist = point2.y - point1.y;
  return Math.sqrt(xDist * xDist + yDist * yDist);
}

function angleBetweenTwoPoints(point1, point2, center) {
  // assertArgs(arguments, 3);
  let dx1 = point1.x - center.x;
  let dy1 = point1.y - center.y;
  let dx2 = point2.x - center.x;
  let dy2 = point2.y - center.y;
  let angle = Math.atan2(dy2, dx2) - Math.atan2(dy1, dx1);

  var deg = angle * 180 / Math.PI;
  if (deg < 0) {
    deg += 360;
  }

  return deg;
}

function sanitizeAngle(angle, inDegrees = false) {
  return angle % ((inDegrees ? 360 : Math.PI * 2) * (angle < 0 ? -1 : 1));
}

function sanitizeDiffAngle(angle1, angle2, inDegrees = false) {
  var diffAngle = sanitizeAngle(angle1) - sanitizeAngle(angle2);
  let limit = inDegrees ? 180 : Math.PI;
  if (diffAngle > limit) {
    diffAngle -= 2 * limit;
  } else if (diffAngle < -limit) {
    diffAngle += 2 * limit;
  }
  return diffAngle;
}

function delay(seconds, callback) {
  // assertArgs(arguments, 2);
  return setTimeout(callback, seconds * 1000 / verreciel.game.gameSpeed);
}

function cancelDelay(delayID) {
  // assertArgs(arguments, 1);
  clearTimeout(delayID);
}

function assertArgs(args, length, exact = false) {
  if (args.length < length || (exact && args.length != length)) {
    console.warn(
      "INCORRECT ARGS: " +
        args.length +
        " != " +
        length +
        "\n" +
        getStackTrace()
    );
  }
}

function getStackTrace() {
  var record = {};
  Error.captureStackTrace(record, getStackTrace);
  return record.stack;
}

function loadAsset(path, callback, mimeType = null) {
  let xhr = new XMLHttpRequest();
  if (mimeType != null) {
    xhr.overrideMimeType(mimeType);
  }
  xhr.open("GET", path, true);
  xhr.onreadystatechange = function() {
    if (xhr.readyState == 4 && xhr.status == "200") {
      callback(xhr.responseText);
    }
  };
  xhr.send(null);
}
