// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

//= require bootstrap-sprockets
//= require moment

$(document).ready(function(){
    var $then = $('.datetime');
    $.each($then, function(index, value) {
        $(this).text(moment(moment.utc($(this).text()).format()).format('YYYY-MM-DD HH:mm:ss'));
    });

    var $then = $('.datetime-title[title]');
    $.each($then, function(index, value) {
        $(this).attr('title', moment(moment.utc($(this).attr('title')).format()).format('YYYY-MM-DD HH:mm:ss'));
    });

    var $users = $('#all_users_user_ids');
    var $owners = $('#project_user_ids');
    if ($users.length && $owners.length) {
        $users.click(function (e) {
            var selectedUsers = $('#all_users_user_ids option:selected');
            var selectedOwners = $('#project_user_ids');
            if (selectedUsers.length == 1) {
                oldUser = selectedUsers.val();
            }
            selectedUsers.each(function () {
                if (selectedUsers.length > 1 && oldUser == $(this).val()) {
                    return true;
                }

                var user = $(this),
                    addNewUser = true;
                $('#project_user_ids option').each(function () {
                    if ($(this).text() == user.text() && $(this).val() == user.val())
                        addNewUser = false;
                });
                if (addNewUser) {
                    selectedOwners.append($('<option>', {
                        value: $(this).val(),
                        text: $(this).text()
                    }));
                }
            });
        });

        $owners.click(function (e) {
            var selectedOwners = $('#project_user_ids option:selected');
            selectedOwners.each(function () {
                if ($owners.find('option').length > 1) {
                    $owners[0].remove($owners[0].selectedIndex)
                }
            });
        });
    }

    $('.edit_project').submit(function() {
        $('#project_user_ids option').prop('selected', true);

        return true; // return false to cancel form action
    });

});