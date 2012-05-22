var ws;
$(document).ready(function(){
    ws = new WebSocket('ws://localhost:10126');
    ws.onmessage = function(ev){
        var data = $.parseJSON(ev.data);
        for(key in data){
            var el = $('#' + key);
            var old_val = parseInt(el.text());
            $('#' + key).text(data[key]);
            if(data[key] != old_val){
                el.css({backgroundColor:'yellow'});
            }
           setTimeout(function(){
                    $('p').css({backgroundColor:'transparent'});
            },500)
        }
    }
})

