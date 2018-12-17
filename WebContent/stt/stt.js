/**
 * http://usejsdoc.org/
 */

		if('webkitSpeechRecognition' in window){
			var finalTranscripts = '';
			var speechRecognizer = new webkitSpeechRecognition();
			speechRecognizer.continuous = true;
			speechRecognizer.interimResults = true;
			speechRecognizer.lan = 'en-US'
			
			function startConverting(){
				//document.write('hi');확인됨
				speechRecognizer.start();
				speechRecognizer.onresult = function(e) {
					
					var interimTranscripts = '';
					
					//document.write('onresult complete'); //확인댐 잘 작동됨
					//document.write(e.result);
					for(var i = e.resultIndex; i < e.results.length; i++){
						var transcript = e.results[i][0].transcript;
						transcript.replace("\n","<br>");
						if(event.results[i].isFinal){
							finalTranscripts += transcript;
						}else{
							interimTranscripts += transcript;
						}
						//document.getElementById('result').write(finalTranscripts + interimTranscripts);
						document.getElementById("result").innerHTML =  finalTranscripts + interimTranscripts +"\n";
						//document.write(finalTranscripts + interimTranscripts);
					}
					
					
				//var lastResultIdx = event.results.resultIndex;
				//	r.innerHTML= event.results[lastResultIdx][0].transcript; 
				};
		
			}
			speechRecognizer.onerror = function (event) {
				
			};
		}else {
			r.innerHTML = 'Your browser is not supported. If google chrome please upgrade';
		}
		
		window.onload = function init() {
			try {
				window.AudioContext = window.AudioContext || window.webkitAudioContext || window.mozAudioContext;
				navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;    
				window.URL = window.URL || window.webkitURL || window.mozURL;
				audio_context = new AudioContext();    
				console.log('Audio context set up.');    
				console.log('navigator.getUserMedia ' + (navigator.getUserMedia ? 'available.' : 'not present!'));  
			} catch (e) {    
				document.write('No web audio support in this browser!');  
			}
			navigator.getUserMedia({audio: true}, startUserMedia, function(e) {    
				console.warn('No live audio input: ' + e);  
			});
		};
		
		