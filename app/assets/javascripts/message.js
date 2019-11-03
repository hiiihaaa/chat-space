$(function(){
  function buildHTML(message){
    var html_image = message.image ? `
      <img src = "${message.image}", class = "lower-message__pict">
      ` : ""
    var html_content = message.content ? `
        <p class="lower-message__content">
          ${message.content}
        </p>
        ` : ""
    var html =`
      <div class="message" data-id=${message.id}>
        <div class="upper-message">
          <div class="upper-message__user-name">
            ${message.user_name}
          </div>
          <div class="upper-message__date">
            ${message.created_at}
          </div>
        </div>
        <div class="lower-message">
          ${html_content}
          ${html_image}
        </div>
      </div>`
    return html;
  };
  $('.new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.messages').append(html);
      $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');
      $('.new_message')[0].reset();
      $('.form__submit').attr('disabled', false);
    })
    .fail(function(){
      alert('エラー') ;
    });
  })

  var reloadMessage = function(){
    if (window.location.href.match(/\/groups\/\d+\/messages/)){
      last_message_id = $('.message:last').data("id");
      $.ajax({
        url: "api/messages",
        type: 'GET',
        data: {id: last_message_id},
        dataType: 'json'
      })
      .done(function(messages){
        var  insertHTML = '';
        messages.forEach(function(message){
          insertHTML = buildHTML(message)
          $('.messages').append(insertHTML);
        });
        $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');
      })
      .fail(function(){
        alert('エラー');
      });
    };
  };
  setInterval(reloadMessage, 5000);
});