#!/bin/bash

local_port_range=$(sysctl net.ipv4.ip_local_port_range|sed "s/.*=[[:space:]]*\([^[:space:]]*\)[[:space:]]\+\([^[:space:]]*\)/\1|\2/")
local_min=$(echo $local_port_range|cut -d"|" -f1)
local_max=$(echo $local_port_range|cut -d"|" -f2)

cnt=$(netstat -tan|awk -v "max=${local_max}" -v "min=${local_min}" '{
      sub(/.*:/,"",$4)
      if (int($4) >= int(min) && int($4) <= int(max)) {
            print $4
      }}'|wc -l
      )
cat <<EOF

range: $local_min - $local_max
used:  $cnt
free:  $(( $local_max - $local_min - $cnt ))
EOF
