define ->

  class BaseController
    constructor: (action) ->
      # bind events from subclasses
      for event in ['click', 'focus', 'blur', 'change', 'keyup', 'submit']
        for selector, params of (this[event]? && this[event]())
          @bindevent selector, event, params

      # call action if it exists
      @action = action
      this[action]() if this[action]?

    bindevent: (selector, event, params) ->
      # extract function from params
      if $.type(params) == 'function'
        # direct call
        fnc = params
      else
        # at first parse the selector for restrictions
        restricted_to = params
        [selector, action_restriction] = selector.split('@')
        if action_restriction?
          if action_restriction == 'modify'
            restricted_to = ['create', 'update', 'edit', 'new']
          else
            restricted_to = [action_restriction]
        return unless @action in restricted_to
        fnc = params[params.length-1]

      # wrap our callback with event params
      wrapped = (e) =>
        fnc.apply(this, [$(e.target), e])

      # bind event to current and future selectors
      $(selector).livequery(event, wrapped)

    # syntax sugar for bindevent callbacks
    at: (page, fnc) ->
      [page, fnc]

    on: (params...) ->
      params

    on_modify: (fnc) ->
      ['create', 'update', 'edit', 'new', fnc]

  return BaseController
