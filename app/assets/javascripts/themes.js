$(document).ready(function() {
$("#theme_id").on("change", function() {
			window.location = '/themes/'+ $(this).val()
		});
	});

var ready;
ready = function() {


var keywordTokens = new Bloodhound ({
  datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.keyword); },
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 10,
  prefetch: {
    ttl: 1,
    url: '../themes.json',
    filter: function(themes) {
      return $.map(themes, function(theme) { return { id: theme.id, keyword: theme.keyword };
    });
  }
 }
}); 

keywordTokens.initialize();

$('#scrollable-dropdown-menu .theme-typeahead').typeahead({
    hint: true,
    highlighter: true,
    minLength: 1
 },

{
    name: 'id',
    displayKey: 'keyword',
    source: keywordTokens.ttAdapter(),
    restrictInputToDatum: true
})

.on('typeahead:opened', onOpened) 
.on('typeahead:selected', onAutocompleted)
.on('typeahead:autocompleted', onSelected)

function onOpened($e) {
  $('.tt-dropdown-menu').css('width', $(this).width() + 'px');
   console.log('opened');
}


function onAutocompleted($e, datum) {
  console.log('autocompleted');
  console.log(datum);
  }



function onSelected($e, datum) {
  console.log('selected');
  console.log(datum);
}

 function saveTheme () {
  $("form").submit(function(e){ 
  $.ajax({
    type: 'POST',
    dataType: 'json',
    data: JSON.stringify(postData),
     success: function(data, textStatus, jqXHR){
     console.log(postData);
    },  
    failure: function(){
      alert("Error");
    } 
    });
  e.preventDefault();
  });
}

}
$(document).ready(ready);
$(document).on('page:load', ready);