/**
 * Test the workflow system
 * 
 * Run with: node test-workflow.js
 */

const { orchestrator } = require('./workflow');

async function testGreenfield() {
  console.log('=== Testing Greenfield Workflow ===\n');

  const userRequest = 'Build a React todo app with TypeScript';
  const context = {
    projectPath: null, // No existing code
    scope: 'MVP',
    users: 'Individual users',
    constraints: 'Must work offline',
    successCriteria: 'Users can add, complete, and delete todos'
  };

  try {
    const result = await orchestrator.execute(userRequest, context);
    
    console.log('\n=== Workflow Complete ===');
    console.log(`Workflow Type: ${result.workflowType}`);
    console.log(`Execution Time: ${result.executionTime}ms`);
    console.log(`Phases Executed: ${result.workflow.phases.join(' → ')}`);
    console.log(`\nPhase Results:`);
    
    Object.entries(result.phaseResults).forEach(([phase, result]) => {
      console.log(`\n${phase}:`);
      console.log(JSON.stringify(result, null, 2));
    });

    console.log('\n✅ Greenfield workflow test PASSED');
    return true;
  } catch (error) {
    console.error('\n❌ Greenfield workflow test FAILED');
    console.error('Error:', error.message);
    return false;
  }
}

// Run test
testGreenfield().then(success => {
  process.exit(success ? 0 : 1);
});
