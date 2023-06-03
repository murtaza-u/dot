{ config, pkgs, ... }: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "murtaza.u6e24@gmail.com";
  };

  services.nginx = {
    enable = true;
    virtualHosts."mattermost.murtazau.xyz" = {
      serverName = "mattermost.murtazau.xyz";
      forceSSL = true;
      enableACME = true;
      locations = {
        "/" = {
          proxyPass = "http://localhost:8065";
          extraConfig = ''
            client_max_body_size 50M;
            proxy_set_header Connection " ";
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Frame-Options SAMEORIGIN;
            proxy_buffers 256 16k;
            proxy_buffer_size 16k;
            proxy_read_timeout 600s;
            proxy_cache_revalidate on;
            proxy_cache_min_uses 2;
            proxy_cache_use_stale timeout;
            proxy_cache_lock on;
            proxy_http_version 1.1;
          '';
        };
        "~ /api/v[0-9]+/(users/)?websocket$" = {
          proxyPass = "http://localhost:8065";
          extraConfig = ''
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            client_max_body_size 50M;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Frame-Options SAMEORIGIN;
            proxy_buffers 256 16k;
            proxy_buffer_size 16k;
            client_body_timeout 60;
            send_timeout 300;
            lingering_timeout 5;
            proxy_connect_timeout 90;
            proxy_send_timeout 300;
            proxy_read_timeout 90s;
            proxy_http_version 1.1;
          '';
        };
      };
      extraConfig = ''
        http2_push_preload on; # Enable HTTP/2 Server Push
      '';
    };
  };
}
