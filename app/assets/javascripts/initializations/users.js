
function user_vue_observer(){
    var user_vue = new Vue({
        el: '#login',
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



