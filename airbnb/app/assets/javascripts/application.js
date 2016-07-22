// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(window).ready(function() {
    $('.get-call').click(function() {
        var isPopUp = this.getAttribute('data-popup');
        $.ajax({
            url: this.getAttribute('data-url'),
            type: "GET",
            success: function(data) {
                if (isPopUp == "true") {
                    $('#popUpDiv').empty().append(data).css('top', (650 - $('#popUpDiv').innerHeight()) / 2);
                    popup('popUpDiv');
                } else {
                    window.location = "/";
                }
            }
        });
        return false;
    });
});

function loginSubmitForm(element) {
    if(validateLoginForm()) {
        $.ajax({
            url: element.getAttribute('data-action'),
            type: 'POST',
            data: $(element).parents('form').serialize(),
            success: function(data, status) {
                if (data.status == 'success') {
                    window.location = "/dashboard";
                } else if (data.status == 'error') {
                    $('#error-div').html(data.error_message);
                    $('#error-div').removeClass('display-none').addClass('display-block');
                }
            }
        });    
    }
    return false;
}

function signupFormSubmit(element) {
    if(validateSignUpForm()) {
        $.ajax({
            url: element.getAttribute('data-action'),
            type: 'POST',
            data: $(element).parents('form').serialize(),
            success: function(data, status) {
                if (data.status == 'success') {
                    window.location = "/dashboard";
                } else if (data.status == 'error') {
                    $('#error-div').html(data.error_message);
                    $('#error-div').removeClass('display-none').addClass('display-block');
                }
            }
        });
    }
    return false;
}

function addSpace(element) {
    debugger;
    if(validateAddSpaceForm()) {
        $.ajax({
            url: element.getAttribute('data-action'),
            type: 'POST',
            data: $(element).parents('form').serialize(),
            success: function(data, status) {
                if(data.status == 'success') {
                    $.ajax({
                        url: '/spaces',
                        type: 'GET',
                        success: function(data, status) {
                            $('#dashboard-body-content').empty().html(data);
                            Holder.run();
                        }
                    });    
                } else if(data.status == 'error') {
                    $('.err_message .message').empty().append(data.error_message)
                    $('.err_message').removeClass('hide').addClass('show');
                }
                   
            }
        });
    }
    return false;
}


function toggle(div_id) {
    var el = document.getElementById(div_id);
    if (el.style.display == 'none') { el.style.display = 'block'; } else { el.style.display = 'none'; }
}

function popup(windowname) {
    toggle('blanket');
    toggle(windowname);
}

function clickEventOnMenuItem() {
    $('.dashboard-menu-panel a').click(function() {
        $('.dashboard-menu-panel a').removeClass('menu-click');
        $(this).addClass('menu-click');
        $.ajax({
            url: this.getAttribute('data-link'),
            type: 'GET',
            success: function(data, status) {
                $('#dashboard-body-content').html(data);
                Holder.run();
            }
        });
        return false;
    });
    $('.dashboard-menu-panel a').first().trigger('click');
}

function initListingPage() {
    $('#add-space-icon').click(function() {
        addFormContent();
        toggleRightAndLeftPanel();
        $(".right-panel #form-div").toggleClass('transform-form-div');
        $("#form-div .form-component").toggleClass('transform-form-component');
        $(this).hide(100);
    });
    
    $('.left-panel').resize(function() {
        if ($(this).width() < 900) {
            $('.list-as-row .space-wrapper').removeClass('col-lg-6');
        } else {
            $('.list-as-row .space-wrapper').addClass('col-lg-6');
        }
    });
    
    Holder.addTheme("my-theme", { bg: "#ffadad", fg: "white" }).run();
}

function toggleRightAndLeftPanel() {
    $(".body-content .right-panel").toggleClass('transform-right-panel');
    $(".body-content .left-panel").toggleClass('transform-left-panel');
}

function addAutoCompleteForCity(txtBoxElem, hiddenElem) {
    txtBoxElem.autocomplete({
        source: function(request, response) {
            jQuery.getJSON(
                "./query_cities?q=" + request.term,
                function(data) {
                    response(data);
                }
            );
        },
        minLength: 1,
        select: function(event, ui) {
            hiddenElem.val(ui.item.id);
        },
        change: function(event, ui) {
            if (ui.item === null) {
                $(this).val('');
                $('#field_id').val('');
            }
        }
    });
}

