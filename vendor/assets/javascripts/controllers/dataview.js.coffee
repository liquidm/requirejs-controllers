define [
  'controllers/grid'
], (GridController) ->

  class DataViewController extends GridController

    initDataView: (@selector, @columns, @options, @model=null) ->
      @dataView = new Slick.Data.DataView()
      @grid = new Slick.Grid(@selector, @dataView, @columns, @options)
      @columnpicker = new Slick.Controls.ColumnPicker(@columns, @grid, @options)

      @grid.onSort.subscribe (e, args) =>
        @dataView.sort(new Slick.Sorters.Sorter(args), true)
        @grid.invalidateAllRows()
        @grid.render()

      @dataView.onRowCountChanged.subscribe (e, args) =>
        @grid.updateRowCount()
        @grid.render()

      @dataView.onRowsChanged.subscribe (e, args) =>
        @grid.invalidateRows(args)
        @grid.render()

    initLoader: ->
        @model.onDataLoading.subscribe (e, args) =>
          @showIndicator()

        @model.onDataLoaded.subscribe (e, args) =>
          @hideIndicator()

        @model.onDataLoadedSuccess.subscribe (e, args) =>
          @dataView.beginUpdate()
          @dataView.setItems(args.data)
          @dataView.endUpdate()
          @grid.invalidateAllRows()
          @grid.render()

        @model.onDataLoadedError.subscribe (e, args) =>
          alert("failed to load data from server")

    initWriter: ->
      @model.onDataWriting.subscribe (e, args) =>
        @showIndicator("Writing")

      @model.onDataWritten.subscribe (e, args) =>
        @hideIndicator()

      @model.onDataWrittenSuccess.subscribe (e, args) =>
        @dataView.updateItem(args.item.id, args.data)
        @grid.updateRow(args.row)

      @model.onDataWrittenError.subscribe (e, args) =>
        alert("failed to write data on server")

      @grid.onCellChange.subscribe (e, args) =>
        @model.writeData(args)

    showIndicator: (label="Loading") ->
      $grid = $(@selector)
      @loadingIndicator = $("<span class='loading-indicator'><label>#{label}...</label></span>").appendTo(document.body)
      @loadingIndicator.css("position", "absolute")
                       .css("top", $grid.position().top + $grid.height() / 2 - @loadingIndicator.height() / 2)
                       .css("left", $grid.position().left + $grid.width() / 2 - @loadingIndicator.width() / 2)
      @loadingIndicator.show()

    hideIndicator: ->
      @loadingIndicator.fadeOut()
      @loadingIndicator.remove()

    initHeaderRow: ->
      if @options.showHeaderRow
        $(@grid.getHeaderRow()).delegate ":input", "change keyup", (e) =>
          @columnFilters[$(e.target).data("column-id")] = $.trim($(e.target).val())
          @dataView.refresh()

        @grid.onColumnsReordered.subscribe (e, args) =>
          @updateHeaderRow()

        @grid.onColumnsResized.subscribe (e, args) =>
          @updateHeaderRow()

        @dataView.beginUpdate()
        @dataView.setFilter(@filterHeaderRow)
        @dataView.endUpdate()

        @updateHeaderRow()

    updateHeaderRow: ->
      @columnFilters ?= {}

      for column in @columns
        if not column.noHeaderFilter
          header = @grid.getHeaderRowColumn(column.id)
          $(header).empty()
          $("<input type='text'>")
              .data("column-id", column.id)
              .val(@columnFilters[column.id])
              .appendTo(header)

    filterHeaderRow: (item) =>
      for column, value of @columnFilters
        column = @grid.getColumns()[@grid.getColumnIndex(column)]
        if not @headerFilter(column, value, item)
          return false
      return true

  return DataViewController
