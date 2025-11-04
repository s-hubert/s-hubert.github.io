---
layout: post
title: 'Pattern: Agentic System (Prediction-Based)'
date: 2025-11-04
tags: [AgenticDesignPatterns]
---

## Pattern: Agentic System (Prediction-Based)

### 1. Pattern Name and Classification

- Pattern Name: Agentic System (Prediction-Based)
- Classification: Orchestration & Workflow Patterns

### 2. Intent

The core intent of the Agentic System (Prediction-Based) pattern is to design an automation system that makes decisions based on real time predictions, powered by a model.

This approach enables the system to adapt its behavior and apply its capabilities in a generalized way to tasks where predefined, codified conditions are infeasible or impractical to create. The core technical distinction that defines this pattern is its decision-making mechanism: workflow automations decide based on predefined conditions, powered by code, whereas agentic automations decide based on predictions. This allows the system to handle ambiguity and navigate complexity in a way that mirrors human judgment.

This intent directly addresses the challenge of automating complex, dynamic work that has historically required human intervention.

### 3. Also Known From

The Agentic System (Prediction-Based) pattern can be understood through an organizational parallel that contrasts two distinct approaches to task execution in a hospital setting.

1. The Automated Medication Dispenser (Condition-Based Workflow): This system represents traditional, condition-based automation. It follows exact, predefined protocols with perfect precision and no variation. Given a prescription—Drug: Amoxicillin, Dose: 500mg—it executes a rigid set of rules (IF/ELSE logic) to dispense the correct number of tablets. There is no interpretation or judgment; the process is entirely deterministic.
2. The Nurse Doing Rounds (Prediction-Based Agentic System): This role represents the agentic system. A nurse's goal is patient care, but the path to achieving it cannot be scripted with rigid rules. The nurse makes continuous judgment calls and predictions based on context and experience; they prioritize which patient to check based on a combination of scheduled tasks and real-time observations, recognize subtle signs of distress not captured by monitors, and adapt their approach based on each patient's communication style and needs. This work is adaptive, contextual, and predictive.

This pattern, therefore, mimics the adaptive, contextual decision-making of a human expert rather than the rigid, mechanical execution of a pre-programmed machine.

### 4. Motivation (Forces)

The central problem this pattern solves is that traditional, condition-based workflow automation hits its limits when faced with certain types of complexity. Such systems are highly effective for structured, predictable tasks but fail when the work is messy, ambiguous, or requires interpretation. This pattern is motivated by the need to automate tasks that resist standardization.

The following scenarios describe the primary forces that necessitate the use of a prediction-based agentic system:

1. When Decisions Grow Exponentially Some processes involve so many variables and edge cases that mapping them with predefined "IF/ELSE" logic becomes practically impossible. As new factors are introduced, the number of required conditions grows exponentially, making the workflow brittle, unmanageable, and often "more complex than the work it is supposed to automate." An agentic system handles this by using a model's generalized understanding to navigate this complexity without needing every possible path to be explicitly coded.
2. When Decisions Rely on Meaning, Not Structure Traditional workflows operate on syntax and structured data (e.g., fields in a form, specific keywords). However, much of business communication and knowledge work relies on semantics—the meaning, context, implication, and nuance embedded in unstructured, human-generated text. An agentic system is motivated by the need to interpret this semantic layer, connecting disparate pieces of information to form a holistic understanding and make informed predictions.
3. When Optimization Paths Emerge from Context For certain complex tasks, the most efficient or effective path cannot be planned in advance. The optimal approach is discovered during execution as new information becomes available. A rigid workflow can only follow a predefined path, which is often inefficient or incomplete. An agentic system is motivated by the need to dynamically adapt its strategy based on contextual discoveries, optimizing its approach in real-time much like a human researcher would.

### 5. Applicability

Use this pattern in the following situations:

- Automating tasks where the number of variables and edge cases makes rule-based mapping impractical.
- Processes that require the interpretation of semantic meaning and nuance from unstructured, human-generated data.
- Scenarios where the optimal execution path is unknown at the start and must be adapted based on information discovered during the task.
- Automating what is often called "undefinable" or "judgment-based work at scale."
- When empowering non-technical domain experts to configure and guide automation using natural language is a primary goal for tasks that resist standardization.

In summary, this pattern is best applied to complex, dynamic, and semantically-rich problems that require an adaptive, intelligent approach to automation.

### 6. Structure

The fundamental structure of a prediction-based agentic system is not a linear, predefined sequence of steps. Instead, its architecture is dynamic and centered around a model-powered decision-making engine that operates in a continuous loop of observation, prediction, and action. Unlike a workflow that follows a static path, this system's structure is fluid. It learns and applies patterns from its underlying Large Language Model (LLM) to adapt its approach based on discoveries made during execution. This allows it to handle unexpected inputs and even "self-heal" by learning from errors and retrying with a different approach. This dynamic structure is realized through a specific collaborative flow between its key participants.

### 7. Participants