function removeErrClass(elem){
    $(elem).removeClass('error-class');
}

function initSearchBlock() {
    var arr = ['.city-txt-box', 'input[name="search\[from\]"]', 'input[name="search\[to\]"]', '#guests-count'];
    $("input[name='search\[guests_count\]']").TouchSpin();
    addAutoCompleteForCity($('input[name="city-name-txt-box"]'), $('#city-name-hidden-elem'));
    $(".datepicker").datepicker( { 
        minDate: 0
    });
    $('.input-group-addon').click(function() {
        $(this).siblings().trigger('focus');
    });
    
    for(eachElem of arr){
        $(eachElem).on("focus", function() {
            $(this).removeClass('error-class');
        });
    }
}

function searchResponseRenderingCallbackWithoutLogin(data, from, to) {
    var spaceElementWrapper = $("#spaces-list").empty();
    if (data.spaces.length > 0) {
        for (space of data.spaces) {
            spaceElementWrapper.append($('<div>').addClass('col-xs-12 col-md-12 col-lg-6 space-wrapper').append($('<div>')
                .addClass('space-border').append($('<div>').addClass('space').append($('<div>')
                        .addClass('image-wrapper col-xs-6 col-md-6 no-padding pull-left').append($('<img>')
                            .attr('src', "holder.js/100px200?theme=my-theme&text=Yet to upload... ")))
                    .append($('<div>').addClass('col-xs-6 col-md-6 no-padding pull-left')
                        .append($('<div>').addClass('profile-pic-wrapper pull-left').append($('<img>')
                            .attr('src', '').addClass('profile-pic'))).append($('<form>').attr('method', 'POST')
                            .attr('action', '/dashboard').append($('<div>')
                                .addClass('space-description pull-left').append($('<div>')
                                    .addClass('room-type').append(space.roomType)).append($('<div>')
                                    .append(space.city)).append($('<div>')
                                    .append(space.noOfBeds + ' beds available.'))
                                .append($('<div>').append('Costs ' + space.costPerDay + '&#x20b9; per day.'))
                                .append($('<input>').attr('name', 'reserve[id]').attr('type', 'hidden').val(space.id))
                                .append($('<input>').attr('name', 'reserve[from]').attr('type', 'hidden').val(from))
                                .append($('<input>').attr('name', 'reserve[from]').attr('type', 'hidden').val(to))))))));
        }
        Holder.run();
    } else {
        $('.info_message').removeClass('hide').addClass('show');
    }
    
}

function searchResponseRenderingCallbackOnUserSession(data, from, to, guestsCount) {
    var spaceElementWrapper = $("#spaces-list").empty();
    if($(".body-content .right-panel").hasClass("transform-right-panel")) {
        $(".body-content .right-panel").removeClass('transform-right-panel'); 
        $(".body-content .left-panel").removeClass('transform-left-panel');
    }
    if (data.spaces.length > 0) {
        for (space of data.spaces) {
            spaceElementWrapper.append($('<div>').addClass('col-xs-12 col-md-12 col-lg-6 space-wrapper').append($('<div>')
                .addClass('space-border').append($('<div>').addClass('space').append($('<div>')
                        .addClass('image-wrapper col-xs-6 col-md-6 no-padding pull-left').append($('<img>')
                            .attr('src', "holder.js/100px200?theme=my-theme&text=Yet to upload... ")))
                    .append($('<div>').addClass('col-xs-6 col-md-6 no-padding pull-left')
                        .append($('<div>').addClass('profile-pic-wrapper pull-left').append($('<img>')
                            .attr('src', '').addClass('profile-pic'))).append($('<div>')
                                .addClass('space-description pull-left').append($('<div>')
                                    .addClass('room-type').append(space.roomType)).append($('<div>')
                                    .append(space.city)).append($('<div>')
                                    .append(space.noOfBeds + ' beds available.'))
                                .append($('<div>').append('Costs ' + space.costPerDay + '&#x20b9; per day.'))
                                .append($('<input>').attr('name', 'space-json').attr('type', 'hidden').val(JSON.stringify(space)))
                                .append($('<input>').attr('name', 'from').attr('type', 'hidden').val(from))
                                .append($('<input>').attr('name', 'to').attr('type', 'hidden').val(to))
                                .append($('<input>').attr('name', 'guests-count').attr('type', 'hidden').val(guestsCount))
                                .append($('<button>').attr('type', 'button').addClass('btn btn-primary').attr('onclick', 'expandSpaceDetailsInRightPanel(this)').append('Reserve')))))));
        }
        Holder.run();
    } else {
        $('.info_message').removeClass('hide').addClass('show');
    }
}


