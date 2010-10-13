Simple Menus
============

Installation
------------

`./script/plugin install git@github.com:ebonical/simple_menus.git`

Examples
--------

#### ERB
    <% menu :main_menu do |m| %>
      <%= m.item link_to('Users', '/users') %>
      <%= m.item link_to('Pages', '/pages') %>
    <% end %>
    
#### HTML output
    <div id="main_menu" class="simple_menu">
      <ul>
        <li class="first"><a href="/users">Users</a></li>
        <li class="last"><a href="/pages">Pages</a></li>
      </ul>
    </div>

_Copyright (c) 2010 Ebony, released under the MIT license_
