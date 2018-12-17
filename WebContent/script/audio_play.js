 // Create a couple of global variables to use. 
                var audioElm = document.getElementById("audio1"); // Audio element
         
                //  Alternates between play and pause based on the value of the paused property
                function togglePlay() {
                  if (document.getElementById("audio1")) {
         
                    if (audioElm.paused == true) {
                      playAudio(audioElm);    //  if player is paused, then play the file
                    } else {
                      pauseAudio(audioElm);   //  if player is playing, then pause
                    }
                  }
                }
         
                function playAudio(audioElm) {
               //   document.getElementById("playbutton").innerHTML = "Pause"; // Set button text == Pause
                  // Get file from text box and assign it to the source of the audio element 
                  audioElm.src = "../files/warning.mp3";
                  audioElm.play();
                }
         
                function pauseAudio(audioElm) {
                //  document.getElementById("playbutton").innerHTML = "play"; // Set button text == Play
                  audioElm.pause();
                }