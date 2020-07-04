// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap.min
//= require dataTables/jquery.dataTables
//= require_tree .

// onBlur save
$(document).ready(function() {
  // pageless updating of company attributes
  $(".note-item").on("change", function() {
      $.ajax({
        type: "POST",
        url: 'notes/update_note',
        headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
        data: {
          attribute: $(this).attr("id").split("_")[1],
          value: $(this).val(),
          id:  $(this).parent().parent().attr("id"),
        },
        success: function(res) {
          alert(res.message)
        },
        error: function(res) {
          alert(res.message)
        }
    });
  })
})



// sortable datatable init
function dataTable() {
  var table = $('#notes').DataTable({
    select: false,
    "info": false,
    "lengthChange": false,
    dom: 'Bfrtip',
    buttons: [
      'excelHtml5'
     ],
    "bInfo": false,
    "columnDefs": [{
        className: "Name",
        "targets":[0],
        "visible": true,
    }]
  });//End of create main table
  }