- The Agent (or Agentic System): The central component. Its role is to interpret goals and make judgment calls by predicting the next best action.
- The Model: The underlying LLM that provides the core reasoning and prediction capabilities.
- Tools/Integrations: External functions, APIs, or data sources. Their role is to extend the agent's capabilities beyond its static knowledge.
- User/Domain Expert: The initiator of the task. Their role is to provide the high-level goal and offer iterative feedback to guide and refine the agent's behavior, allowing the people "who understand the work best" to "directly improve how it's automated."
- Context/Memory: The mechanisms for storing short- and long-term information, enabling the agent to make context-aware predictions.

These participants work in concert to create a system capable of autonomous, goal-oriented action.

### 8. Collaboration

The interaction flow proceeds as follows:

1. The User provides a high-level goal to the Agent.
2. The Agent uses its Model to interpret the goal and predict the next best action, which often involves selecting a Tool.
3. The Agent executes the action (e.g., calls the tool) and observes the result.
4. The result updates the agent's internal Context/Memory.
5. The Agent re-evaluates the goal in light of the new context and repeats the prediction-action-observation loop until the task is complete.

### 9. Consequences

The Agentic System (Prediction-Based) pattern offers unprecedented adaptability but does so by sacrificing the determinism and precision of traditional workflows. This section evaluates the strategic benefits and risks an architect must weigh before implementation, particularly when automating judgment-based work at scale.

Benefits

- Automation of Complex Work: Enables the automation of ambiguous, nuanced, and "undefinable" tasks that were previously the exclusive domain of human judgment.
- High Resilience: The system is highly resilient to changes in external systems (e.g., API schema updates, UI redesigns). Unlike brittle workflows that break on syntactic changes, agents operate on semantic meaning and can adapt as long as the underlying intent remains understandable.
- Democratized Automation: Significantly lowers the technical barrier to creating automations. This is made possible by the pattern's support for "gradient configuration," allowing domain experts to refine agent behavior through iterative, natural language feedback.
- Emergent Cooperation: In a multi-agent environment, this pattern facilitates a powerful compound effect. Because agents collaborate via semantic understanding, they can solve problems in unplanned ways. The network becomes smarter than the sum of its parts, and the organization's automation surface area grows exponentially.

Trade-offs and Risks

- Reduced Determinism: Outputs are less predictable compared to rule-based workflows due to the probabilistic nature of LLMs.
- Lower Precision: For tasks where perfect, repeatable, "molecular-level" accuracy is paramount, this pattern may be less precise than a rigidly coded workflow.
- Risk of Hallucination: Carries an inherent risk of model hallucination or incorrect predictions, necessitating strong governance patterns like guardrails and Human-in-the-Loop.
- Inefficiency for Simple Tasks: Can be less cost- and time-efficient for simple, highly structured tasks where a traditional workflow would be superior.

### 10. Implementation

The fundamental implementation choice is to build a system that makes decisions based on model-driven predictions, not hard-coded conditions.

The implementation typically follows this adaptive execution loop:

1. Goal Definition: The system receives a high-level goal or task from a user.
2. Tool Provisioning: The agent is given access to a defined set of external tools and integrations.
3. Adaptive Execution Loop: The agent continuously cycles through:

- Assessing its current state against the overall goal.
- Using the LLM to predict the most logical next action or tool to use.
- Executing the predicted action and observing the outcome.
- Updating its internal state and memory with the new information.

4. Iterative Refinement: The implementation supports "gradient configuration," allowing its behavior to be improved over time with natural language feedback from a domain expert, rather than requiring code changes.

### 11. Known Uses

- Dynamic Lead Scoring: Analyzing hundreds of subtle, unstructured signals—such as hiring patterns, technology stack, leadership changes, and market timing—to predict lead quality in a way that is impossible to map with fixed rules.
- Multi-Channel Customer Relationship Management: Synthesizing customer interactions across email, support tickets, and sales calls to form a semantic understanding of a customer's journey and intent, allowing it to predict deal-critical risks or upsell opportunities.
- High-Quality Research: Dynamically adapting a research strategy for a task like M&A analysis. An agent might begin with financial analysis but pivot to focus on intellectual property law or regulatory risk upon discovering new, critical information during the process.

### 12. Related Patterns

- Function Calling (Tool Use): An essential enabling pattern. The agentic system predicts which function to call and with what parameters to progress toward its goal.
- Orchestrator-Worker Model: A specific, advanced implementation of this pattern where a central agent predicts and delegates sub-tasks to a pool of specialized worker agents.
- Emergent Cooperation: A beneficial consequence of this pattern in a multi-agent environment. The agents' predictive and semantic understanding allows them to collaborate in novel, unplanned ways.
- Human-in-the-Loop (HIL): A crucial governance pattern often used in conjunction with this one. It requires human approval for critical actions predicted by the agent, mitigating the risk of non-deterministic behavior.
- Sequential Task Execution: A contrasting workflow pattern. This pattern follows a predefined, linear sequence of steps, whereas the Agentic System (Prediction-Based) pattern determines its steps dynamically.
