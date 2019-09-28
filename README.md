# dotfiles

checklist
* configure chrony
* configure torified squid
  * `sudo dnf install tor obfs4 squid`
  * uncomment `forward-socks5t   /               127.0.0.1:9050 .` in `/etc/privoxy/config`
  * ```
    # Domains to be handled by Tor
    acl tor_url url_regex "/etc/squid/url.tor"

    # SSL bump rules
    acl DiscoverSNIHost at_step SslBump1
    acl NoSSLIntercept ssl::server_name_regex "/etc/squid/url.tor"
    ssl_bump peek DiscoverSNIHost
    ssl_bump splice NoSSLIntercept
    ssl_bump bump all

    # Tor access rules
    never_direct allow tor_url

    # Local Tor is cache parent
    cache_peer 127.0.0.1 parent 8118 0 no-query no-digest default

    cache_peer_access 127.0.0.1 allow tor_url
    cache_peer_access 127.0.0.1 deny all

    acl hasRequest has request
    access_log daemon:/var/log/squid/access.log buffer-size=256KB logformat=squid hasRequest !tor_url
    ```
  * `/etc/squid/url.tor`
    ```
    torproject.*
    archive\.org
    #livejournal\.com
    #wordpress\.com
    #youtube.*
    #ytimg.*
    #googlevideo.*
    #google.*
    #googleapis.*
    #googleusercontent.*
    #gstatic.*
    #gmodules.*
    #blogger.*
    #blogspot.*
    #facebook.*
    #fb.*
    #telegram.*
    #tg\.me.*
    #tdesktop.*
    ```
  * `sudo systemctl enable --now tor@obfs4.service && journalctl -f -u tor@obfs4.service`
  * `sudo systemctl enable --now privoxy.service && journalctl -f -u privoxy.service`
  * `sudo systemctl enable --now squid.service && journalctl -f -u squid.service`
  * `/etc/chromium/policies/managed/policy.json`
    ```
    {
      "ProxyMode": "fixed_servers",
      "ProxyServer": "127.0.0.1:3128"
    }
    ```
