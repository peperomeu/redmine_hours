hours_routes = {
  '/hours'    => {:controller => 'hours', :action => 'index', :via => [:get]},
  '/hours/n'  => {:controller => 'hours', :action => 'next', :via => [:get]},
  '/hours/p'  => {:controller => 'hours', :action => 'prev', :via => [:get]},
  '/hours/sw' => {:controller => 'hours', :action => 'save_weekly', :via => [:post]},
  '/hours/sd' => {:controller => 'hours', :action => 'save_daily', :via => [:post]},
  '/hours/del'=> {:controller => 'hours', :action => 'delete_row', :via => [:post, :delete]}
}

if Redmine::VERSION::MAJOR == 1
  ActionController::Routing::Routes.draw do |map|
    hours_routes.each do |route_name, route_action|
      map.connect route_name, route_action
    end
  end
elsif Redmine::VERSION::MAJOR == 2
  RedmineApp::Application.routes.draw do
    hours_routes.each do |route_name, route_action|
      controller_name = route_action[:controller]
      action_name = route_action[:action]
      match route_name, to: "#{controller_name}##{action_name}"
    end
  end
else # Versión 3
  RedmineApp::Application.routes.draw do
    hours_routes.each do |route_name, route_action|
      controller_name = route_action[:controller]
      action_name = route_action[:action]
      via = route_action[:via]
      match route_name => "#{controller_name}##{action_name}", via: via
    end
  end
end
