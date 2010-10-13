require "view_methods"
require "controller_methods"

ActionView::Base.send :include, SimpleMenus::ViewMethods
ActionController::Base.send :include, SimpleMenus::ControllerMethods
