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
                var height = Math.floor(gameSize.y / rows);
                var width = Math.floor(gameSize.x / cols);
                var col = Math.floor(event.pageX / width);
                console.log("Clicked! " + event.pageX + " " + event.pageY + " in Column " + col);

                var x = Math.floor((col * width) + (width / 2)) // x position in middle of column
                //find first empty row in that column
                for (var i = rows; i > 0; i--) {
                    var y = Math.ceil((i) * height - (height / 2)); // y position in middle of row
                    console.log("Getting image data for " + x + " " + y);
                    var imageData = context.getImageData(x, y, 1, 1);
                    console.log("Image Data is " + imageData.data[0] + " " + imageData.data[1] + " " + imageData.data[2] + " " + imageData.data[3]);
                    if (imageData.data[3] === 0) { //if transparent meaning empty
                        drawCircle(context, x, y, red);
                        red = !red;
                        break;
                    } // end if
                } //end for
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

    var drawCircle = function(context, x, y, red) {
            console.log("Drawing circle!");
            //see http://www.html5canvastutorials.com/tutorials/html5-canvas-circles/
            //see http://www.tauday.com/tau-manifesto
            var TAU = 2 * Math.PI;
            context.beginPath();
            //see http://www.w3schools.com/tags/canvas_arc.asp
            context.arc(x, y, 10, 0, TAU);
            context.fillStyle = red ? 'red' : 'black';
            context.fill();
        };

    window.onload = function() {
        new Game("screen");
    };

})();
