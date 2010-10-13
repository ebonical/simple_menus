module SimpleMenus
  module ViewMethods
    class Menu
      attr_accessor :id
      
      def initialize(view, *args)
        @view = view
        @options = args.extract_options!.reverse_merge(:class => "")
        self.id = args.first
        @options[:id] = id.to_s if id
        @options[:class] << ' simple_menu'
        @items = []
        @current_items = @view.instance_variable_get('@simple_menu_current_items')[id].dup rescue []
      end
      
      def menu(*args, &block)
        menu = Menu.new(@view, *args)
        @items.last.sub_menus << menu
        yield(menu)
      end
      
      def method_missing(item_id, *args, &block)
        options = args.extract_options!
        # insert into items array before block is called
        @items << (item = MenuItem.new(@view, item_id, options))
        item.content = block_given? ? @view.capture(&block) : args.first
        item.current = @current_items.include?(item.id)
        item.first = @items.size == 1
        nil
      end
      
      def to_s
        @items.last.last = true unless @items.empty?
        tag_options = @view.send :tag_options, @options
        "<div#{tag_options}><ul>#{@items}</ul></div>"
      end
    end
    
    class MenuItem
      attr_accessor :id, :first, :last, :current, :content
      
      def initialize(view, item_id, options)
        @view = view
        self.id = item_id
        @options = options
        @classes = (@options[:class] || '').split(' ')
        @sub_menus = []
      end
      
      def sub_menus
        @sub_menus
      end
      
      def to_s
        @classes << 'first' if first
        @classes << 'last' if last
        @classes << 'current' if current
        @options[:class] = @classes.join(' ')
        tag_options = @view.send :tag_options, @options
        "<li#{tag_options}>#{content}#{sub_menus}</li>"
      end
    end
    
    # Insert a menu into your view
    def simple_menu(*args, &block)
      menu = Menu.new(self, *args)
      yield(menu)
      concat(menu.to_s)
    end
    alias_method :menu, :simple_menu
    
  end
end
