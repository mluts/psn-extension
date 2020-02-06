default: menu_js

menu_js: src/menu/menu.js

src/menu/menu.js: $(wildcard src/menu/src/**.elm) src/menu/elm.json
	cd src/menu && elm make src/Main.elm --output=menu.js
