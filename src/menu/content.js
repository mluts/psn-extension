console.log("Loading Content Script")

function wishlistItems() {
  return Array.prototype.map.call(
    document.querySelectorAll('.wishlist-item-cell'),
    parseWishlistItem
  )
}

function parseWishlistItem(el) {
  let name = el.querySelector(".wishlist-item-cell__name");
  let prev_price = el.querySelector(".price-display__strikethrough");
  let curr_price = el.querySelector(".price-display__price");
  return {
    name: name && name.textContent,
    prev_price: prev_price && prev_price.textContent,
    curr_price: curr_price && curr_price.textContent
  }
}
