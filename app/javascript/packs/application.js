// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

$( document ).on('turbolinks:load', function() {
  $('.flash-alert').delay(5000).slideUp(500, function() {
    $(this).alert('close');
  });

  window.addEventListener('resize', loadNextPage);
  window.addEventListener('scroll', loadNextPage);
  window.addEventListener('load', loadNextPage);
});

$(document).on('change', '.signup-email', function(e) {
  e.preventDefault();
  var email = $(this).val();

  if (!validateEmail(email)) {
    $('#emailHelp').removeClass('text-success').addClass('text-danger').html('Email is invalid.');
    return;
  };

  $.ajax({
    method: 'GET',
    url: `/check_email_duplicacy?email=${email}`,
    dataType: 'json',
    success: function (data) {
      $('#emailHelp').removeClass('text-danger').addClass('text-success').html(data.message);
    },
    error: function (data) {
      $('#emailHelp').removeClass('text-success').addClass('text-danger').html(data.responseJSON.message);
    }
  });
});

function validateEmail(email) {
  const re = /([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/;
  return re.test(String(email).toLowerCase());
}

var loadNextPage = function () {
  if ($('#user_posts').height() === undefined || $('#next_link').data('loading')) { return }
  var wBottom = $(window).scrollTop() + $(window).height();
  var elBottom = $('#user_posts').offset().top + $('#user_posts').height();

  if (wBottom > elBottom) {
    if ($('#next_link')[0] !== undefined) {
      $('#next_link')[0].click();
      $('#next_link').data('loading', true);
    }
  }
};
