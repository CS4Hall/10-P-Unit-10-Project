var secretNumber;
var currentInput = ""; 
var guessHistory = []; 
var feedback = "Tap the numbers to guess!";
var gameOver = false;

// Array for our button labels
var buttons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "CLR", "ENT"];

setup = function() {
  size(600, 500);
  secretNumber = floor(random(1, 101));
  textAlign(CENTER, CENTER);
}

draw = function() {
  background(40, 44, 52);

  // 1. Display Current Input (The Screen)
  fill(20);
  rect(150, 40, 300, 60, 10); // Screen background
  fill(0, 255, 150);
  textSize(32);
  text(currentInput, width / 2, 70);

  // 2. Feedback Text
  fill(255);
  textSize(16);
  text(feedback, width / 2, 120);

  // 3. THE LOOP: Draw the Number Pad
  for (var i = 0; i < buttons.length; i++) {
    // Calculate grid positions (3 columns)
    var col = i % 3;
    var row = floor(i / 3);
    var x = 200 + col * 70;
    var y = 150 + row * 60;

    // Draw Button Rectangle
    fill(70, 80, 100);
    stroke(255);
    rect(x, y, 60, 50, 5);
    
    // Draw Button Label
    fill(255);
    noStroke();
    textSize(18);
    text(buttons[i], x + 30, y + 25);
  }

  // 4. THE LOOP: Draw Guess History
  fill(150);
  text("History:", 50, 150);
  for (var i = 0; i < guessHistory.length; i++) {
    fill(200);
    text(guessHistory[i], 50, 180 + (i * 25));
  }

  if (gameOver) {
    fill(255, 204, 0);
    textSize(20);
    text("WINNER! Click anywhere to Reset.", width / 2, height - 40);
  }
}

mouseClicked = function() {
  if (gameOver) {
    resetGame();
    return;
  }

  // Check which button was clicked using the same loop logic
  for (var i = 0; i < buttons.length; i++) {
    var col = i % 3;
    var row = floor(i / 3);
    var x = 200 + col * 70;
    var y = 150 + row * 60;

    // If mouse is inside the current button's rectangle
    if (mouseX > x && mouseX < x + 60 && mouseY > y && mouseY < y + 50) {
      handleInput(buttons[i]);
    }
  }
}

function handleInput(val) {
  if (val === "CLR") {
    currentInput = "";
  } else if (val === "ENT") {
    submitGuess();
  } else {
    // Limits input to 3 digits (max 999)
    if (currentInput.length < 3) {
      currentInput += val;
    }
  }
}

function submitGuess() {
  if (currentInput !== "") {
    var guess = int(currentInput);
    guessHistory.push(guess);
    
    if (guess === secretNumber) {
      feedback = "CORRECT! The number was " + secretNumber;
      gameOver = true;
    } else if (guess < secretNumber) {
      feedback = "Too Low! Try higher.";
    } else {
      feedback = "Too High! Try lower.";
    }
    currentInput = "";
  }
}

function resetGame() {
  secretNumber = floor(random(1, 101));
  guessHistory = [];
  currentInput = "";
  feedback = "New game! Guess 1-100.";
  gameOver = false;
}