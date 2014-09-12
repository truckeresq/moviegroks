// Books select dropdown
$(document).ready(function() {
 $("#movie_id").on("change", function() {
  window.location = '/movies/'+ $(this).val()
    });
  });