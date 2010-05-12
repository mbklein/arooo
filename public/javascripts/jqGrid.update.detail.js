$.updateDetailGrid = function(ids,grid,url,caption) {
    grid_id = "#" + grid;
    if (ids == null) {
        ids = 0;
        if (jQuery(grid_id).getGridParam('records') > 0)
        {
            jQuery(grid_id).setGridParam({
                url: url+"?q=1&id=" + ids,
                page: 1
            })
            .setCaption(caption.replace('{{ids}}',ids))
            .trigger('reloadGrid');
        }
    }
    else
    {
        jQuery(grid_id).setGridParam({
            url: url+"?q=1&id=" + ids,
            page: 1
        })
        .setCaption(caption.replace('{{ids}}',ids))
        .trigger('reloadGrid');
    }
}