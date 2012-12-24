var Ipsum = (function() {
  function init() {
    $('#go').click(function(evt) {
      evt.preventDefault();
      var paragraphs = $('#paragraphs').val();
      window.location = '/' + paragraphs;
    });
  }

  return {
    init: init
  };
})();

$(Ipsum.init);
