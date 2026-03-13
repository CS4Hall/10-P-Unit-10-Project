var xPositions = []; // Empty array for X coordinates
var yPositions = []; // Empty array for Y coordinates
var flakeSize = [];  // Array to make some flakes bigger than others
var quantity = 100;  // How many flakes do we want?

setup = function() {
  size(600, 400);


  // THE INITIALIZATION LOOP: Fill the arrays with random data once
  for (var i = 0; i < quantity; i++) {
    xPositions.push(random(0, width));
    yPositions.push(random(0, height));
    flakeSize.push(random(2, 7));
  }
}

draw = function() {
  background(10, 20, 40); // Deep night sky
  noStroke();
  fill(255);

  // THE UPDATE LOOP: Move and draw every single flake
  for (var i = 0; i < xPositions.length; i++) {
    
    // 1. Draw the flake using the data from the arrays
    ellipse(xPositions[i], yPositions[i], flakeSize[i], flakeSize[i]);

    // 2. Update the position (gravity)
    yPositions[i] += 2; 

    // 3. The "Reset" Logic: If it goes off the bottom, move to the top
    if (yPositions[i] > height) {
      yPositions[i] = -10;
      xPositions[i] = random(0, width); // Randomize X so it looks fresh
    }
  }
  
  // UI Overlay
  fill(255);
  text("Flakes Active: " + xPositions.length, 20, height - 40);
  text("Press 'A' to add more, 'R' to remove", 20, height - 20);


  if(keyPressed){
    if(key == 'a' || key == 'A'){
      xPositions.push(random(width));
      yPositions.push(0);
      flakeSize.push(random(2, 7));
    }

    if((key == 'r' || key == 'R') && xPositions.length > 0){
        xPositions.pop();
        yPositions.pop();
        flakeSize.pop();
    }
  }
}

