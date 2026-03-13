// Arrays to store ocean life
var fishX = [];
var fishY = [];
var fishEmoji = [];
var numFish = 500; // How dense do we want the crowd?

// Variables for the "special" emoji
var hiddenX;
var hiddenY;
var hiddenType = "⭐️"; // Change this to whatever you want (👻, 💎, 🤡)

var gameStatus = "Search the crowd for the Starfish! Click it.";

setup = function() {
  size(600, 400);
  
  // Choose random ocean-themed emojis
  var possibleFish = ["🐟", "🐠", "🐡", "🦈", "🐙", "🦑", "🦀", "🦞", "🦐"];
  
  // THE INITIALIZATION LOOP: Fill the crowd arrays
  for (var i = 0; i < numFish; i++) {
    fishX.push(random(0, width));
    fishY.push(random(0, height));
    // Pick a random emoji from our ocean list
    fishEmoji.push(possibleFish[round(random(0,possibleFish.length-1))])
    //fishEmoji.push(round(random(possibleFish[0,possibleFish.length-1])));
  }
  
  // Pick ONE random location for the special hidden emoji
  hiddenX = random(0, width);
  hiddenY = random(0, height);
}

draw = function() {
  background(20, 100, 200); // Deep blue ocean
  
  // Set emoji settings
  textSize(24);
  textAlign(CENTER, CENTER);

  // Draw the special hidden item (the target)
  // Students can try to layer this *inside* the main loop to hide it better!
  text(hiddenType, hiddenX, hiddenY);

  // THE LOOP: Draw the massive crowd of common fish
  // Use the loop to "stamp" emojis from the arrays onto the canvas
  for (var i = 0; i < fishEmoji.length; i++) {
    text(fishEmoji[i], fishX[i], fishY[i]);
  }
  

  
  // UI Display (Score/Status)
  fill(255);
  rect(10, 10, width - 20, 50, 10);
  fill(0);
  textSize(20);
  text(gameStatus, width / 2, 35);

  if(keyPressed){
    if(key == 'r' || key == 'R'){
        resetGame();
    }
  }
}

mouseClicked = function() {
  // Check if the user clicked near the hidden object
  // Using dist() helps account for the "hitbox" size of the emoji
  var distance = dist(mouseX, mouseY, hiddenX, hiddenY);
  
  if (distance < 20) { // If they clicked within 20 pixels
    gameStatus = "YOU FOUND IT! Play again? (Press r)";
  }
}



resetGame = function() {
  // Move the common fish to new locations
  for (var i = 0; i < numFish; i++) {
    fishX[i] = random(0, width);
    fishY[i] = random(0, height);
  }
  
  // Pick a new location for the target
  hiddenX = random(0, width);
  hiddenY = random(0, height);
  
  gameStatus = "Search the crowd for the Starfish! Click it.";
}