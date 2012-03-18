module RequirejsControllersHelper
  def requirejs_controller_tag
    html = requirejs_include_tag
    html.concat <<-HTML.html_safe
    <script>
    define('main', function() {
      require(['controllers/#{controller.controller_path}'], function(controller) {
        window.controller = new controller('#{controller.action_name}')
      })
    })
    </script>
    HTML
    html.html_safe
  end
end
