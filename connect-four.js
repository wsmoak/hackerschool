(function() {
    // see http://benalman.com/news/2010/11/immediately-invoked-function-expression/
    var Game = function(canvasId) {
            var rows = 6;
            var cols = 7;
            var board = new Array(rows * cols);
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
                var x = event.pageX
                var y = event.pageY
                col = Math.ceil(x / (gameSize.x / cols));
                console.log("Clicked! " + event.pageX + " " + event.pageY + " in Column " + col);
                drawCircle(context, col, red);
                red = !red
            });


        };

    var drawGrid = function(context, gameSize, cols) {
            var width = gameSize.x / cols;
            for (var i = 0; i < cols; i++) {
                console.log("Drawing a box!");
                context.rect(i * width, 0, (i + 1) * width, gameSize.y);
                context.strokeStyle = 'yellow';
                context.lineWidth = '3';
                context.stroke();
            }
        };

    var drawCircle = function(context, col, red) {
            //see http://www.html5canvastutorials.com/tutorials/html5-canvas-circles/
            //see http://www.tauday.com/tau-manifesto
            var TAU = 2 * Math.PI;
            context.beginPath();
            //see http://www.w3schools.com/tags/canvas_arc.asp
            context.arc(col * 45 - (45 / 2), 150, 10, 0, TAU);
            context.fillStyle = red ? 'red' : 'black';
            context.fill();
        };

    window.onload = function() {
        new Game("screen");
    };

})();
