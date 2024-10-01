#!/bin/zsh

curl -X DELETE "https://demo.wiz.io/connections/{connection_id}" \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
     -H "Content-Type: application/json"