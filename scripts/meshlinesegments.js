//  Created by Devine Lu Linvega.
//  Copyright © 2017 XXIIVV. All rights reserved.

class MeshLineSegments {
  constructor(source = null) {
    this.geometry = new THREE.BufferGeometry();
    this.geometry.setDrawRange(0, Infinity);
    this.material = new MeshLineSegmentsMaterial();
    this.material.lineWidth = 0.01;
    this.mesh = new THREE.Mesh(this.geometry, this.material);
    this.element = new THREE.Group();
    this.element.add(this.mesh);
    if (source != null) {
      this.updateGeometry(source);
    }
  }

  remakeGeometry(source) {
    // Counts
    this.numQuadSegments = source.length / 2;
    this.numTriangles = this.numQuadSegments * 2;
    this.numIndices = this.numTriangles * 3;
    this.numVertices = this.numQuadSegments * 4;

    // Indices
    this.indices = new Uint32Array(this.numIndices);
    for (let i = 0; i < this.numQuadSegments; i++) {
      this.indices[i * 6 + 0] = (i * 4 + 0) % this.numVertices;
      this.indices[i * 6 + 1] = (i * 4 + 1) % this.numVertices;
      this.indices[i * 6 + 2] = (i * 4 + 2) % this.numVertices;
      this.indices[i * 6 + 3] = (i * 4 + 1) % this.numVertices;
      this.indices[i * 6 + 4] = (i * 4 + 2) % this.numVertices;
      this.indices[i * 6 + 5] = (i * 4 + 3) % this.numVertices;
    }
    this.geometry.setIndex(new THREE.BufferAttribute(this.indices, 1));

    // Start and End Positions
    this.startPositions = new Float32Array(this.numVertices * 3);
    this.startPositionsAttribute = new THREE.BufferAttribute(
      this.startPositions,
      3
    );
    this.geometry.addAttribute("startPosition", this.startPositionsAttribute);

    this.endPositions = new Float32Array(this.numVertices * 3);
    this.endPositionsAttribute = new THREE.BufferAttribute(
      this.endPositions,
      3
    );
    this.geometry.addAttribute("endPosition", this.endPositionsAttribute);

    this.positions = new Float32Array(source.length * 3);
    this.positionsAttribute = new THREE.BufferAttribute(this.positions, 3);
    this.geometry.addAttribute("position", this.positionsAttribute); // for boundary computing

    // Side and Edge offsets
    this.sides = new Float32Array(this.numVertices);
    for (let i = 0; i < this.numVertices; i++) {
      this.sides[i] = i % 2 * 2 - 1;
    }
    this.sidesAttribute = new THREE.BufferAttribute(this.sides, 1);
    this.geometry.addAttribute("side", this.sidesAttribute);

    this.edges = new Float32Array(this.numVertices);
    for (let i = 0; i < this.numVertices; i++) {
      this.edges[i] = Math.floor(i / 2) % 2 * 2 - 1;
    }
    this.edgesAttribute = new THREE.BufferAttribute(this.edges, 1);
    this.geometry.addAttribute("edge", this.edgesAttribute);
  }

  copyPosition(arr, index, pos) {
    arr[index * 3 + 0] = pos.x;
    arr[index * 3 + 1] = pos.y;
    arr[index * 3 + 2] = pos.z;
  }

  updateGeometry(source) {
    if (source.length / 2 != this.numQuadSegments) {
      this.remakeGeometry(source);
    }

    for (let i = 0; i < this.numQuadSegments; i++) {
      let start = source[i * 2 + 0];
      this.copyPosition(this.startPositions, i * 4 + 0, start);
      this.copyPosition(this.startPositions, i * 4 + 1, start);
      this.copyPosition(this.startPositions, i * 4 + 2, start);
      this.copyPosition(this.startPositions, i * 4 + 3, start);

      let end = source[i * 2 + 1];
      this.copyPosition(this.endPositions, i * 4 + 0, end);
      this.copyPosition(this.endPositions, i * 4 + 1, end);
      this.copyPosition(this.endPositions, i * 4 + 2, end);
      this.copyPosition(this.endPositions, i * 4 + 3, end);

      this.copyPosition(this.positions, i * 2 + 0, start);
      this.copyPosition(this.positions, i * 2 + 1, end);
    }

    this.startPositionsAttribute.setArray(this.startPositions);
    this.startPositionsAttribute.needsUpdate = true;

    this.endPositionsAttribute.setArray(this.endPositions);
    this.endPositionsAttribute.needsUpdate = true;

    this.positionsAttribute.setArray(this.positions);

    this.geometry.computeBoundingSphere();
  }
}