function listSpaces(elem, searchResponseRenderingCallback) {
    var message = ['.info_message', '.success_message'];
    $.each(message, function(index, val){
        $(val).removeClass('show').addClass('hide');    
    })
    if(validateSearchForm()) {
        var from = $("input[name=\"search\[from\]\"]").val();
        var to = $("input[name=\"search\[to\]\"]").val();
        var guestsCount = $("input[name=\"search\[guests_count\]\"]").val();
        $.ajax({
            url: '/spaces/search.json',
            data: $(elem).parents('form').serialize(),
            type: "GET",
            success: function(data) {
                searchResponseRenderingCallback(data, from, to, guestsCount);
            }
        });
    }
}

function expandSpaceDetailsInRightPanel(elem) {
    var from = $(elem).siblings('input[type="hidden"][name = "from"]').val();
    var to = $(elem).siblings('input[type="hidden"][name = "to"]').val();
    var guestsCount = $(elem).siblings('input[type="hidden"][name = "guests-count"]').val();
    var space = JSON.parse($(elem).siblings('input[type="hidden"][name = "space-json"]').val());
    $(".body-content .right-panel").empty().toggleClass('transform-right-panel');
    $(".body-content .left-panel").toggleClass('transform-left-panel');
    var dateArray = from.split('/');
    var fromDate = new Date(dateArray[2]+'-'+dateArray[0]+'-'+dateArray[1]);
    dateArray = to.split('/');
    var toDate = new Date(dateArray[2]+'-'+dateArray[0]+'-'+dateArray[1]);
    var price, costPerDay;
    if(space.roomType == 'Shared room') {
        costPerDay = ((space.costPerDay/space.maxGuestsCount)*guestsCount);
        price = (Math.round((toDate-fromDate)/(1000*60*60*24))+1) * costPerDay;
        
    } else {
        costPerDay = space.costPerDay;
        price = (Math.round((toDate-fromDate)/(1000*60*60*24))+1) * costPerDay;
    }


    $(".body-content .right-panel")
        .append($('<img>').attr('src', 'holder.js/100px300?theme=my-theme&text=Yet to upload... '))
        .append($('<div class="room-type">').append(space.roomType))
        .append($('<div>').append('Address : '+ space.address))
        .append($('<div>').append('Location : '+ space.city))
        .append($('<div>').append('Type of home : '+ space.homeType))
        .append($('<div>').append('Per day costs : '+ costPerDay))
        .append($('<div>').append('Guests : '+ guestsCount))
        .append($('<div>').append('Pricing : '+ price))
        .append($('<div>').addClass('button-div').append($('<button>').attr('type', 'submit')
                            .attr('onclick', 'return reserveSpace("'+from+'","'+to+'","'+space.id+'","'+guestsCount+'")').addClass('btn btn-primary pull-right').append('Confirm')));
    Holder.run();
}

