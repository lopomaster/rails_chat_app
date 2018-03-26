
function message_vue_observer(){
    var message_vue = new Vue({
        el: '#message_form',
        data: {
            body: ''
        },
        methods: {
            isFormValid: function () {
                return this.body != '' && this.body.length <= 1000 && this.body.length > 1 ;
            }
        }
    });
}

