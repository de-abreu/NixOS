# INFO: from https://nixos.wiki/wiki/Encrypted_DNS
#
# By default, DNS traffic is sent in plain text over the internet; it can be monitored or spoofed by any party along the path, including your ISP. DNSSEC authenticates the DNS records themselves, but can't stop your ISP monitoring domains or dropping queries.
#
# Encrypted DNS protocols aim to address this hole by encrypting queries and responses in transit between DNS resolvers and clients; the most widely deployed ones are DNS over HTTPS (DoH), DNS over TLS (DoT), and DNSCrypt.
#
# services.dnscrypt-proxy2 is generally recommended, as it has the widest protocol and feature support, and is written in a memory-safe language.
{...}: {
  # services.dnscrypt-proxy2 = {
  #   enable = true;
  #   settings = {
  #     ipv6_servers = true;
  #     require_dnssec = true;
  #     sources.public-resolvers = {
  #       urls = [
  #         "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
  #         "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
  #       ];
  #       cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
  #       minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
  #     };
  #     server_anmes = ["mullvad-extend-doh"];
  #   };
  # };
  # systemd.services.dnscrypt-proxy2.serviceConfig = {
  #   StateDirectory = "dnscrypt-proxy";
  # };
}
