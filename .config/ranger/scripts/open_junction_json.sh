#!/bin/bash
# Open a JSON file with the junction_visualizer if its structure matches the
# expected schema (output of build_critical_junction_json_v2.py).  Otherwise
# fall back to nvim.
#
# Schema match rule: the file must contain BOTH `original_unblended_segments`
# AND at least one of {li2025_g3_blends_in_fillet_region,
# li2025_g2_blends_in_fillet_region, biarc_blends_in_fillet_region}.

set -u

FILE="$(realpath "${1:-}")"
if [[ -z "${FILE}" || ! -f "${FILE}" ]]; then
    exec nvim "${1:-}"
fi

VISUALIZER="/home/jakub/Documents/tormach/pathpilot.worktrees/jakub/li2025-simr-claude-in-docker/junction_web_viewer.py"

# Test for the junction JSON structure.  jq's -e exits 0 on truthy result.
if [[ -x "$(command -v jq)" ]] \
   && jq -e '
        (.original_unblended_segments != null)
        and (
              (.li2025_g3_blends_in_fillet_region != null)
           or (.li2025_g2_blends_in_fillet_region != null)
           or (.biarc_blends_in_fillet_region    != null)
        )
     ' "${FILE}" >/dev/null 2>&1
then
    # Generate self-contained HTML and open in default browser.
    # setsid+disown so ranger isn't blocked by the browser-launch process.
    if [[ -f "${VISUALIZER}" ]]; then
        setsid python3 "${VISUALIZER}" "${FILE}" >/dev/null 2>&1 &
        disown 2>/dev/null || true
        exit 0
    fi
fi

# Fallback: hand off to nvim.
exec nvim "${FILE}"
