default: menu_js

menu_js: src/menu/menu.js

src/menu/menu.js: $(wildcard src/menu/src/**.elm)
	cd src/menu && elm make src/Main.elm --output=menu.js
