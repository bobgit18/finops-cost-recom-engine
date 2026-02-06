#!/bin/bash

REPO="bobgit18/finops-cost-recom-engine"

echo "Fetching all issue numbers with FinOps labels..."

ISSUES=$(gh issue list --repo $REPO | grep -oP '#\\K[0-9]+')

echo "Issues to delete:"
echo $ISSUES

for ISSUE in $ISSUES; do
  echo "Deleting issue #$ISSUE ..."
  gh issue delete $ISSUE --repo $REPO --yes
done

echo "Cleanup complete."
