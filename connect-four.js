// Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | October 2014
// Connect Four game
(function() {
    // see http://benalman.com/news/2010/11/immediately-invoked-function-expression/
    var Game = function(canvasId) {
            var ROWS = 6;
            var COLS = 7;
            var red = true;

            // see http://html5doctor.com/an-introduction-to-the-canvas-2d-api/
            var canvas = document.getElementById(canvasId);
            // see http://www.w3.org/TR/2dcontext/ 
            var context = canvas.getContext('2d');

            drawColumnGrid(context, COLS);
            drawRowGrid(context, ROWS);

            canvas.addEventListener('click', function(event) {
                var rowHeight = Math.floor(context.canvas.height / ROWS);
                var columnWidth = Math.floor(context.canvas.width / COLS);

                // we don't care what row they clicked on, the game piece will drop to the lowest available row
                var col = Math.floor(event.pageX / columnWidth);

                console.log("Clicked! " + event.pageX + " " + event.pageY + " in Column " + col);

                var x = Math.floor((col * columnWidth) + (columnWidth / 2)) // x position in middle of column
                //ignore click events that fall outside the width of the canvas (how does this happen?)
                if (col >= 0 && col < COLS) {
                    //find first empty row in that column
                    for (var row = ROWS; row > 0; row--) {
                        var y = Math.ceil((row * rowHeight) - (rowHeight / 2)); // y position in middle of row
                        // see http://www.w3schools.com/tags/canvas_getimagedata.asp
                        var imageData = context.getImageData(x, y, 1, 1);
                        console.log("Image Data for " + x + " " + y + " is " + imageData.data[0] + " " + imageData.data[1] + " " + imageData.data[2] + " " + imageData.data[3]);
                        if (imageData.data[3] === 0) { //if transparent meaning the space is empty
                            drawCircle(context, x, y, red);
                            red = !red; //toggle player color true/false -> red/black
                            break;
                        } // end if
                    } //end for
                } //end if
            });


        };

    var drawColumnGrid = function(context, cols) {
            var columnWidth = context.canvas.width / cols;
            for (var i = 0; i < cols; i++) {
                context.rect(i * columnWidth, 0, columnWidth, context.canvas.height);
                context.strokeStyle = 'yellow';
                context.lineWidth = '3';
                context.stroke();
            }
        };

    var drawRowGrid = function(context, rows) {
            var rowHeight = context.canvas.height / rows;
            for (var i = 0; i < rows; i++) {
                context.rect(0, i * rowHeight, context.canvas.width, rowHeight);
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
