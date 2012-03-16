define [
  'controllers/base'
], (BaseController) ->

  class GridController extends BaseController

    buildColumns: (columns, _locals) ->
      for column in columns
        $.extend(column, {
          field: column.id
          name: _locals[column.id]
          sortable: if column.sortable? then column.sortable else true
        })

  return GridController
