#!/usr/bin/env bash
set -e

OUTPUTS_JSON='{
  "releases_created": "true",
  "Source/PressureDb--release_created": "true",
  "Source/PressureDb--tag_name": "PressureDb@v3.0.0",
  "Source/PressureDb--version": "3.0.0",
  "paths_released": "[\"Source/PressureDb\"]",
  "prs_created": "false"
}'

GITHUB_OUTPUT_WITHOUT_C=$(mktemp)
GITHUB_OUTPUT_WITH_C=$(mktemp)

echo "=== WITHOUT -c ==="
path_tag_names=$(echo "$OUTPUTS_JSON" | jq 'with_entries(select(.key | endswith("--tag_name")) | .key |= rtrimstr("--tag_name"))')
echo "Raw value of \$path_tag_names:"
echo "$path_tag_names"
echo ""
echo "Writing to GITHUB_OUTPUT..."
echo "path_tag_names=$path_tag_names" >> "$GITHUB_OUTPUT_WITHOUT_C"
echo "Contents of GITHUB_OUTPUT file (each line is parsed separately by GitHub Actions):"
cat -n "$GITHUB_OUTPUT_WITHOUT_C"
echo ""
echo "Line count: $(wc -l < "$GITHUB_OUTPUT_WITHOUT_C")"
echo ""

# Simulate GitHub Actions parser: every line must match name=value
echo "Simulating GitHub Actions parser (every line must match 'name=value'):"
line_num=0
all_ok=true
while IFS= read -r line; do
  line_num=$((line_num + 1))
  if [[ "$line" =~ ^[A-Za-z_][A-Za-z0-9_-]*= ]]; then
    echo "  Line $line_num: OK    -> '$line'"
  else
    echo "  Line $line_num: ERROR -> '$line'"
    all_ok=false
  fi
done < "$GITHUB_OUTPUT_WITHOUT_C"
if $all_ok; then echo "Result: PASS"; else echo "Result: FAIL - Invalid format error!"; fi

echo ""
echo "========================================"
echo ""

echo "=== WITH -c ==="
path_tag_names=$(echo "$OUTPUTS_JSON" | jq -c 'with_entries(select(.key | endswith("--tag_name")) | .key |= rtrimstr("--tag_name"))')
echo "Raw value of \$path_tag_names:"
echo "$path_tag_names"
echo ""
echo "Writing to GITHUB_OUTPUT..."
echo "path_tag_names=$path_tag_names" >> "$GITHUB_OUTPUT_WITH_C"
echo "Contents of GITHUB_OUTPUT file (each line is parsed separately by GitHub Actions):"
cat -n "$GITHUB_OUTPUT_WITH_C"
echo ""
echo "Line count: $(wc -l < "$GITHUB_OUTPUT_WITH_C")"
echo ""

echo "Simulating GitHub Actions parser (every line must match 'name=value'):"
line_num=0
all_ok=true
while IFS= read -r line; do
  line_num=$((line_num + 1))
  if [[ "$line" =~ ^[A-Za-z_][A-Za-z0-9_-]*= ]]; then
    echo "  Line $line_num: OK    -> '$line'"
  else
    echo "  Line $line_num: ERROR -> '$line'"
    all_ok=false
  fi
done < "$GITHUB_OUTPUT_WITH_C"
if $all_ok; then echo "Result: PASS"; else echo "Result: FAIL - Invalid format error!"; fi

rm "$GITHUB_OUTPUT_WITHOUT_C" "$GITHUB_OUTPUT_WITH_C"
