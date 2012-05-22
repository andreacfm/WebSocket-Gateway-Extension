var simple_chat = {};

simple_chat.server_url = function(){
    return $('#server_url').val();
}

simple_chat.nickname = function(){
    return $('#nickname').val();
}

simple_chat.validate_connection = function(){

    if(simple_chat.server_url().length == 0 || simple_chat.nickname().length == 0){
        alert('Both server url and nickname must be provided to start a chat connection');
    }
    return true;
}

simple_chat.connect = function(){
    if(!simple_chat.validate_connection()){
        return;
    }
    var server_url = simple_chat.server_url();
    var nickname = simple_chat.nickname();

    //enable
    var ids_to_enable = ['disconnect','message_box','send'];
    for(var i = 0; i < ids_to_enable.length; i++){
       $('#' + ids_to_enable[i]).attr('disabled',false);
    }

    //disable
    var ids_to_disable = ['connect','server_url','nickname'];
    for(var i = 0; i < ids_to_disable.length; i++){
       $('#' + ids_to_disable[i]).attr('disabled','disabled');
    }

    simple_chat.new_websocket();

}

simple_chat.disconnect = function(){
    //enable
    var ids_to_enable = ['connect','server_url','nickname'];
    for(var i = 0; i < ids_to_enable.length; i++){
       $('#' + ids_to_enable[i]).attr('disabled','');
    }

    //disable
    var ids_to_disable = ['disconnect','message_box','send'];
    for(var i = 0; i < ids_to_disable.length; i++){
       $('#' + ids_to_disable[i]).attr('disabled','disabled');
    }
    simple_chat.ws.close();
}

simple_chat.new_websocket = function(){

    var server_url = simple_chat.server_url();
    simple_chat.ws = new WebSocket(server_url);

    simple_chat.ws.onopen = function(){
        var text = 'Joined the chat';
        simple_chat.log_message(simple_chat.format_message('You',text));
        simple_chat.ws.send(simple_chat.format_message(simple_chat.nickname(),text));
    }

    simple_chat.ws.onmessage = function(message){
        simple_chat.log_message(message.data);
    }

    simple_chat.ws.onclose =  function(){
        var text = 'Left the chat';
        simple_chat.log_message(simple_chat.format_message('You',text));
        simple_chat.ws.send(simple_chat.format_message(simple_chat.nickname(),text));
    }

}

simple_chat.send_message = function(text){
    simple_chat.log_message(simple_chat.format_message('You',text));
    simple_chat.ws.send(simple_chat.format_message(simple_chat.nickname(),text));
}

simple_chat.log_message = function(message){
    console.log(message);
    $panel = $('#chat_panel');
    var content = $panel.html() + message;
    $panel.html(content);
}

simple_chat.format_message = function(nickname,text){
    return '<p><span class="nickname">' + nickname + '</span> : <span class="text">' + text + '</span></p>';
}


$(document).ready(function(){

    $('#connect').click(function(){
        simple_chat.connect();
    })

    $('#disconnect').click(function(){
        simple_chat.disconnect();
    })

    $('#send').click(function(){
        simple_chat.send_message($('#message_box').val());
        $('#message_box').val(' ');
    })

})