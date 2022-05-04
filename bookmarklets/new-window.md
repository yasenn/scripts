[addons - Firefox hide everything except content area of the browser - Super User](https://superuser.com/questions/977912/firefox-hide-everything-except-content-area-of-the-browser/1269912#1269912)

Save the following JavaScript code as a [bookmarklet](https://en.wikipedia.org/wiki/Bookmarklet), and click on it on the page which you want to view in a new minimal window:

```
javascript:void%20function(){window.open(window.location.href,Math.random(),%22menubar=1,resizable=0%22)}();
```

**[Click here to make the process easier!](https://fiddle.jshell.net/jfnr27wo/show/)** | [JSfiddle](https://jsfiddle.net/jfnr27wo/)
