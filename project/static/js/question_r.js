// Generated by CoffeeScript 1.6.3
(function() {
  var answer_template, button_template, delete_entry, form_submit, ix, process_submit, update_cnt;

  ix = 1;

  answer_template = function() {
    return "<div class=\"answerblock\">\n<input class=\"Rradio pull-left\" name=\"radio\" type=\"radio\" value=\"\">\n<input name=\"text1" + ix + "\" class=\"radiotext form-control\">\n<div class=\"btn btn-default btn-sm delete-button pull-right\"> Zmazať </div> <br>\n</div>";
  };

  button_template = function() {
    return "<a class=\"btn btn-default btn-sm\" id='submit'> Pridať odpoveď </a> <br>";
  };

  process_submit = function() {
    $('#answer_r').append(answer_template());
    ix++;
    return update_cnt();
  };

  update_cnt = function() {
    var cnt;
    return cnt = $('.radiotext').length;
  };

  delete_entry = function(e) {
    return $(e.target).parent().remove();
  };

  form_submit = function(redir) {
    var answers, bodyQ, correctness, textQ;
    $('#form_r').validate({
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
    if ($('#form_r').valid()) {
      textQ = $("textarea[name='text']").val();
      bodyQ = $("input[name='points']").val();
      answers = $("input.radiotext").serializeArray();
      correctness = $("input.Rradio").serializeArray();
      $.ajax({
        url: post_url,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
          text: textQ,
          points: bodyQ,
          answers: answers,
          correctness: correctness
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
    var answer, new_c_url, new_o_url, new_r_url, new_s_url;
    answer = $('#answer_r');
    answer.html(button_template());
    $('#submit').click(process_submit);
    $('#answer_r').on('click', '.delete-button', delete_entry);
    $('#form_r').submit(function() {
      return false;
    });
    new_s_url = test_url + "/new-phrase-question";
    new_c_url = test_url + "/new-checkbox-question";
    new_r_url = test_url + "/new-radio-question";
    new_o_url = test_url + "/new-open-question";
    $("#save_and_add_s").click(function() {
      return form_submit(new_s_url);
    });
    $("#save_and_add_c").click(function() {
      return form_submit(new_c_url);
    });
    $("#save_and_add_r").click(function() {
      return form_submit(new_r_url);
    });
    $("#save_and_add_o").click(function() {
      return form_submit(new_o_url);
    });
    return $("#save_and_end").click(function() {
      return form_submit(test_url);
    });
  });

}).call(this);

/*
//@ sourceMappingURL=question_r.map
*/
