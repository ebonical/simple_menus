Simple Menus
============

Installation
------------

`./script/plugin install git@github.com:ebonical/simple_menus.git`

Examples
--------

### First steps - very simple
#### ERB
    <% menu do |m| %>
      <%= m.item link_to('Users', users_path) %>
      <%= m.item link_to('Pages', pages_path) %>
    <% end %>
    
#### HTML output
    <div class="simple_menu">
      <ul>
        <li class="item first"><a href="/users">Users</a></li>
        <li class="item last"><a href="/pages">Pages</a></li>
      </ul>
    </div>
    
### Setting which item is selected in controller
CSS class `current` will be added to the `LI` tag.

#### View - ID the menu and each item

    <% menu :main_menu do |m| %>
      <%= m.users link_to('Users', users_path) %>
      <%= m.pages link_to('Pages', pages_path) %>
    <% end %>
    
#### Controller - make the 'users' item selected

    current_item :main_menu, :users

_Copyright (c) 2010 Ebony, released under the MIT license_
