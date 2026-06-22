#!/bin/bash
# Pre-commit verification script

echo "=== Pre-Commit Verification ==="
echo ""

# Track pass/fail
PASS=0
FAIL=0

# 1. Check for absolute paths (exclude __pycache__)
echo "1. Checking for absolute paths in source files..."
if grep -r "/Users/" app/ tests/ README.md --exclude-dir=__pycache__ --include="*.py" --include="*.md" 2>/dev/null; then
    echo "   ❌ FAIL: Found absolute paths in source files"
    FAIL=$((FAIL + 1))
else
    echo "   ✅ PASS: No absolute paths in source files"
    PASS=$((PASS + 1))
fi

# 2. Check for home directory references (exclude __pycache__)
echo ""
echo "2. Checking for home directory references..."
if grep -r "~/" app/ tests/ README.md --exclude-dir=__pycache__ --include="*.py" --include="*.md" 2>/dev/null | grep -v "# "; then
    echo "   ⚠️  WARN: Found ~/ references"
    FAIL=$((FAIL + 1))
else
    echo "   ✅ PASS: No ~/ references"
    PASS=$((PASS + 1))
fi

# 3. Check environment.yml for prefix
echo ""
echo "3. Checking environment.yml for prefix..."
if grep "^prefix:" environment.yml > /dev/null 2>&1; then
    echo "   ❌ FAIL: Has prefix line"
    FAIL=$((FAIL + 1))
else
    echo "   ✅ PASS: No prefix line"
    PASS=$((PASS + 1))
fi

# 4. Check for python -m pytest
echo ""
echo "4. Checking README for python -m pytest..."
if grep "python -m pytest" README.md > /dev/null 2>&1; then
    echo "   ✅ PASS: Uses python -m pytest"
    PASS=$((PASS + 1))
else
    echo "   ⚠️  WARN: Check pytest command"
    FAIL=$((FAIL + 1))
fi

# 5. Check for python -m uvicorn
echo ""
echo "5. Checking README for python -m uvicorn..."
if grep "python -m uvicorn" README.md > /dev/null 2>&1; then
    echo "   ✅ PASS: Uses python -m uvicorn"
    PASS=$((PASS + 1))
else
    echo "   ⚠️  WARN: Check uvicorn command"
    FAIL=$((FAIL + 1))
fi

# 6. Verify __pycache__ is gitignored
echo ""
echo "6. Checking __pycache__ is gitignored..."
if git status --porcelain | grep "__pycache__" > /dev/null 2>&1; then
    echo "   ⚠️  WARN: __pycache__ not ignored"
    FAIL=$((FAIL + 1))
else
    echo "   ✅ PASS: __pycache__ properly ignored"
    PASS=$((PASS + 1))
fi

# 7. Run tests
echo ""
echo "7. Running tests..."
if python -m pytest -q; then
    echo "   ✅ PASS: All tests passed"
    PASS=$((PASS + 1))
else
    echo "   ❌ FAIL: Tests failed"
    FAIL=$((FAIL + 1))
fi

# Summary
echo ""
echo "==================================="
echo "Summary: $PASS passed, $FAIL failed"
echo "==================================="

if [ $FAIL -eq 0 ]; then
    echo "✅ All checks passed! Safe to commit."
    exit 0
else
    echo "❌ Some checks failed. Please fix before committing."
    exit 1
fi