$(function() {

    window.addEventListener('message', function(event) {

        var item = event.data;

        if(item.type == "newKill") {
            addKill(item.self, item.killer, item.killStreak, item.killType); 
        } else if(item.type == "newDeath"){
            newDeath(item.self);
        }
    })
})

function addKill(self, killer, killStreak, killType) {

    var color = (killStreak < 5) ? 'rgb(18, 172, 90)' :
    (killStreak < 10) ? 'rgb(18, 172, 90)' :
    (killStreak < 15) ? 'rgb(18, 172, 90)' :
    (killStreak < 20) ? 'rgb(18, 172, 90)' :
    (killStreak < 25) ? 'rgb(18, 172, 90)':
    (killStreak >= 50) ? 'rgb(18, 172, 90)' :
    'rgb(18, 172, 90)';

    var borderBottomColor = (killType === 'kill') ? '#0CAF49' : (killType === 'death') ? '#C10008' : 'none';
    $('<div class="killContainer" '+color+';"><span style="color:' +color+ '; filter: drop-shadow(0 0 15px '+color+');"> ' + killStreak + 'x </span><span>' + killer + ' </span> <i class="fa-brands fa-xing" style="color:' +color+ '; filter: drop-shadow(0 0 15px '+color+');"></i> </span><span> ' + self + '</span></div><br class="clear">').appendTo('.kills')
    .css({'margin-right':-$(this).width()+'px'})
    .animate({'margin-right':'0px'}, 'slow')
    .delay(1500)
    .animate({'margin-right':-$(this).width()+'px'}, 'slow')
    .queue(function() { $(this).remove(); });
}

function newDeath(self) {
    $('<div class="killContainer"><span class="killer">' + self + '</span><i class="fa-solid fa-skull-crossbones"></i><span class="killed">' + self + '</span></div><br class="clear">').appendTo('.kills')
    .css({'margin-right':-$(this).width()+'px'})
    .animate({'margin-right':'0px'}, 'slow')
    .delay(1500)
    .animate({'margin-right':-$(this).width()+'px'}, 'slow')
    .queue(function() { $(this).remove(); });
}