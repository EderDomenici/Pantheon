#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const rootDir = process.cwd();
const pantheonDir = path.join(rootDir, '.pantheon');
const phasesDir = path.join(rootDir, 'phases');

let metrics = {
  totalTasks: 0,
  completedTasks: 0,
  totalRetries: 0,
  athenaRejections: 0,
  totalPhases: 0,
};

function analyzePhase(phasePath) {
  metrics.totalPhases++;

  // Read Execution Summary
  const summaryPath = path.join(phasePath, 'EXECUTION-SUMMARY.md');
  if (fs.existsSync(summaryPath)) {
    const content = fs.readFileSync(summaryPath, 'utf8');
    // Count retries: look for lines mentioning "Retries:" or "Attempt X/3"
    const retriesMatches = content.match(/Attempt \d\/3/g) || [];
    metrics.totalRetries += retriesMatches.length;

    const completedMatches = content.match(/Status:\s*(DONE|SUCCESS)/ig) || [];
    metrics.completedTasks += completedMatches.length;
  }

  // Read Audit Report
  const auditPath = path.join(phasePath, 'AUDIT.md');
  if (fs.existsSync(auditPath)) {
    const content = fs.readFileSync(auditPath, 'utf8');
    if (content.includes('VERDICT: REJECTED') || content.includes('Status: REJECTED')) {
      metrics.athenaRejections++;
    }
  }

  // Count Tasks in Plan
  const planPath = path.join(phasePath, 'PLAN.md');
  if (fs.existsSync(planPath)) {
    const content = fs.readFileSync(planPath, 'utf8');
    const tasksMatches = content.match(/### Task:|### \[T\d+\]/g) || [];
    metrics.totalTasks += tasksMatches.length;
  }
}

function run() {
  console.log("📊 Analyzing Pantheon Framework Metrics...\n");

  if (fs.existsSync(phasesDir)) {
    const phases = fs.readdirSync(phasesDir).filter(f => fs.statSync(path.join(phasesDir, f)).isDirectory());
    for (const phase of phases) {
      analyzePhase(path.join(phasesDir, phase));
    }
  } else {
    console.log("No phases directory found. Ensure you are running this from the workspace root after executions.");
  }

  console.log("--- Pantheon Performance Report ---");
  console.log(`Total Phases Executed : ${metrics.totalPhases}`);
  console.log(`Total Tasks Planned   : ${metrics.totalTasks}`);
  console.log(`Tasks Completed       : ${metrics.completedTasks}`);
  console.log(`Total Retries (Circuit): ${metrics.totalRetries}`);
  console.log(`Athena Plan Rejections : ${metrics.athenaRejections}`);

  if (metrics.totalTasks > 0) {
    const completionRate = ((metrics.completedTasks / metrics.totalTasks) * 100).toFixed(2);
    console.log(`\n📈 Completion Rate   : ${completionRate}%`);
  }

  const retryRate = metrics.completedTasks > 0 ? (metrics.totalRetries / metrics.completedTasks).toFixed(2) : 0;
  console.log(`🔄 Avg Retries/Task   : ${retryRate}`);
  console.log("-----------------------------------");
}

run();