(function() {
    // see http://benalman.com/news/2010/11/immediately-invoked-function-expression/
    var Game = function(canvasId) {
            // see http://html5doctor.com/an-introduction-to-the-canvas-2d-api/
            var canvas = document.getElementById(canvasId);
            var gameSize = {
                x: canvas.width,
                y: canvas.height
            };
            var context = canvas.getContext('2d');

            //see http://www.html5canvastutorials.com/tutorials/html5-canvas-circles/
            context.beginPath();
            context.arc(150, 150, 10, 2 * Math.PI, false);
            context.fillStyle = 'red';
            context.fill();
        };

    window.onload = function() {
        new Game("screen");
    };

})();
