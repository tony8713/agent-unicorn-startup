#!/bin/bash
# Autonomous Unicorn Loop - Runs every hour

set -e

REPO_DIR="/root/agent-unicorn-startup"
LOG_DIR="/root/agent-unicorn-startup/logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/run_$TIMESTAMP.log"

# Create log directory
mkdir -p "$LOG_DIR"

# Log everything
exec 1> >(tee -a "$LOG_FILE")
exec 2>&1

echo "=================================="
echo "🦄 AUTONOMOUS UNICORN LOOP START"
echo "=================================="
echo "Time: $(date)"
echo "Iteration: $TIMESTAMP"
echo ""

cd "$REPO_DIR"

# The prompt that gets sent to the AI
cat << 'EOF' > /tmp/unicorn_prompt.txt
🦄 AUTONOMOUS UNICORN - HOURLY ITERATION

You are running your autonomous loop. Follow the workflow in JOB.md:

1. REVIEW: Read PROGRESS.md, BUSINESS_PLAN.md, ROADMAP.md, recent commits
2. REFLECT: What worked? What didn't? Are we on the right path?
3. DECIDE: ITERATE, PIVOT, CONTINUE, RESEARCH, or SHIP?
4. EXECUTE: Do the work (code, research, build, deploy)
5. DOCUMENT: Update PROGRESS.md and commit

Focus: Build something people/agents want in crypto. No scams. Make money.

What will you do this iteration?
EOF

echo "📋 Prompt prepared. Ready for AI execution."
echo ""
echo "To manually trigger, run:"
echo "  cat /tmp/unicorn_prompt.txt"
echo ""
echo "This would integrate with an AI API in production."
echo "For now, this confirms the cron job is working."
echo ""

# Git pull to get any remote changes
echo "🔄 Syncing with remote..."
git pull origin main 2>/dev/null || echo "No remote changes"

echo ""
echo "=================================="
echo "✅ Loop iteration complete"
echo "Next run: $(date -d '+1 hour')"
echo "=================================="
