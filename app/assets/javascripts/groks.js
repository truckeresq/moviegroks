window.onLoad = function bodyOnload(limitNum){
var tweet =  document.forms['form'].elements['title'].value;
document.forms['form'].elements['countdown'].value = limitNum - tweet.length;
}
function limitText(limitField, limitCount, limitNum) {
  if (limitField.value.length > limitNum) {
    limitField.value = limitField.value.substring(0, limitNum);
  } else {
    limitCount.value = limitNum - limitField.value.length;
  }
}

function seeTextArea (form) {
    alert (form.title.value);
}

$(document).ready(function(){
    $('#authorship').change(function(){
        if(this.checked)
            $('#author_message').fadeIn('slow');
        else
            $('#author_message').fadeOut('slow');

    });
});

$(document).ready(function() {
$('[data-toggle="popover"]').popover({
    trigger: 'hover',
        'placement': 'top'
  });
});

$().ready(function(){
    $('[rel=popover]').popover('show');
    window.setTimeout(function(){
        $('[rel=popover]').popover('hide');
    }, 6200);
    
});

var viewportWidth = $(window).width();
$(document).ready(function() {
  if (viewportWidth < 768) {
$('[data-toggle="dropdown"]').click(function(e){
    $('body').animate({ paddingTop: '320px' });
    e.preventDefault();
  });
}
});

$(document).ready(function() {
  if ($('#showQuote').length) {
var startTime = new Date().getTime();
var interval = setInterval(function() {
  if(new Date().getTime() - startTime > 24000) {
    clearInterval(interval);
    return;
  }
  refreshShowPage();
}, 8000);
}
});

function refreshShowPage() {
$.ajax({
url: '#show',
type: 'GET',
dataType: 'script',
});
}