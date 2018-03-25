App.messages = App.cable.subscriptions.create("MessagesChannel", {
        collection() { return $("[data-channel='chat_rooms']"); },

        connected() {
            return setTimeout(() => {
                    this.followMessages();
                    return this.installPageChangeCallback();
                }
                , 1000);
        },

        received(data) {
            json_result = $.parseJSON(data.html_results);
            $.each(json_result, function(k, v) {
                $(k).append(v);
            });
        },

        followMessages() {
            let chatroom_Id;

            if ((chatroom_Id = this.collection().data('chat-room-id'))) {
                return this.perform('follow', {chat_room_id: chatroom_Id});
            } else {
                return this.perform('unfollow');
            }
        },

    installPageChangeCallback() {
            if (!this.installedPageChangeCallback) {
                this.installedPageChangeCallback = true;
                return $(document).on('turbolinks:load', () => App.messages.followMessages());
            }
        }
    }
);
