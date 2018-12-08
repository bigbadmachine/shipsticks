
$('#launch-calc').on('click', function(ev) {

  $('#calculator').modal();

});

var timerCloseModal = null;
$('#calculator').on('click', function(ev) {
  clearTimeout(timerCloseModal);
});

$('#calculator').on('hidden.bs.modal', function () {
  clearModal();
})

$(function() { 
  $('#calculator-form').on('submit', function(e) { 
    e.preventDefault();  
    var form_data = getData( $(this) );

    errors = "";
    clearResults()

    if($('#pkg_width').val() < 1)
      errors += "Width (in inches) is required.<br/>";

    if($('#pkg_height').val() < 1)
      errors += "Height (in inches) is required.<br/>";

    if($('#pkg_length').val() < 1)
      errors += "Length (in inches) is required.<br/>";

    if($('#pkg_weight').val() < 1)
      errors += "Weight (in lbs) is required.<br/>";

    if(errors != "")
      $('.calculator-errors').html(errors);
    else {
      $('.calculator-errors').html("");
      setTimeout(function () { toggleSubmit(true); }, 0);

      var url = "/products/calculate";
      var posting = $.get( url, form_data );
          posting.done(function( data ) {
            setTimeout(function () { toggleSubmit(false); }, 0);
            timerCloseModal = setTimeout(function () { closeModal(); }, 5000);
            writeResults(data);
          });
    }

  });
});


function writeResults(data) {
  if(data == null)
    text = 'No Matches'
  else
    text = "Use this " + data.type + " - " + data.name

  $('#selected-package-home').html('<span class="selected-package">' + text + '</span>');
  $('#selected-package-modal').html('<span class="selected-package">' + text + '</span>');
}

function clearResults() {
  $('#selected-package-modal').html('');
  $('#selected-package-home').html('');
}

function toggleSubmit(on) {
  $('#calculator-form-submit').prop('disabled',on);
}

function closeModal() {
  $('#calculator').modal('hide');
}

function clearModal() {
  $('#selected-package-modal').html('');
  $('#pkg_width').val('');
  $('#pkg_length').val('');
  $('#pkg_height').val('');
  $('#pkg_weight').val('');
  $("#pkg_type").val($("#pkg_type option:first").val());
  toggleSubmit(false);
}

function getData(form) {
  var data = form.serializeArray();
  var object = {};

  for(var i = 0; i < data.length; i++){
    object[data[i]['name']] = data[i]['value'];
  }

  return object;
}