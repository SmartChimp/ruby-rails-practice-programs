current_player = 'player1';
match = {
    status: 'Playing',
    players: { 'player1': '', 'player2': '' }
};
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
    $('#coin-div').empty();
    $('#coin-div').append($('<div>').addClass('player-name-div').text('Player 1'));
    $('#coin-div').append($('<div>').addClass('player-name-div').text('Player 2'));

    if (element.getAttribute('data-coin') == 'x') {
        match.players.player1 = 'x', match.players.player2 = 'o';
    } else {
        match.players.player1 = 'o', match.players.player2 = 'x';
    }

    $('#coin-div').append($('<div>').addClass(match.players.player1 + '-box coin-pic-div first-coin-pic-div').attr('id', 'player-1-coin'));
    $('#coin-div').append($('<div>').addClass(match.players.player2 + '-box coin-pic-div second-coin-pic-div').attr('id', 'player-2-coin'));

}


function markMe(clickedBlockElement) {
    if (!$(clickedBlockElement).hasClass('o-box') && !$(clickedBlockElement).hasClass('x-box') && match.status != 'OVER' && match.players.player1 != '') {
        if (match.players[current_player] == 'x') {
            $(clickedBlockElement).addClass('x-box');
            clickedBlockElement.setAttribute('data-block-value', 'x');
        } else if (match.players[current_player] == 'o') {
            $(clickedBlockElement).addClass('o-box');
            clickedBlockElement.setAttribute('data-block-value', 'o');
        }
        var blockedDataArray = getAllBlockedData();
        for (verifyMethod of CUBE.verifyMethods) {
            if (matchCompleted(verifyMethod(blockedDataArray))) return;
        }
        if (blockedDataArray.filter(function(val) {
                return (val === '') ? false: true; }).length === 9) {
            match.status = 'OVER';
            $('#result-div').text('Match is tie.');
            return;
        }
        current_player = (current_player === 'player1') ? 'player2' : 'player1';
    }
}

function matchCompleted(result) {
    if (result.isMatchCompleted) {
        match.status = 'OVER';
        var text = ' is the Winner in this match.';
        if(match.players.player1 === result.winner) {
            text = 'Player1'+text;
        } else {
            text = 'Player2'+text;
        }
        $('#result-div').text(text);
    }
    return result.isMatchCompleted;
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

$(window).load(function() {
    match.status = 'Playing';
    for (var i = 0; i < 9; i++) {
        $('#play-board').append('<div class="col-xs-4 box" data-block-no="' + i + '" data-block-value="" onclick="markMe(this)"></div>');
    }
});