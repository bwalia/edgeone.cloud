local client_ip			= ngx.var.remote_addr
local host_header		= ngx.var.host
local uri				= ngx.var.uri
local uri_lc			= uri:lower()
local params			= ngx.var.args

local ssl				= require "ngx.ssl"
local redis				= require "resty.redis"
local resolver			= require "resty.dns.resolver"
local cjson				= require "cjson"
ngx.ctx.x_origin_host = ""
ngx.ctx.x_origin_port = ""


-- init headers and vars etc
local req_headers = ngx.req.get_headers()
-- checking an a header value to determine target uri
if req_headers["x-headers-debug"] == "on" then
  ngx.var.send_debug_headers = true
else
   -- default value if not header found
end
local host_is_valid = false

-- redis connection open for each request

               local red = redis:new()

                red:set_timeout(1000) -- 1 sec
                --local ok, err = red:connect("unix:/tmp/redis.sock")
                local ok, err = red:connect("127.0.0.1", 6379)

               if not ok then
                    ngx.say("failed to connect: ", err)
                    return
                end

                local res, err = red:get(host_header..':host')

                if not res then
				-- ngx.req.set_uri('/host_not_found.html')  	--                    ngx.say(host_header..' host_not_found: ', err)
                --     return
                ngx.header.content_type = "text/html"
                ngx.status = 403
                ngx.say("Forbidden host is not found")
                return ngx.exit(403)

                end

                if res == ngx.null then
					-- ngx.req.set_uri('/host_not_found.html') --ngx.say(host_header..' host_not_found: ', err)
                    -- return
                    ngx.header.content_type = "text/html"
                    ngx.status = 403
                    ngx.say("Forbidden host is not found")
                    return ngx.exit(403)

                else
					--yepeee host is found in redis OK
				ngx.var.is_a_valid_host = true
				--ngx.say("host: " , res)
                host_is_valid = true
				local cfg_main_table = cjson.decode(res) --convert config json to array/table
				--handle request as per the config in redis for this host

				-- -- -- -- --

        local backend_proxy_output		= ''
        local backend_priority_output 	= 0
        local backend_proxy_port 	= '80'
        local backend_proxy_port_output = ''
        --Fetch default proxy for all request types
        local backend_proxy = 'proxy_pass'
        local backend_port= 'proxy_port'

        for kk,vv in pairs(cfg_main_table) do
          if kk == backend_proxy then
            backend_proxy_output = vv	--ngx.say("proxy_pass: "..vv..'<br>')
        ngx.var.proxy_host = backend_proxy_output
ngx.header["X-Origin-Host"] = ngx.var.proxy_host
ngx.ctx.x_origin_host = ngx.var.proxy_host
end

          if kk == backend_port then
            backend_proxy_port_output = vv	--ngx.say("proxy_pass: "..vv..'<br>')
            backend_proxy_port = backend_proxy_port_output
            if backend_proxy_port_output == "" then
            else
            ngx.var.proxy_port = backend_proxy_port_output
	    ngx.header["X-Origin-Port"] = ngx.var.proxy_port
      ngx.ctx.x_origin_port = ngx.var.proxy_port
    end
        end
        end

          if ngx.var.send_debug_headers then
            ngx.header["X-Backend-Proxy-Output"] = backend_proxy_output
            ngx.header["X-Backend-Proxy-Port"] = backend_proxy_port_output
          end

		  end

-- or just close the connection right away:
    local ok, err = red:close()
        if not ok then
            ngx.say("failed to close: ", err)
        return
    end

--ngx.header["X-Proxy-Host"] = ngx.var.proxy_host