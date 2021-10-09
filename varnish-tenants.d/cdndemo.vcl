vcl 4.1;

import std;
import directors;


# We have to have a backend, even if we do not use it

backend default {
    .host = "137.220.95.139";
    .port = "8080";
    .probe = {
        .url = "/";
        .timeout = 1s;
        .interval = 5s;
        .window = 5;
        .threshold = 3;
    }
}

sub vcl_init {
    new balancer = directors.round_robin();
    balancer.add_backend(default);
}


sub vcl_recv {

	if(req.url ~ "^/hit(/.*)?"){

                return (pass);
        } else {
     #Goodbye incoming cookies:
     unset req.http.Cookie;
}

	set req.http.x-origin-host = "www.cdndemo.xyz";
        set req.http.Host = "www.cdndemo.xyz";
        set req.backend_hint = balancer.backend();

#set req.backend_hint = default;

}


sub vcl_backend_response {
        set beresp.ttl = 1h;
        set beresp.grace = 1w;

}

sub vcl_deliver {
    if (obj.hits > 0) {
    set resp.http.X-Cache = "HIT";
    } else {
    set resp.http.X-Cache = "MISS";

    }
}
