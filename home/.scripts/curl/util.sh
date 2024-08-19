export CURL_DEFAULTS=(
  # Read cookies
  '--cookie' '/tmp/cookies.txt' 
  # Write cookies
  '--cookie-jar' '/tmp/cookies.txt' 
  # Write response headers
  '--dump-header' '/tmp/respHeaders.txt' 
  # Write response body

  # Headers
  '--output' '/tmp/respBody.txt'
  '-H' 'Content-Type: application/json' 
  '-H' 'Accept: application/json' 

  # Ignore TLS
  '--insecure'

  '-v'

  # Prefix, so that the next arg shoudl be "GET" or "POST"
  '--request'
)

export HEADLESS_API_BASE='https://headless.sleepingduck.localhost:3000'
export ADMIN_API_BASE='https://admin.sleepingduck.localhost:3000'

# Run the curl to do the request
do_curl() {
  rm /tmp/respHeaders.txt /tmp/respBody.txt
  # # Uncomment to log the command
  echo curl "${CURL_DEFAULTS[@]}" "$@"
  curl "${CURL_DEFAULTS[@]}" "$@"
}

# Log the response
log_resp () {
  # Log headers as errors. Convenient so that the other output (the body) can
  # be piped somewhere on its own
  >&2 cat /tmp/respHeaders.txt
  cat /tmp/respBody.txt | jq .
}

# Main utility wrapper
api() {
  do_curl "$@"
  log_resp
}
