
function user_vue_observer(){
    var user_vue = new Vue({
        el: '#user_form',
        data: {
            name: ''
        },
        methods: {
            isFormValid: function () {
                return this.name != '';
            }
        }
    });
}



