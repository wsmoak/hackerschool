// Wendy Smoak | wsmoak@gmail.com | http:/wsmoak.net | October 2014
// Connect Four game
(function() {
    // see http://benalman.com/news/2010/11/immediately-invoked-function-expression/

    var ROWS = 6;
    var COLS = 7;

    var Game = function(canvasId) {
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
                            checkBoard(context, x, y, red);
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

        var findMatch = function(context, x, y, rowDirection, colDirection) {
		    var count = 0;
		    var lastMove = context.getImageData(x, y, 1, 1);
    	  //console.log("Last Move is " + x + " " + y + " is " + lastMove.data[0] + " " + lastMove.data[1] + " " + lastMove.data[2] + " " + lastMove.data[3]);
			xpos = x;
			ypos = y;
		    // look to the left and count matches
			while ( xpos > 0 && xpos < context.canvas.width && ypos > 0 && ypos < context.canvas.height) {
                xpos += colDirection;
				ypos += rowDirection;
		        var imageData = context.getImageData(xpos, ypos, 1, 1);
                //console.log("Image Data for " + xpos + " " + ypos + " is " + imageData.data[0] + " " + imageData.data[1] + " " + imageData.data[2] + " " + imageData.data[3]);
		        if (imageData.data[3] > 0 && //not transparent
		           lastMove.data[0] === imageData.data[0] &&
		           lastMove.data[1] === imageData.data[1] &&  //same color
		           lastMove.data[2] === imageData.data[2] ) {
			       count += 1;
		        } else {
			       break;
		        }
		    } // end while
		console.log ( "returning " + count );
			return count;
        };

	    var checkBoard = function(context, x, y, red) {
		    var columnWidth = Math.floor(context.canvas.width / COLS);
		    var rowHeight = Math.floor(context.canvas.height / ROWS);

			var LEFT = -columnWidth;
			var RIGHT = columnWidth;
			var UP = -rowHeight;
			var DOWN = rowHeight;
			var SAME = 0;

			rowWin = findMatch(context,x,y,SAME,LEFT) + findMatch(context,x,y,SAME,RIGHT);
		    console.log ( "Counted left and right matches: " + rowWin );

		    colWin = findMatch(context,x,y,DOWN,SAME);
		    console.log ( "Counted up and down matches: " + colWin );

			backDiagWin = findMatch(context,x,y,UP,LEFT) + findMatch(context,x,y,DOWN,RIGHT);
		    console.log ( "Counted back diagonal matches: " + backDiagWin );

			fwdDiagWin = findMatch(context,x,y,UP,RIGHT) + findMatch(context,x,y,DOWN,LEFT);
		    console.log ( "Counted fwd diagonal matches: " + fwdDiagWin );


        };

    window.onload = function() {
        new Game("screen");
    };

})();
