(Teapot configure: { #port -> 8080 })
    GET:  '/*' -> [:req | DateAndTime now printString ];
    start
