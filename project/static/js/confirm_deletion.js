// Generated by CoffeeScript 1.6.3
(function() {
  var confirmation;

  confirmation = function(event) {
    event.preventDefault;
    return bootbox.dialog("I am a custom dialog", [
      {
        label: "Success!",
        "class": "btn-success",
        callback: function() {
          return Example.show("great success");
        }
      }, {
        label: "Danger!",
        "class": "btn-danger",
        callback: function() {
          return Example.show("uh oh, look out!");
        }
      }, {
        label: "Click ME!",
        "class": "btn-primary",
        callback: function() {
          return Example.show("Primary button");
        }
      }, {
        label: "Just a button..."
      }
    ]);
  };

  $(document).ready(function() {
    return $("#delete_question").click(function() {
      return confimation;
    });
  });

}).call(this);