class MeshLineSegmentsMaterial extends THREE.ShaderMaterial {
  constructor(params) {
    let innerParams = { side: THREE.DoubleSide, transparent: true };
    if (params != null) {
      for (let prop in params) {
        innerParams[prop] = params[prop];
      }
    }
    super(innerParams);

    this.uniforms.screenAspectRatio = { value: 1 };
    this.uniforms.lineWidth = { value: 1 };
    this.uniforms.diffuse = { value: new THREE.Vector3(1, 1, 1) };
    this.uniforms.opacity = { value: 1.0 };

    this.vertexShader = `
      attribute vec3 startPosition;
      attribute vec3 endPosition;
      attribute float side;
      attribute float edge;
      uniform float screenAspectRatio;
      uniform float lineWidth;

      void main() {

        mat4 screenProjection = projectionMatrix * modelViewMatrix;

        vec4 startScreenPosition = screenProjection * vec4( startPosition, 1.0 );
        vec4 endScreenPosition = screenProjection * vec4( endPosition, 1.0 );

        vec4 currScreenPosition = edge == 1.0 ? startScreenPosition : endScreenPosition;

        vec2 nextPos = startScreenPosition.xy / startScreenPosition.w * vec2(screenAspectRatio, 1.0);
        vec2 currPos = currScreenPosition.xy / currScreenPosition.w * vec2(screenAspectRatio, 1.0);
        vec2 prevPos = endScreenPosition.xy / endScreenPosition.w * vec2(screenAspectRatio, 1.0);

        vec2 dir = normalize( nextPos - prevPos );
        vec2 normal = vec2( dir.y, -dir.x );
        normal.x /= screenAspectRatio;

        float thickness = lineWidth;

        if (currPos == prevPos) {
          dir = normalize(nextPos - currPos);
        } else if (currPos == nextPos) {
          dir = normalize(currPos - prevPos);
        } else {
          vec2 miterDir = normalize( nextPos - prevPos );
          vec2 tangent = normalize( dir + miterDir );
          vec2 miterNormal = vec2( -dir.y, dir.x );
          vec2 miter = vec2( -tangent.y, tangent.x );
          dir = tangent;
          thickness = lineWidth / dot( miter, miterNormal );
        }

        normal = vec2( -dir.y, dir.x );
        normal.x /= screenAspectRatio;

        currScreenPosition.xy += side * normal * currScreenPosition.w * thickness / 2.0;

        gl_Position = currScreenPosition;
      }
    `;

    this.fragmentShader = `
      uniform vec3 diffuse;
      uniform float opacity;

      void main() {
        vec4 diffuseColor = vec4( diffuse, opacity );
        gl_FragColor = diffuseColor;
      }
    `;
  }

  get screenAspectRatio() {
    return this.uniforms.screenAspectRatio.value;
  }

  set screenAspectRatio(newValue) {
    this.uniforms.screenAspectRatio.value = newValue;
  }

  get lineWidth() {
    return this.uniforms.lineWidth.value;
  }

  set lineWidth(newValue) {
    this.uniforms.lineWidth.value = newValue;
  }

  get diffuse() {
    return this.uniforms.diffuse.value;
  }

  set diffuse(newValue) {
    this.uniforms.diffuse.value = newValue;
  }

  get opacity() {
    return this.uniforms.opacity.value;
  }

  set opacity(newValue) {
    if (this.uniforms != null) this.uniforms.opacity.value = newValue;
  }

  get color() {
    return new THREE.Color().fromArray(this.uniforms.diffuse.value.toArray());
  }

  set color(newColor) {
    this.uniforms.diffuse.value.fromArray(newColor.toArray());
  }
}
