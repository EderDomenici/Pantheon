# Command: /pantheon:discuss

## 1. Overview
* **Description:** Initiates an interactive conversation between the developer and Zeus (the Orchestrator) to detail the system requirements, stack, linting sensors, and specific business rules.
* **Responsible Agent:** Zeus
* **Runtimes Target:** Claude Code, Codex

## 2. Pre-conditions
* None. This is the entry point of the project phase lifecycle.

## 3. Inputs
* Developer prompts and instructions.
* References to any initial designs or documents.

## 4. Execution Sequence
1. **Developer Invocations:** The developer executes `/pantheon:discuss` in the chat window.
2. **Zeus Interview:** Zeus asks structured questions about:
   - Target stack and architectures.
   - Quality gates (compilation, linter, test runner).
   - Core functional requirements and files.
3. **Spec Drafting:** Zeus aggregates the inputs and writes them into a unified specification file.
4. **Validation:** Zeus ensures all fields required by the spec template are populated.

## 5. Outputs
* **`SPEC.md`**: The official, complete specification document for the phase.
