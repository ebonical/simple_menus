module SimpleMenus
  module ControllerMethods
    module ClassMethods
      
      # Set current menu item from controller class level
      def current_items(menu_id, *items)
        options = items.extract_options!
        before_filter(options) do |controller|
          controller.current_items(menu_id, *items)
        end
      end
      alias_method :current_item, :current_items
      
    end

    module InstanceMethods
      
      def current_items(menu_id, *items)
        @simple_menu_current_items ||= {}
        @simple_menu_current_items[menu_id] = items
      end
      alias_method :current_item, :current_items
      
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
