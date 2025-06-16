# Solo Developer Configuration - Progress & Debug Tracking

## Core Philosophy
- I work alone but need a clear history of what happened
- Every significant change gets a numbered log file
- When shit breaks, I can trace back through the logs
- AI can read previous logs to understand the project evolution

## Progress Tracking System

### Automatic File Creation
After each significant task, create:
```
project/
├── _logs/
│   ├── 001_initial_setup.md
│   ├── 002_add_auth_system.md
│   ├── 003_debug_login_timeout.md
│   ├── 004_add_user_dashboard.md
│   └── 005_fix_memory_leak.md
```

### File Naming Convention
- Progress: `XXX_feature_name.md` (what we built)
- Debugging: `XXX_debug_issue_name.md` (what we fixed)
- Always increment numbers
- Use descriptive names

## Progress File Template
```markdown
# 001 - Initial Setup
Date: 2024-01-15
Type: Feature

## What I Built
- Basic Express server with TypeScript
- PostgreSQL database connection
- User model and migrations

## Key Decisions
- Chose Prisma over TypeORM because better TS support
- Using JWT tokens stored in httpOnly cookies
- Structured as monorepo for future frontend

## Code Locations
- Server entry: src/server.ts
- Database config: src/db/config.ts
- User model: src/models/User.ts

## Assumptions Made
- Users will login with email/password
- PostgreSQL running on default port
- Node 20+ is available

## Commands to Remember
npm run dev - Start dev server
npm run db:migrate - Run migrations
npm run test - Run tests

## Next Steps
- Add authentication endpoints
- Set up refresh token rotation
- Add rate limiting
```

## Debug File Template
```markdown
# 003 - Debug Login Timeout
Date: 2024-01-16
Type: Debug
Related to: 002_add_auth_system.md

## The Problem
Users reporting "Request timeout" when logging in.
Started happening after deploying auth system.

## Investigation
1. Checked logs - seeing 30s timeouts
2. Database queries hanging
3. Found N+1 query in permission loading

## Root Cause
```javascript
// BAD: Was loading permissions in loop
for (const role of user.roles) {
  const perms = await loadPermissions(role.id);
}

// FIXED: Single query with joins
const perms = await loadAllPermissions(user.roleIds);
```

## What I Changed
- Refactored permission loading in src/auth/permissions.ts
- Added index on role_permissions.user_id
- Added query performance logging

## Verification
- Login time: 30s -> 200ms
- Added test case for multiple roles
- Set up query monitoring alert

## Lessons Learned
- Always check query performance with realistic data
- Add logging BEFORE issues happen
- Test with users that have multiple roles
```

## Implementation Rules

### When to Create Logs
1. **Feature Complete**: After implementing any feature
2. **Bug Fixed**: After debugging any issue
3. **Major Refactor**: When changing architecture
4. **Performance Fix**: After optimization
5. **Breaking Change**: When APIs/schemas change

### What to Include
✅ What changed and why
✅ Where the code lives
✅ Assumptions and dependencies
✅ How to test it works
✅ What might break it

### Auto-Generation Helper
```javascript
// Add to your workflow
export function createProgressLog(title: string, type: 'feature' | 'debug') {
  const logs = fs.readdirSync('./_logs');
  const nextNum = String(logs.length + 1).padStart(3, '0');
  const date = new Date().toISOString().split('T')[0];
  const filename = `${nextNum}_${title.toLowerCase().replace(/\s+/g, '_')}.md`;
  
  const template = `# ${nextNum} - ${title}
Date: ${date}
Type: ${type}

## What I ${type === 'feature' ? 'Built' : 'Fixed'}
- 

## Key ${type === 'feature' ? 'Decisions' : 'Changes'}
- 

## Code Locations
- 

## ${type === 'feature' ? 'Assumptions Made' : 'Root Cause'}
- 

## ${type === 'feature' ? 'Next Steps' : 'Verification'}
- 
`;
  
  fs.writeFileSync(`./_logs/${filename}`, template);
  console.log(`Created: _logs/${filename}`);
}
```

## Using Logs for Debugging

### When Something Breaks
```
You: "Login is broken again"
Claude: *reads recent logs*
"I see in 003_debug_login_timeout.md we fixed a similar issue. Let me check if the permission loading changed again..."
```

### When Adding Features
```
You: "Add password reset"
Claude: *reads 002_add_auth_system.md*
"I see the auth system uses JWT in cookies and has these assumptions... I'll build password reset to match."
```

### Project Handoff
```
You: "Summarize what we've built"
Claude: *reads all logs*
"Based on the logs, here's the system evolution..."
```

## Log Search Commands

### Find Related Issues
```bash
# Search all debug logs for timeout issues
grep -l "timeout" _logs/*debug*.md

# Find all auth-related changes
grep -l "auth" _logs/*.md
```

### Generate Summary
```bash
# Quick project status
ls -la _logs/ | tail -10  # Last 10 changes
```

## Integration with Claude

### Starting Work
"Check the _logs/ folder and continue from the last entry"

### After Changes
"Create a log entry for what we just built"

### When Debugging
"Check logs for similar issues before investigating"

## Benefits
1. **Perfect Memory**: Every decision is logged
2. **Fast Debugging**: Search previous issues
3. **Progress Tracking**: See what you built when
4. **AI Context**: Claude understands project history
5. **Solo Timeline**: Your development story

Remember: These logs are YOUR memory. When you come back to a project after 6 months, you'll thank yourself for these breadcrumbs.