(function($){
    $(document).ready(function(){

        var curHref = 'registration';
        $('.selected').removeClass('selected');
        $('a[href="'+curHref+'"]').parent().addClass('selected');
        var offset = $('#'+curHref).offset();
        scrollToArticle(offset);
        
        function scrollToArticle(offset){
            $('html, body').animate({
                scrollTop: offset.top - 125
            }, 500);
        }
    });
})(jQuery);