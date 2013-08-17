// Generated by CoffeeScript 1.6.3
(function() {
  var form_submit;

  form_submit = function() {
    var user_answers_C, user_answers_O, user_answers_R, user_answers_S;
    user_answers_S = $("input.user_answers_S").serializeArray();
    user_answers_C = $("input.user_answers_C").serialize();
    user_answers_R = $("input.user_answers_R").serialize();
    user_answers_O = $("input.user_answers_O").serializeArray();
    $.ajax({
      url: post_url,
      type: "POST",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify({
        user_answers_S: user_answers_S,
        user_answers_C: user_answers_C,
        user_answers_R: user_answers_R,
        user_answers_O: user_answers_O
      })
    }).done(function(response) {
      return top.location.href = "/dashboard";
    }).fail(function(response) {
      alert('nepodarilo sa. bohuzial :( prepac');
      return console.log(response);
    });
    return false;
  };

  $(document).ready(function() {
    $('#form_solve').submit(function() {
      return false;
    });
    return $("#solve_test").click(form_submit);
  });

}).call(this);

/*
//@ sourceMappingURL=solve.map
*/