function reserveSpace(from, to, spaceId, guestsCount) {
    $.ajax({
        url: '/reservations',
        type: 'POST',
        data: 'reserve[from]='+from+'&reserve[to]='+to+'&reserve[space_id]='+spaceId+'&reserve[guests_count]='+guestsCount,
        success: function(data, status) {
            if(data.status == 'success') {
                $('.city-txt-box').val('');
                $('#city-name-hidden-elem').val('');
                $('input[name="search\[from\]"]').val('');
                $('input[name="search\[to\]"]').val('');
                $('#guests-count').val('1');
                $('.left-panel').empty();
                $('.right-panel').empty();
                $(".body-content .right-panel").toggleClass('transform-right-panel');
                $(".body-content .left-panel").toggleClass('transform-left-panel');
                $('.success_message').removeClass('hide').addClass('show');   
            } else if(data.status == 'error')  {
                $('.err_message .message').empty().append(data.error_message)
                $('.err_message').removeClass('hide').addClass('show');
            }
        }
    });
}


(function(obj){
    obj.emptyCheck = function(elem) { return(elem.val() == undefined || elem.val().trim() == ''); };
    obj.emptyAndLessthenCheck = function(elem) { return(elem.val() == undefined || elem.val().trim() == '' || elem.val() < 1); };
    obj.emptyAndDateCheck = function(elem) { return(elem.val() == undefined || elem.val().trim() == '' || (new Date(elem.val()) < new Date($('input[name="search\[from\]"]').val()))); };
    obj.notANumCheck = function(elem) { return(isNaN(elem.val()) || elem.val().trim() == ''); };

    obj.validate = function(validateObjArr) {
        var response = true;
        for(eachElem of validateObjArr) {
            if(eachElem.validatorFunction(elem = $(eachElem.elementSelector))) {
                elem.addClass('error-class');
                response = false;
            } else {
                elem.removeClass('error-class');
            }
        }
        return response;
    };
})(this.validation = { });

function validateAddSpaceForm() {
    var validateObjArr = [ {
        elementSelector : 'input[name="city"]',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : 'input[name="space\[home_type\]"]:checked',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : 'input[name="space\[room_type\]"]:checked',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : 'input[name="space\[address\]"]',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : 'input[name="space\[cost_per_day\]"]',
        validatorFunction : validation.notANumCheck
    } ];
    return validation.validate(validateObjArr);
}

function validateSearchForm() {
    var validateObjArr = [ {
        elementSelector : '.city-txt-box',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : 'input[name="search\[from\]"]',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : 'input[name="search\[to\]"]',
        validatorFunction : validation.emptyAndDateCheck
    }, {
        elementSelector : '#guests-count',
        validatorFunction : validation.emptyAndLessthenCheck
    } ];
    return validation.validate(validateObjArr);
}

function validateSignUpForm() {
    var validateObjArr = [ {
        elementSelector : '#firstname',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : '#lastname',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : '#password',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : '#email',
        validatorFunction : validation.emptyCheck
    } ];
    return validation.validate(validateObjArr);
}

function validateLoginForm() {
    var validateObjArr = [ {
        elementSelector : '#login-email',
        validatorFunction : validation.emptyCheck
    }, {
        elementSelector : '#login-password',
        validatorFunction : validation.emptyCheck
    }];
    return validation.validate(validateObjArr);
}

function hideSuccessMessage() {
    $('.success_message').removeClass('show').addClass('hide');
    return false;
}

function hideInfoMessage() {
    $('.info_message').removeClass('show').addClass('hide');
    return false;   
}


function hideErrMessage() {
    $('.err_message').removeClass('show').addClass('hide');
    return false;   
}

