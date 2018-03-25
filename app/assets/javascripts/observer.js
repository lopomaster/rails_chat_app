// Observers

//= require_directory ./initializations

//In here is where the different observers functions are added to execute them.
function observers () {
    user_vue_observer();
}

// ready is a function that starts the observers function...
var ready = function() {
    observers();
};

$(window).on('load', function() { ready(); });
