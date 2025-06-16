#(1st version, dont reccomend at all) Solo Developer Configuration

## Working Style
- I work alone, so skip team coordination stuff
- I prefer working code over documentation
- Move fast, refactor later (but keep it clean)
- I'll handle deployment and DevOps myself

## My Preferences
- Explain complex parts briefly
- Skip obvious comments
- Just show me what changed
- If it works, ship it
- I know the codebase, don't over-explain

## Speed Optimizations
- Assume I know the basics
- Get straight to implementation
- Bundle related changes together
- Run all tests at the end, not after each change
- I'll handle git commits myself

## My Stack
<!-- Update with your actual stack -->
- Frontend: React/Next.js with TypeScript
- Backend: Node.js/Python APIs  
- Database: PostgreSQL/MongoDB
- Deployment: Vercel/Railway/AWS

## Common Tasks
```bash
# My aliases
alias gp='git push'
alias gc='git commit -am'
alias nr='npm run'
alias py='python'
```

## Workflow
1. I describe what I want
2. You implement it fast
3. Show me the core changes
4. I'll test and deploy

## What I DON'T Need
- Long explanations of what you did
- Teaching me basics
- Asking permission for obvious fixes
- Separate commits for tiny changes
- Extensive documentation

## What I DO Need
- Working code FAST
- Heads up on breaking changes
- Security issues flagged
- Performance problems noted
- "THINK HARDER" for architecture decisions

## My Coding Style
- Functional > Classes
- Async/await everywhere
- Early returns
- Descriptive variable names
- Minimal dependencies

## Quick Patterns
<!-- Add your personal patterns -->
```javascript
// My API pattern
export const fetchData = async (endpoint) => {
  try {
    const res = await fetch(`${API_URL}/${endpoint}`)
    if (!res.ok) throw new Error(res.statusText)
    return await res.json()
  } catch (err) {
    console.error(err)
    throw err
  }
}
```

## Just Build It Mode
When I say "just build it":
- Skip the planning discussion
- Implement the obvious solution
- Make it work first
- We'll refine later if needed

Remember: I'm a developer who knows what I want. Less talk, more code.
