// Generated by CoffeeScript 1.6.1
(function() {
  var form_submit;

  form_submit = function(redir) {
    var T_text, description, end_time, start_time;
    $('#form_showT').validate({
      rules: {
        text: {
          required: true
        },
        description: {
          required: true
        }
      },
      messages: {
        text: "Prosím zadajte nadpis testu",
        description: {
          required: "Prosím zadajte popis testu"
        }
      }
    });
    if ($('#form_showT').valid()) {
      T_text = $("input[name='name_test']").val();
      description = $("textarea[name='description_test']").val();
      start_time = $("input[name='edit_start_time']").val();
      end_time = $("input[name='edit_end_time']").val();
      console.log(T_text);
      console.log(description);
      console.log(start_time);
      console.log(end_time);
      $.ajax({
        url: post_url,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
          name: T_text,
          description: description,
          start_time: start_time,
          end_time: end_time
        })
      }).done(function(response) {
        return top.location.href = redir;
      }).fail(function(response) {
        return console.log(response);
      });
    }
    return false;
  };

  $(document).ready(function() {
    return $('#save_edit_test').click(function() {
      return form_submit(post_url);
    });
  });

}).call(this);