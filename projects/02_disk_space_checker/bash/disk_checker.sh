#!/bin/bash
#------ Configuration -------------------------------
THRESHOLD=80                # Alert if disk usage exceeds this %
ALERT_LOG="/tmp/disk_alerts.log"   # Log file for alerts

# ---------- Variables -----------------------------
DATE=$(date "+%Y-%m-%d %H:%M:%S")
ALERT_COUNT=0

echo "======================================="
echo "Disk Space Checker - $DATE"
echo "========================================"

# ----------- Loop through filesystems ----------------
# df -H = human-readable, -x = exclude virtual filesystems

while read -r LINE; do
    # Parse each line: extract filesystem name and usage %
    FILESYSTEM=$(echo "$LINE" | awk '{print $1}')
    USAGE=$(echo "$LINE" | awk '{print $5}' | tr -d '%')  # Remove % sign
    MOUNT=$(echo "$LINE" | awk '{print $6}')

    # Conditional: check if usage exceeds threshold
    if [ "$USAGE" -ge "$THRESHOLD" \; then
        echo "⚠️ ALERT: $FILESYSTEM mounted on $MOUNT is at ${USAGE}% (threshold: ${THRESHOLD}%)"
        echo "$DATE | ALERT | $FILESYSTEM ($MOUNT) at ${USAGE}%" >> "$ALERT_LOG"
        ALERT_COUNT$((ALERT_COUNT + 1))
    else
        echo "✅ $FILESYSTEM mounted on $MOUNT is at ${USAGE}%"
    fi
    done < <(df -H -x tmpfs -x devtmpfs | tail -n +2)

# ------------ Summary -----------------------------
echo "---------------------------------------"
if ["$ALERT_COUNT" -gt 0 ]; then
    echo "⚠️ $ALERT_COUNT filesystem(s) over ${THRESHOLD}% threshold!"
    echo"     Alerts logged to: $ALERT_LOG"
else
    echo "✅ All filesystems are within the ${THRESHOLD}% threshold."
fi
echo "======================================= "

