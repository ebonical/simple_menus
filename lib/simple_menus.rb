module SimpleMenus
  module ViewMethods
    class Menu
      def initialize(binding)
        @binding = binding
        @items = []
      end
      
      def method_missing(item_id, *args)
        options = args.extract_options!
        options[:index] = @items.length
        content = args.first
        @items << MenuItem.new(@binding, item_id, content, options)
        nil
      end
      
      def to_s
        @items.last.last = true
        @items.map { |item| item }.join
      end
    end
    
    class MenuItem
      attr_accessor :first, :last
      
      def initialize(binding, item_id, content, options)
        @binding = binding
        @item_id = item_id
        @content = content
        @index = options.delete(:index)
        @options = options.reverse_merge(:class => "")
        self.first = @index == 0
      end
      
      def to_s
        @options[:class] += ' first' if first
        @options[:class] += ' last' if last
        @binding.content_tag(:li, @content, @options)
      end
    end
    
    def menu(options = {}, &block)
      menu = Menu.new(self)
      yield(menu)
      concat content_tag(:div, content_tag(:ul, menu), options)
    end
  end
end

ActionView::Base.send :include, SimpleMenus::ViewMethods
