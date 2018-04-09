function users_table_vue_observer() {

    var users = new Vue({
        el: '#users',
        data: {
            users: [ ],
            user: {
                name: '',
                _id: '',
                messages_counter: 0
            },
            errors: {}
        },
        methods:{
            showLink: function(user){
                return 'users/' + user._id.$oid
            },
            editLink: function(user){
                return 'users/' + user._id.$oid + '/edit'
            },
            deleteLink: function(user){
                return 'users/' + user._id.$oid
            }
        },
        mounted: function () {
            var that;
            that = this;
            $.ajax({
                url: '/users.json',
                success: function(res) {
                    that.users = res;
                }
            });
        }
    });

}

