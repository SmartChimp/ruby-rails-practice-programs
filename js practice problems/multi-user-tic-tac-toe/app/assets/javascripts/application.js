match = { };
CUBE = {
    "size": 3,
    "verifyMethods": [
        verifyDiagonals,
        verifyRows,
        verifyColumns
    ]
};
Object.freeze(CUBE);

function coinPicked(element) {
	if(match.current_player == 'player1') {
		match.player1_coin = element.getAttribute('data-coin');
		match.player2_coin = (element.getAttribute('data-coin') == 'x')? 'o': 'x';
        updateCoin();
		renderPlayersCoinWindow();
	}
}

function updateCoin() {
    $.ajax({
        url: "/update_coin",
        type: 'POST',
        data: 'id='+match.id+'&player1_coin='+match.player1_coin+'&player2_coin='+match.player2_coin,
        success: function(data) { 
        }
    });
}

function renderPlayersCoinWindow() {
    if(match.player1_coin != '') {
        $('#coin-div').empty();
        $('#coin-div').append($('<div>').addClass('player-name-div').text('Player 1')); 
        $('#coin-div').append($('<div>').addClass('player-name-div').text('Player 2'));
        $('#coin-div').append($('<div>').addClass(match.player1_coin + '-box coin-pic-div first-coin-pic-div').attr('id', 'player-1-coin'));
        $('#coin-div').append($('<div>').addClass(match.player2_coin + '-box coin-pic-div second-coin-pic-div').attr('id', 'player-2-coin'));    
    }
}

function markMe(clickedBlockElement) {
    if (!$(clickedBlockElement).hasClass('o-box') && !$(clickedBlockElement).hasClass('x-box') && 
    		match.status != 'OVER' && getCookie("who_am_i") === match.current_player && match.player1_coin != '') {

    	if (match.current_player == 'player1') {
    		$(clickedBlockElement).addClass(match.player1_coin+'-box');
    		clickedBlockElement.setAttribute('data-block-value', match.player1_coin);
    	} else if (match.current_player == 'player2') {
    		$(clickedBlockElement).addClass(match.player2_coin+'-box');
    		clickedBlockElement.setAttribute('data-block-value', match.player2_coin);
    	}

        var blockedDataArray = getAllBlockedData();
        for (verifyMethod of CUBE.verifyMethods) {
            if (matchCompleted(verifyMethod(blockedDataArray))) {
                match.status = 'OVER';
            }
        }
        if (match.status != 'OVER' && blockedDataArray.filter(function(val) {
                return (val === '') ? false: true; }).length === 9) {
            match.status = 'OVER';
            $('#result-div').text('Match is tie.');
        }
        updateBoardState(blockedDataArray);
        match.current_player = (match.current_player === 'player1') ? 'player2' : 'player1';
    }
}

function updateBoardState(boardState) {
	$.ajax({
		url: "/update_board_state",
		type: 'POST',
		data: 'id='+match.id+'&board_state='+boardState+'&player='+match.current_player+'&status='+match.status+'&winner='+match.winner,
		success: function(data) { 
		}
	});
}

function matchCompleted(result) {
    if (result.isMatchCompleted) {
        match.status = 'OVER';
        var text;
        if(match.player1_coin === result.winner) {
            text = 'Player1 is the Winner in this match.';
            match.winner = 'Player1';
        } else {
            text = 'Player2 is the Winner in this match.';
            match.winner = 'Player2';
        }
        $('#result-div').text(text);
    }
    return result.isMatchCompleted;
}

function renderMessageOnMatchOver() {
    if(match.status == 'OVER') {
        if(match.winner != '') {
            $('#result-div').text(match.winner + ' is the Winner in this match.');
        } else {
            $('#result-div').text('Match is tie.');
        }
    }
}

function verifyRows(array) {
    var rowIndex = 0,
        result = { isMatchCompleted: false, winner: '' };
    for (var i = 0; i < CUBE.size; i++) {
        var matched = true,
            rowNo = i * 3;
        if (array[rowNo] != undefined && array[rowNo] != '') {
            for (var j = rowNo; j < (CUBE.size * (i + 1)); j++) {
                if (array[rowNo] != array[j]) {
                    matched = false;
                    break;
                }
            }
            if (matched) {
                result.isMatchCompleted = true;
                result.winner = array[rowNo];
                break;
            }
        }
    }
    return result;
}

