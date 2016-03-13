</<script !src="">

    $(document).ready(function() {
    setupGridAjax();
});

// Turn all sorting and paging links into ajax requests for the grid
function setupGridAjax() {
    $("#ajax").find(".paginateButtons a, th.sortable a").live('click', function(event) {
        event.preventDefault();
//        var url = $(this).attr('href');
//
//        var grid = $(this).parents("table.ajax");
//        $(grid).html($("#spinner").html());

        alert(),
        $.ajax({

            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('slow');});
            }
        });
    });
}
</script>
<div class="ajax">

<g:each in="${searchTopics}"  var="topics">
${topics}
</g:each>

<g:each in="${searchSubscriptions}"  var="subscriptions">
    ${subscriptions}
</g:each>

<g:each in="${searchResources}"  var="resources">
    ${resources}
</g:each>


</div>

    <div class="pagination">
        <g:paginate total="${topics}" />
    </div>