function addFormContent() {
    $('.right-panel').html('<div id="form-div"> <i id="close-icon" class="ionicons ion-android-close"></i> <div class="alert alert-danger err_message hide"> <a href="#" class="close" data-dismiss="alert" onclick="return hideErrMessage()" aria-label="close">&times;</a> <div class="message"></div> </div> <form> <fieldset> <label class="form-component" for="city">City</label> <input type="hidden" name="space[city_id]" id="space[city_id]" /> <input class="form-control" name="city" type="text" placeholder="City" onfocus="removeErrClass(this)"> <label for="home-type" class="form-component">Home type</label> <div> <label> <input type="radio" name="space[home_type]" value="1" /> Apartment </label> <label> <input type="radio" name="space[home_type]" value="2" /> House </label> <label> <input type="radio" name="space[home_type]" value="3" /> Bed & Breakfast </label> </div> <label for="room-type" class="form-component">Room type</label> <div> <label> <input type="radio" name="space[room_type]" value="1" /> Entire home </label> <label> <input type="radio" name="space[room_type]" value="2" /> Shared home </label> <label> <input type="radio" name="space[room_type]" value="3" /> Private room </label> </div> <label class="form-component" for="address">Address</label> <input name="space[address]" onfocus="removeErrClass(this)" type="text" placeholder="no., street address, location."> <label class="form-component" for="guests-count">How many guest can stay?</label> <div> <select id="guests-count" name="space[max_guests_count]"></select> </div> <label class="form-component" for="beds-count">No of beds.</label> <div> <select id="beds-count" name="space[beds_count]"></select> </div> <label class="form-component" for="bath-rooms-count">How many bathrooms?</label> <div> <select id="bath-rooms-count" name="space[bathrooms_count]"></select> </div> <label class="form-component" for="space[cost_per_day]">Pricing per day</label> <input name="space[cost_per_day]" type="text" placeholder="in rupees." onfocus="removeErrClass(this)"> <br> <div class="submit-form-btn-wrapper"> <input data-action="/spaces" type="submit" class="btn btn-primary" value="Submit" onclick="return addSpace(this)" /> </div> </fieldset> </form></div>');
    $('#close-icon').click(function() {
        toggleRightAndLeftPanel();
        $(".right-panel #form-div").toggleClass('transform-form-div');
        $("#form-div .form-component").toggleClass('transform-form-component');
        $('#add-space-icon').show(200);
    });
    for (i = 1; i < 16; i++) {
        $('#guests-count').append($('<option>').attr('value', i).html(i));
        if (i < 11) {
            $('#beds-count').append($('<option>').attr('value', i).html(i));
            $('#bath-rooms-count').append($('<option>').attr('value', i).html(i));
        }
    }
    addAutoCompleteForCity($('input[name="city"]'), $("input[name=\"space[city_id]\"]"));
}

function showReservationsOnThisSpace(spaceId){
  $('.right-panel').empty();
  $(".body-content .right-panel").addClass('transform-right-panel');
  $(".body-content .left-panel").addClass('transform-left-panel');
  $('#add-space-icon').hide(100);
  $.ajax({
    url: '/spaces/'+spaceId+'/reservations.json',
    type: 'GET',
    success: function(data, status) {
      renderReservationsOnRightPanel(data.reservations);
      addCloseIconClickEvent();
    },
    error: function(data, status) {
      $('.right-panel').append($('<div>').addClass('close-icon-div').append($('<i>').attr('id', 'close-icon').addClass('ionicons ion-android-close close-icon'))).append($('<div>').addClass('list-space-reservations-div').append('Oops.. Currently this service is not available, please try after sometimes.'));
      addCloseIconClickEvent();
    }
  });
  return false;
}

function addCloseIconClickEvent() {
  $('#close-icon').click(function() {
    toggleRightAndLeftPanel();
    $(".right-panel #form-div").toggleClass('transform-form-div');
    $("#form-div .form-component").toggleClass('transform-form-component');
    $('#add-space-icon').show(200);
    $(this).hide(200);
  });
}

function renderReservationsOnRightPanel(reservations){
  var listSpaceReservationsDiv = $('<div>').addClass('list-space-reservations-div');
  $('.right-panel').append($('<div>').addClass('close-icon-div').append($('<i>').attr('id', 'close-icon').addClass('ionicons ion-android-close close-icon'))).append(listSpaceReservationsDiv);
  if(reservations.length > 0) {
    var listSpaceReservationsUl = $('<ul>').addClass('list-group'); 
    listSpaceReservationsDiv.append(listSpaceReservationsUl);
    for(reservation of reservations) {
      listSpaceReservationsUl.append($('<li>').addClass('list-group-item').append($('<div>').append(reservation.from +" to "+ reservation.to)).append($('<div>').append("Guests : "+reservation.guestsCount).addClass("guests-count")).append($('<div>').append("Reserved by "+reservation.user.firstname+" "+reservation.user.lastname)));
    }
  } else {
    listSpaceReservationsDiv.append('No reservations to list on upcoming days.');
  }
}
