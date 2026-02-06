#!/bin/bash

REPO="bobgit18/finops-cost-recom-engine"

echo "----------------------------------------"
echo " CLEANUP: Deleting all FinOps-related issues"
echo "----------------------------------------"

# Fetch all issues with any of the FinOps labels
ISSUES=$(gh issue list --repo "$REPO" | grep -oP '#\\K[0-9]+')

if [ -z "$ISSUES" ]; then
  echo "No FinOps-related issues found. Repository is already clean."
  exit 0
fi

echo "Issues to delete: $ISSUES"
echo ""

for ISSUE in $ISSUES; do
  echo "Deleting issue #$ISSUE ..."
  gh issue delete "$ISSUE" --repo "$REPO" --yes
done

echo ""
echo "----------------------------------------"
echo " CLEANUP COMPLETE — All FinOps issues deleted"
echo "----------------------------------------"
