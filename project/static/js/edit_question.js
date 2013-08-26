// Generated by CoffeeScript 1.6.1
(function() {
  var form_submit;

  form_submit = function(redir) {
    var answers, bodyQ, correctness, is_q_mandatory, textQ;
    $('#form_showQ').validate({
      rules: {
        text: {
          required: true
        },
        points: {
          number: true
        }
      },
      messages: {
        text: "Prosím zadajte text otázky",
        points: {
          number: "Body musia byť číslo"
        }
      }
    });
    if ($('#form_showQ').valid()) {
      textQ = $("textarea[name='text']").val();
      bodyQ = $("input[name='points']").val();
      if (!!$("textarea.text")) {
        answers = $("input.text").serializeArray();
        correctness = $("input.indikator").serializeArray();
      } else {
        answers = $("textarea.text").val();
        correctness = true;
      }
      is_q_mandatory = $('#is_q_mandatory').is(':checked');
      $.ajax({
        url: post_url,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
          text: textQ,
          points: bodyQ,
          answers: answers,
          correctness: correctness,
          is_q_mandatory: is_q_mandatory
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
    $('#save_changes').click(form_submit(post_url));
    return $('#create_answer_showQ').click(function() {
      return input_template(this.id, this.name);
    });
  });

}).call(this);
