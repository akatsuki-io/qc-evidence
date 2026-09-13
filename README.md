# qc-evidence

Screenshots / GIFs proving a QC test case or bug fix. One branch per task (bug id, scope id, or lane name), files at the branch root, named `<task>-<nn>-<state>.png`.

Push with `~/.fillr-evidence/push-evidence.sh <branch> <file>...` — it prints the raw links to paste into the PR body / sheet dev-note.
