define ->
  # get controller/action name from script tag
  controller_name = $('script[data-controller]').attr('data-controller')
  action_name = $('script[data-action]').attr('data-action')

  # initialize controller class
  require ['controllers/' + controller_name], (controller) ->
    window.controller = new controller(action_name)
