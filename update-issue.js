const { LinearClient } = require('@linear/sdk');

const client = new LinearClient({
  apiKey: process.env.LINEAR_API_KEY
});

async function startWork() {
  // Get the issue
  const issues = await client.issues({
    filter: { number: { eq: 33 } }
  });
  
  const issue = issues.nodes[0];
  if (!issue) {
    console.log('Issue BON-33 not found');
    return;
  }
  
  // Get "In Progress" state
  const team = await client.team('BON');
  const states = await team.states();
  const inProgressState = states.nodes.find(s => s.name === 'In Progress');
  
  // Update issue to In Progress and assign to me
  await issue.update({
    stateId: inProgressState.id
  });
  
  // Add a comment about starting work
  await client.createComment({
    issueId: issue.id,
    body: '🚀 Starting work on authentication system.\n\n**Plan:**\n1. Set up Express server with TypeScript\n2. Implement GitHub OAuth\n3. JWT token generation\n4. Protected route middleware\n5. User session management\n\nWill post updates hourly on progress.'
  });
  
  console.log('✅ Issue BON-33 moved to In Progress and comment added');
}

startWork().catch(console.error);
