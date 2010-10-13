module SimpleMenus
  module ViewMethods
    class Menu
      attr_accessor :id
      
      def initialize(binding, *args)
        @binding = binding
        @options = args.extract_options!.reverse_merge(:class => "")
        self.id = args.first
        @options[:id] = id.to_s if id
        @options[:class] << ' simple_menu'
        @items = []
        @current_items = @binding.instance_variable_get('@simple_menu_current_items')[id] rescue []
      end
      
      def method_missing(item_id, *args, &block)
        options = args.extract_options!
        item = MenuItem.new(@binding, item_id, options)
        item.content = block_given? ? @binding.capture(&block) : args.first
        item.current = @current_items.include?(item.id)
        item.first = @items.empty?
        @items << item
        nil
      end
      
      def to_s
        @items.last.last = true
        @binding.content_tag(:div, @options) do
          @binding.content_tag(:ul, @items)
        end
      end
    end
    
    class MenuItem
      attr_accessor :first, :last, :id, :current, :content
      
      def initialize(binding, item_id, options)
        @binding = binding
        self.id = item_id
        @options = options
        @classes = (@options[:class] || '').split(' ')
      end
      
      def to_s
        @classes << 'first' if first
        @classes << 'last' if last
        @classes << 'current' if current
        @options[:class] = @classes.join(' ')
        @binding.content_tag(:li, content, @options)
      end
    end
    
    def menu(*args, &block)
      menu = Menu.new(self, *args)
      yield(menu)
      concat(menu.to_s)
    end
  end
end
