(function($){
    $(document).ready(function(){

        var curHref = 'registration';
        $('.selected').removeClass('selected');
        $('a[href="'+curHref+'"]').parent().addClass('selected');
        var offset = $('#'+curHref).offset();
        scrollToArticle(offset);
		attachBuyCheckBoxEvent();
        
        function scrollToArticle(offset){
            $('html, body').animate({
                scrollTop: offset.top - 108
            }, 500);
        }

		function attachBuyCheckBoxEvent(){
			$(".buy-checkbox").unbind('click');
			$(".buy-checkbox").each(function(){
				if($(this).is(":checked"))
					$(this).parent(".buy").siblings('.tsize').show();
				else	
					$(this).parent(".buy").siblings('.tsize').hide();
			});
			$(".buy-checkbox").on('click',function(){
				if($(this).is(":checked"))
					$(this).parent(".buy").siblings('.tsize').show();
				else	
					$(this).parent(".buy").siblings('.tsize').hide();
			});
		}
		
		function checkNumberOfParticipants()
		{
			if($("#participants_container").children().length == 6){
				$('#add_participant').hide();
			}	
			else{
				$('#add_participant').show();
			}
		}

		$('#add_participant').on('click',function(){
			if($("#participants_container").children().length != 6){
				$.get("/event/render_add_participant_partial",{ counter : $("#participants_container").children().length },function(json) {
						$("#participants_container").append(json.html);
						attachBuyCheckBoxEvent();
						checkNumberOfParticipants();
					}
				);
			}	
			else{
				alert("Maximum allowed participants for each school is 6.");
			}	
		});
    });
})(jQuery);