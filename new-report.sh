#!/usr/bin/env bash
# ينشئ تقرير اليوم من القالب: ./new-report.sh  أو  ./new-report.sh 2026-11-04
set -euo pipefail
cd "$(dirname "$0")"
DATE="${1:-$(date +%F)}"
DAYS=(الأحد الإثنين الثلاثاء الأربعاء الخميس الجمعة السبت)
DAY="${DAYS[$(date -d "$DATE" +%w)]}"
MONTH_DIR="reports/${DATE:0:7}"
FILE="$MONTH_DIR/$DATE.md"
mkdir -p "$MONTH_DIR"
if [[ -e "$FILE" ]]; then echo "التقرير موجود: $FILE"; exit 0; fi
sed -e "s/{{DATE}}/$DATE/" -e "s/{{DAY}}/$DAY/" templates/daily-report.md > "$FILE"
echo "تم إنشاء: $FILE"
