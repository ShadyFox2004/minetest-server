Books 
------
#### create_formspec
Creates a formspec displayed to the user. The formspec for the owner allows to
edit the content. Everyone else is only allowed to read.
```lua
function books.create_formspec(player_name, data)
player_name     : Name
data            : BookData
return          : Formspec

books.create_formspec("singleplayer", {
	title = "",
	owner = String,
	page = Integer,
	page_max = Integer,
	description = "",
	text = "",
})
```

#### get_lines
Takes a text and returns a sequence with the lines.
```lua
function books.get_lines(text)
text    : String
return  : Table
```

#### on_use
Shows the content of a book to the player.
```lua
function books.on_use(itemstack, user)
itemstack       : ItemStack
user            : Player
return          : ItemStack
```

#### page_content
Takes the data of a book and returns the content of the current page.
```lua
function books.page_content(data)
data    : BookData
return  : String
```

#### register_book
Registers a book.
```lua
function books.register_book(name, def)
name    : Name
def     : BookDef

books.register_book("mod:item", {
	-- essential

	-- optional 
	description = "mod_item",
	short_description = "",
	groups = {book = 1, flammable = 3, not_in_creative_inventory = def.not_in_creative_inventory},
	inventory_image = "mod_item.png",
	inventory_overlay = nil,
	wield_image = "mod_item.png",
	wield_overlay = nil,
	palette = nil,
	color = nil,
	wield_scale = {x = 1, y = 1, z = 1},
	stack_max = 100,
	range = 4.0,
	node_placement_prediction = nil,
	sound = nil,
	on_use = books.on_use,
	not_in_creative_inventory = nil
})
```
#### register_book_set
Registers a book and a written book. 
```lua
function books.register_book_set(name, def)
name    : Name
def     : Table

books.register_book_set(name, {
	-- essential
	new = BookDef,

	-- optional
	written = {
		-- optional
		stack_max = 1
		not_in_creative_inventory = 1
	}
})
```

#### turn_page
Determines which page should be displayed. If it reaches the beginning or the 
end, it jumps to the other side.
```lua
function books.turn_page(to_right, page_no, page_max)
to_right        : Boolean
page_no         : Integer
page_max        : Integer
return          : Integer
```
If to_right is true, the next page is returned, otherwise the previous page.
