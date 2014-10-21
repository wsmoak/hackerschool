(function() {
    // see http://benalman.com/news/2010/11/immediately-invoked-function-expression/
    var Game = function(canvasId) {
            var rows = 6;
            var cols = 7;
            var red = true;

            // see http://html5doctor.com/an-introduction-to-the-canvas-2d-api/
            var canvas = document.getElementById(canvasId);
            var gameSize = {
                x: canvas.width,
                y: canvas.height
            };
            var context = canvas.getContext('2d');

            drawGrid(context, gameSize, cols);

            canvas.addEventListener('click', function(event) {
				// we don't care what row they clicked on, the game piece will drop to the lowest available row
                var col = Math.ceil( event.pageX / (gameSize.x / cols));
				var x = Math.ceil((col * 45) - (45/2)) // x position in middle of column
                console.log("Clicked! " + event.pageX + " " + event.pageY + " in Column " + col);
			    //# if row 0 for that column is filled in, prompt for a different column
			    if ( false ) { 
					console.log( "That column is full");
				} else {
					//find first empty row in that column
					for( var i = rows; i > 0; i--) {
						  var y = Math.ceil((i+1)*45 - (45/2)); // y position in middle of row
						  console.log ("Getting image data for " + x + " " + y );
						  var imageData = context.getImageData(x,y,1,1);
						  console.log( "Image Data is " + imageData.data[0] + " " + imageData.data[1] );
						  drawCircle(context, i, col, red);
		                  red = !red
						}
					}
				
            });


        };

    var drawGrid = function(context, gameSize, cols) {
            var width = gameSize.x / cols;
            for (var i = 0; i < cols; i++) {
                context.rect(i * width, 0, (i + 1) * width, gameSize.y);
                context.strokeStyle = 'yellow';
                context.lineWidth = '3';
                context.stroke();
            }
        };

    var drawCircle = function(context, row, col, red) {
            //see http://www.html5canvastutorials.com/tutorials/html5-canvas-circles/
            //see http://www.tauday.com/tau-manifesto
            var TAU = 2 * Math.PI;
            context.beginPath();
            //see http://www.w3schools.com/tags/canvas_arc.asp
            context.arc(col * 45 - (45 / 2), row * 45 - (45 / 2), 10, 0, TAU);
            context.fillStyle = red ? 'red' : 'black';
            context.fill();
        };

    window.onload = function() {
        new Game("screen");
    };

})();