function verifyColumns(array) {
    var columnIndex = 0,
        result = { isMatchCompleted: false, winner: '' };
    for (var i = 0; i < CUBE.size; i++) {
        var matched = true;
        if (array[i] != undefined && array[i] != '') {
            for (var j = i; j < (CUBE.size * CUBE.size); j += CUBE.size) {
                if (array[i] != array[j]) {
                    matched = false;
                    break;
                }
            }
            if (matched) {
                result.isMatchCompleted = true;
                result.winner = array[i];
                break;
            }
        }
    }
    return result;
}


function verifyDiagonals(array) {
    var diagonalElementsIndexOne = 0,
        diagonalElementsIndexTwo = (CUBE.size - 1),
        count = 0,
        matched = true,
        result = { isMatchCompleted: false, winner: '' };

    if (array[diagonalElementsIndexOne] != undefined && array[diagonalElementsIndexOne] != '') {
        while (count < CUBE.size) {
            count++;
            if (array[diagonalElementsIndexOne] != array[0]) {
                matched = false;
                break;
            }
            diagonalElementsIndexOne += (CUBE.size + 1);
        }
        if (matched) {
            result.isMatchCompleted = true;
            result.winner = array[0];
        }
    }
    if (array[diagonalElementsIndexTwo] != undefined && array[diagonalElementsIndexTwo] != '') {
        count = 0, matched = true;
        while (count < CUBE.size) {
            count++;
            if (array[diagonalElementsIndexTwo] != array[CUBE.size - 1]) {
                matched = false;
            }
            diagonalElementsIndexTwo += (CUBE.size - 1);
        }
        if (matched) {
            result.isMatchCompleted = true;
            result.winner = array[CUBE.size - 1];
        }
    }
    return result;
}


function getAllBlockedData() {
    var allBoxDivs = $('.box');
    var blockedDataArray = [];
    for (value of allBoxDivs) {
        blockedDataArray[value.getAttribute('data-block-no')] = value.getAttribute('data-block-value');
    }
    return blockedDataArray;
}

function clickNewGame() {
	$('#top-pannel').empty();
	$('#top-pannel').html('<div style="width:25%"> <div class="input-group"> <input id="name" type="text" class="form-control" placeholder="Name"> <span class="input-group-btn"> <button class="btn btn-default" type="button" onclick="validateAndCreateNewGame()">Go!</button> </span> </div></div>');
}

function validateAndCreateNewGame() {
	var name = $('#name').val();
	if(name.trim().length > 0) {
		$('#container').empty();
		executeUrl("name="+name, "/new_game");
	}
}

function validateAndJoin(id) {
	var name = $("#game-"+id+"-name-txt").val();
	if(name.trim().length > 0) {
		$('#container').empty();
		executeUrl("name="+name+"&id="+id, "/join_game");
	}
}

function executeUrl(formData, urlToCall) {
	$.ajax({
			url: urlToCall,
			type: 'POST',
            data: formData,
            success: function(result) {
            	$('#container').html(result);
            }
	});
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length,c.length);
        }
    }
    return "";
}

function updateGameData() {
    $.ajax({
            url: "/game_data?id="+match.id,
            type: 'GET',
            success: function(result) {
                if((result.players.length > match.players.length) || (result.viewers.length > match.viewers.length)) {
                    renderLeftPannel(result);    
                }
                match = result;
                blockGridData(match.block_value);
                renderPlayersCoinWindow();
                renderMessageOnMatchOver();
            }
    });
}

function blockGridData(dataArray) {
    for(var i=0; i<dataArray.length; i++) {
        if(dataArray[i] != '') {
            $('div[data-block-no="'+i+'"]').attr('data-block-value', dataArray[i]);
            $('div[data-block-no="'+i+'"]').addClass(dataArray[i]+'-box');    
        }
    }
}

function renderLeftPannel(data) {
    $('#game-left-pannel').empty();

    $.each(data.players, function( index, value ){
        $('#game-left-pannel').append($('<div>').html('P'+(index+1)+': '+value).addClass('name-div'));
    });
     $.each(data.viewers, function(index, value) {
       $('#game-left-pannel').append($('<div>').html(value).addClass('name-div')); 
    });
}