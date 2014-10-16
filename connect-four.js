(function() {
    // see http://benalman.com/news/2010/11/immediately-invoked-function-expression/
    var Game = function(canvasId) {
            var canvas = document.getElementById(canvasId);
            var screen = canvas.getContext('2d');
            var gameSize = {
                x: canvas.width,
                y: canvas.height
            };
        };

    window.onload = function() {
        new Game("screen");
    };

})();
