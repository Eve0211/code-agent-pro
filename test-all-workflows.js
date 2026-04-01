/**
 * Comprehensive Workflow Tests
 * 
 * Test all 6 workflows to ensure they work correctly.
 * Run with: node test-all-workflows.js
 */

const { orchestrator } = require('./workflow');

// Test cases for each workflow
const testCases = [
  {
    name: 'Greenfield Project',
    request: 'Build a React todo app with TypeScript',
    context: {
      projectPath: null,
      scope: 'MVP',
      users: 'Individual users',
      constraints: 'Must work offline',
      successCriteria: 'Users can add, complete, and delete todos'
    },
    expectedWorkflow: 'greenfield',
    expectedPhases: 7
  },
  {
    name: 'Mature Project',
    request: 'Add authentication to the existing API',
    context: {
      projectPath: '/path/to/project',
      scope: 'Authentication module',
      users: 'API users',
      constraints: 'Must support OAuth2',
      successCriteria: 'Users can authenticate via OAuth2'
    },
    expectedWorkflow: 'mature-project',
    expectedPhases: 8
  },
  {
    name: 'Bug Fix',
    request: 'Fix the login button not working',
    context: {
      projectPath: '/path/to/project'
    },
    expectedWorkflow: 'bug-fix',
    expectedPhases: 5
  },
  {
    name: 'Refactoring',
    request: 'Refactor the authentication module to use dependency injection',
    context: {
      projectPath: '/path/to/project'
    },
    expectedWorkflow: 'refactoring',
    expectedPhases: 7
  },
  {
    name: 'Feature Enhancement',
    request: 'Add dark mode support to the application',
    context: {
      projectPath: '/path/to/project',
      scope: 'UI theme',
      users: 'All users',
      constraints: 'Must persist user preference',
      successCriteria: 'Users can toggle dark mode'
    },
    expectedWorkflow: 'feature-enhancement',
    expectedPhases: 8
  },
  {
    name: 'Quick Fix',
    request: 'Update the copyright year in the footer',
    context: {
      projectPath: '/path/to/project'
    },
    expectedWorkflow: 'quick-fix',
    expectedPhases: 3
  }
];

/**
 * Run all tests
 */
async function runAllTests() {
  console.log('=== Comprehensive Workflow Tests ===\n');

  let passed = 0;
  let failed = 0;

  for (const testCase of testCases) {
    console.log(`\n--- Testing: ${testCase.name} ---`);
    console.log(`Request: "${testCase.request}"`);

    try {
      const result = await orchestrator.execute(testCase.request, testCase.context);

      // Verify workflow type
      if (result.workflowType !== testCase.expectedWorkflow) {
        console.error(`❌ FAILED: Expected workflow "${testCase.expectedWorkflow}", got "${result.workflowType}"`);
        failed++;
        continue;
      }

      // Verify number of phases
      if (result.workflow.phases.length !== testCase.expectedPhases) {
        console.error(`❌ FAILED: Expected ${testCase.expectedPhases} phases, got ${result.workflow.phases.length}`);
        failed++;
        continue;
      }

      // Verify all phases executed
      if (Object.keys(result.phaseResults).length !== testCase.expectedPhases) {
        console.error(`❌ FAILED: Expected ${testCase.expectedPhases} phase results, got ${Object.keys(result.phaseResults).length}`);
        failed++;
        continue;
      }

      console.log(`✅ PASSED`);
      console.log(`   Workflow: ${result.workflowType}`);
      console.log(`   Phases: ${result.workflow.phases.join(' → ')}`);
      console.log(`   Execution Time: ${result.executionTime}ms`);
      passed++;
    } catch (error) {
      console.error(`❌ FAILED: ${error.message}`);
      failed++;
    }
  }

  // Summary
  console.log(`\n\n=== Test Summary ===`);
  console.log(`Total: ${testCases.length}`);
  console.log(`Passed: ${passed}`);
  console.log(`Failed: ${failed}`);
  console.log(`Success Rate: ${((passed / testCases.length) * 100).toFixed(1)}%`);

  if (failed === 0) {
    console.log(`\n✅ All tests PASSED!`);
    return true;
  } else {
    console.log(`\n❌ Some tests FAILED`);
    return false;
  }
}

// Run tests
runAllTests().then(success => {
  process.exit(success ? 0 : 1);
});
