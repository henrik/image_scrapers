// E.g. on https://pinkhouse-webshop.jp/pinkhouse/catalog/detail/1.

// Bookmarklet:
javascript: const urls = $(".cloud-zoom").get().map((e) => e.href); const a = document.createElement("a"); document.body.appendChild(a); urls.forEach((url, i) => {; setTimeout(() => {; a.href = url; a.download = url.replace(/.*\//, ""); a.click(); }, i * 100); }); a.parentNode.removeChild(a)

// More readable:
const urls = $(".cloud-zoom").get().map((e) => e.href)
const a = document.createElement("a")
document.body.appendChild(a)

urls.forEach((url, i) => {
  // Throttle – it missed images otherwise.
  setTimeout(() => {
    a.href = url
    a.download = url.replace(/.*\//, "")
    a.click()
  }, i * 100)
})

a.parentNode.removeChild(a)












