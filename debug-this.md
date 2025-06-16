# Debug This Command

When I say `/debug-this [description]`:

1. Search for your CLAUDE: comments in the relevant area
2. Check what assumptions you made
3. Trace the data flow
4. Look for recent changes
5. Add debug logging
6. Fix the issue
7. Document what was wrong for next time

Add debugging helpers:
- Console logs with CLAUDE_DEBUG prefix
- State snapshots before/after changes  
- Error boundaries with context
- Assertion checks for assumptions

Priority: Fix it fast, document why it broke.