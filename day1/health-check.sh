#!/bin/bash
echo "=== $(hostname) — $(date -Iseconds) ==="
echo "--- Uptime ---"
uptime
echo "--- Pamięć ---"
free -h | head -2
echo "--- Top 5 procesów po CPU ---"
ps -eo pid,user,%cpu,%mem,cmd --sort=-%cpu | head -6
echo "--- Top 5 procesów po RAM ---"
ps -eo pid,user,%cpu,%mem,cmd --sort=-%mem | head -6
echo "--- Dyski ---"
df -hT | grep -v tmpfs
echo "--- LISTEN ---"
ss -tulpn | head -15
echo "--- Failed services ---"
systemctl --failed --no-pager --no-legend
echo "--- Ostatnie 5 błędów z journala ---"
journalctl -p err -n 5 --no-pager
