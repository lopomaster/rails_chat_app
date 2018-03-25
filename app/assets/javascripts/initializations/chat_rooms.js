
function chat_room_vue_observer(){
    var chat_room_vue = new Vue({
        el: '#chat_room_form',
        data: {
            title: ''
        },
        methods: {
            isFormValid: function () {
                return this.title != '';
            }
        }
    });
}


