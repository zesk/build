/**
 *
 * Copyright &copy; 2026 Market Acumen, Inc.
 */
(function (w) {
    console.log('build.js active');
    if (w.document.URL.indexOf('.zesk.com')) {
        (function (c, r, x, id, e) {
            var d = c.document, p = d.getElementsByTagName(x)[0], n = d.createElement(x);
            (c[r] = c[r] || []).push(e);
            n.src = '//www.conversionruler.com/bin/js.php?siteid=' + id;
            p.parentNode.insertBefore(n, p);
        })(w, '_crq', 'script', 10805, 0)
    }
}(window));
