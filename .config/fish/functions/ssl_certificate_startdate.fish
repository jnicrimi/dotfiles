function ssl_certificate_startdate --argument domain
  if test -z "$domain"
    return 1
  end
  openssl s_client -connect $domain:443 -servername $domain </dev/null 2>/dev/null \
    | openssl x509 -startdate -noout \
    | cut -d '=' -f 2
end
