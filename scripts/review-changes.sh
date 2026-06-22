#!/bin/bash
# Visual review script - shows only source files

echo "=========================================="
echo "   Visual Review of Changes"
echo "=========================================="
echo ""

# 1. Show directory structure (source files only)
echo "=== Directory Structure ==="
echo ""
echo "app/"
find app/ -name "*.py" -type f | sed 's|^app/|  |' | sort
echo ""
echo "tests/"
find tests/ -name "*.py" -type f | sed 's|^tests/|  |' | sort
echo ""

# 2. Show modified/new files in git
echo "=== Git Status ==="
git status --short
echo ""

# 3. Show app files preview
echo "=== App Source Files Preview ==="
for file in $(find app/ -name "*.py" -type f | sort); do
    echo ""
    echo "┌─────────────────────────────────────"
    echo "│ File: $file"
    echo "└─────────────────────────────────────"
    head -15 "$file" | sed 's/^/  /'
    line_count=$(wc -l < "$file")
    if [ "$line_count" -gt 15 ]; then
        echo "  ... ($((line_count - 15)) more lines)"
    fi
done
echo ""

# 4. Show test files preview
echo "=== Test Source Files Preview ==="
for file in $(find tests/ -name "*.py" -type f | sort); do
    echo ""
    echo "┌─────────────────────────────────────"
    echo "│ File: $file"
    echo "└─────────────────────────────────────"
    head -15 "$file" | sed 's/^/  /'
    line_count=$(wc -l < "$file")
    if [ "$line_count" -gt 15 ]; then
        echo "  ... ($((line_count - 15)) more lines)"
    fi
done
echo ""

# 5. Show README commands section
echo "=== README Commands ==="
grep -A 3 "python -m" README.md | head -25
echo ""

# 6. Summary
echo "=========================================="
echo "   Review Complete"
echo "=========================================="
echo ""
echo "Files to commit:"
git status --short | grep -v "__pycache__" | grep -v ".pyc"