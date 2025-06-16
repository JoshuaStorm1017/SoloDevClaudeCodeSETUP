# Solo Developer Configuration - AI Debugging Optimized

## Core Philosophy
- I work alone but I need clear code for AI collaboration
- Documentation = better AI debugging, not team communication
- When code breaks, I need Claude to understand it fast
- Track what you did so we can unfuck it later

## CRITICAL: Document Your Changes
```javascript
// ALWAYS add these comments when you change something:
// CLAUDE: Added user auth check here - prevents unauthorized access
// CLAUDE: Changed from sync to async - fixes timeout issue
// CLAUDE: Refactored this loop - was causing N+1 queries
```

## My Working Style
- Write code that future Claude can debug
- Leave breadcrumbs for troubleshooting
- Explain WHY, not WHAT (I can see what)
- If you change something, note what it was before

## Documentation I NEED
✅ Why you made a specific choice
✅ What assumptions you made
✅ Potential side effects of changes
✅ Dependencies between components
✅ "This might break if..." warnings

## Documentation I DON'T NEED
❌ How to use basic JavaScript
❌ What a for loop does
❌ Team coordination stuff
❌ Detailed commit messages
❌ API docs for well-known libraries

## Error Prevention
When implementing, always note:
```javascript
// CLAUDE WARNING: This expects userId to be a string, not number
// CLAUDE ASSUMPTION: API returns data in this shape: {id, name, email}
// CLAUDE DEPENDENCY: This breaks if you remove the auth middleware
```

## The "Fix My Fuck-Up" Protocol
When I come back with broken code:
1. Look for your previous CLAUDE comments
2. Check what assumptions might have changed
3. Identify what I probably modified
4. Fix it and document the fix

## Smart Patterns
```javascript
// PATTERN: Error boundaries for debugging
try {
  // complex logic
} catch (error) {
  console.error('CLAUDE: Failed at [specific operation]:', {
    error,
    context: { /* relevant variables */ },
    hint: 'Check if [likely cause]'
  });
  throw error;
}

// PATTERN: State debugging
const updateUser = (newData) => {
  console.log('CLAUDE: User state before:', user);
  // ... update logic
  console.log('CLAUDE: User state after:', user);
};
```

## My Debug Commands
- "Claude, this broke, check your previous changes"
- "What assumptions did you make in the auth system?"
- "Trace through the data flow in this feature"
- "You built this last week, now it's fucked"

## Change Tracking Rules
1. **Before removing code**: Comment it out with explanation
   ```javascript
   // CLAUDE: Removed old validation - replaced with Zod schema below
   // const oldValidation = {...}
   ```

2. **When refactoring**: Keep a trail
   ```javascript
   // CLAUDE: Refactored from class to functional component
   // Previous pattern: class UserList extends Component
   ```

3. **For tricky logic**: Explain the approach
   ```javascript
   // CLAUDE: Using recursive descent here because iterative approach
   // hit stack limits with deep nesting
   ```

## AI Debugging Helpers
```javascript
// Add these utilities to every project
export const claudeDebug = {
  log: (action, data) => {
    console.log(`CLAUDE_DEBUG [${action}]:`, {
      timestamp: new Date().toISOString(),
      data,
      stack: new Error().stack
    });
  },
  
  assert: (condition, message) => {
    if (!condition) {
      throw new Error(`CLAUDE_ASSERT: ${message}`);
    }
  },
  
  checkpoint: (label) => {
    console.log(`CLAUDE_CHECKPOINT: ${label} reached`);
  }
};
```

## When Things Break
I'll come back saying "X is broken" and you should:
1. Search for your CLAUDE comments
2. Check recent changes in that area
3. Look for violated assumptions
4. Trace the data flow
5. Fix and document what went wrong

## State Management = Document Everything
```javascript
// CLAUDE: State shape documentation
// userState = {
//   user: { id, email, name },
//   isLoading: boolean,
//   error: Error | null,
//   lastFetch: timestamp
// }
// 
// MUTATIONS: Only through userActions
// DEPENDENCIES: AuthContext must be provided
```

## The "Why The Fuck" Rule
If future me will ask "why the fuck did Claude do this?" - document it:
```javascript
// CLAUDE: Using setTimeout here because immediate execution
// causes race condition with React's render cycle
setTimeout(() => {
  updateState();
}, 0);
```

## Integration Points
Document where systems connect:
```javascript
// CLAUDE INTEGRATION: This webhook expects:
// - Header: X-Webhook-Secret (from env.WEBHOOK_SECRET)
// - Body: { event, data, timestamp }
// - Response: { success: boolean }
// Fails silently if service is down - check logs
```

Remember: I'm not documenting for other humans. I'm documenting so when shit breaks at 2 AM, you can quickly understand what you built and fix it.