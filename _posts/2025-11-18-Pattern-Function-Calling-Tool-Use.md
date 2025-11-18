---
layout: post
title: 'Pattern: Function Calling (Tool Use)'
date: 2025-11-18
tags: [AgenticDesignPatterns]
---

## Pattern: Function Calling (Tool Use)

This pattern enables AI agents to extend their capabilities by interacting with external functions and services, as demonstrated by models like Anthropic's Claude [1](https://www.anthropic.com/news/claude-tool-use).

1.  **Pattern Name:** Function Calling (Tool Use)
2.  **Intent:** To empower an AI agent to extend its capabilities beyond its inherent knowledge and reasoning by dynamically invoking and orchestrating external tools or functions.
3.  **Motivation:** An AI assistant is asked to find the current weather for a city or book a flight. Its internal knowledge is insufficient or outdated. Without external tools, it would fail or hallucinate. By integrating with a "weather API" or "flight booking service," the agent can accurately fulfill the request, leveraging specialized external functionality [1](https://www.anthropic.com/news/claude-tool-use).
4.  **Applicability:** This pattern is applicable when an AI agent needs to:
    *   Access real-time information not present in its training data.
    *   Perform specific actions in external systems (e.g., send emails, update databases, control IoT devices).
    *   Execute complex computations that are better handled by specialized services.
    *   Ground its responses in factual, external data to reduce hallucination [1](https://www.anthropic.com/news/claude-tool-use).
5.  **Structure:**

<pre class="mermaid">
graph TD
    User[User Prompt] --> Agent[AI Agent / LLM]
    Agent -- "1. Identifies need for tool & parameters" --> ToolOrchestrator[Tool Orchestrator]
    ToolOrchestrator -- "2. Queries for tool definition" --> ToolRegistry[Tool Registry]
    ToolRegistry -->|Tool Schema| ToolOrchestrator
    ToolOrchestrator -- "3. Invokes with parameters" --> ExternalTool[External Tool/API]
    ExternalTool -->|Result| ToolOrchestrator
    ToolOrchestrator -- "4. Provides result to Agent" --> Agent
    Agent -- "5. Generates final response" --> User[User Response]
</pre>

6.  **Participants:**
    *   **AI Agent (LLM):** The core intelligent entity responsible for understanding user intent, reasoning, and generating responses. It identifies when external tools are required and determines the necessary parameters.
    *   **Tool Orchestrator:** A component that acts as an intermediary. It receives requests from the AI Agent to use a tool, selects the appropriate tool, manages its invocation, and processes the output before returning it to the Agent [1](https://www.anthropic.com/news/claude-tool-use). This is typically the application code wrapping the LLM.
    *   **Tool Registry:** A catalog or database containing descriptions, schemas, and invocation details for all available external tools. This allows the Orchestrator to discover and understand how to use tools, and for the Agent to be aware of its capabilities.
    *   **External Tool/API:** A specific function, API endpoint, or service that performs a well-defined operation (e.g., a weather API, a database query function, a calculator service).
7.  **Collaborations:**
    1.  The **AI Agent** receives a task and, through its reasoning process, determines that an external tool is necessary to complete it.
    2.  The **AI Agent** communicates the intent and required parameters to the **Tool Orchestrator**, often in a structured format like JSON.
    3.  The **Tool Orchestrator** consults the **Tool Registry** to validate and identify the most suitable **External Tool** based on the Agent's request.
    4.  The **Tool Orchestrator** invokes the selected **External Tool** with the necessary parameters.
    5.  The **External Tool** executes its function and returns a result to the **Tool Orchestrator**.
    6.  The **Tool Orchestrator** processes (e.g., parses, summarizes) the tool's output and returns it to the **AI Agent**.
    7.  The **AI Agent** incorporates the tool's result into its reasoning and generates a final response or proceeds with the next step in the workflow.
8.  **Consequences:**
    *   **Benefits:** Significantly extends the AI Agent's capabilities beyond its training data, improves accuracy and factual grounding, enables real-time interaction with the world, promotes modularity and reusability of tools, and allows for easier updates of capabilities without retraining the core model [1](https://www.anthropic.com/news/claude-tool-use).
    *   **Drawbacks:** Introduces complexity in managing tool definitions and orchestrations, requires robust error handling for tool failures, poses security risks if tool access is not properly managed, can introduce latency due to network calls, and requires careful prompt engineering for effective tool selection.
9.  **Implementation Considerations:**
    *   Define clear, machine-readable schemas (e.g., OpenAPI or JSON Schema) for tool descriptions to facilitate automated parsing and invocation by the LLM [1](https://www.anthropic.com/news/claude-tool-use).
    *   Implement robust error handling and retry mechanisms for tool invocations. Plan for API failures, invalid parameters, or unexpected outputs.
    *   Ensure strict access control and security measures for tools, especially those interacting with sensitive data or performing destructive actions. Sanitize all inputs and consider requiring user confirmation for critical operations.
    *   Utilize observability tools to monitor tool usage, performance, and failures, similar to MLOps practices [2](https://www.thoughtworks.com/insights/articles/mlops-lifecycle-guide-orchestrating-machine-learning-workflows.html). This is crucial for debugging and optimization.
    *   Employ prompt engineering techniques to guide the AI Agent in selecting the correct tool and formulating appropriate inputs. The system prompt should clearly define the agent's purpose and how it should leverage its tools.
    *   Consider feature toggles for safely rolling out new tools or tool versions, allowing for controlled releases and A/B testing [3](https://martinfowler.com/articles/featureToggles.html).
10. **Related Patterns:**
    *   **Event-Driven Architecture [4](https://martinfowler.com/articles/enterpriseIntegrationPatterns/EventDrivenArchitecture.html):** Tool invocations and results can be modeled as events, allowing for asynchronous and loosely coupled agent interactions, which is especially useful for long-running tasks.
    *   **Microservices [5](https://www.thoughtworks.com/insights/articles/microservices-a-definition-of-this-new-architectural-term):** External Tools can often be implemented as microservices, promoting independent deployment, scalability, and ownership.
    *   **Bounded Context [6](https://martinfowler.com/bliki/BoundedContext.html):** Tools often operate within specific bounded contexts, helping to manage complexity and data consistency by defining clear boundaries for each tool's domain model.
    *   **Command Query Responsibility Segregation (CQRS) [7](https://martinfowler.com/bliki/CQRS.html):** Tools might perform "commands" (state changes like `send_email`) or "queries" (information retrieval like `get_weather`), which can be segregated for optimized performance and security.
    *   **Evolutionary Architecture [8](https://www.thoughtworks.com/insights/articles/evolutionary-architecture.html):** The agentic system's architecture should allow for the easy addition, modification, or removal of tools as new capabilities emerge, without requiring a complete redesign.

## References
[1] Anthropic. (n.d.). *Introducing Claude's Tool Use*. Retrieved from https://www.anthropic.com/news/claude-tool-use

[2] Thoughtworks. (n.d.). *The MLOps lifecycle: A guide to orchestrating machine learning workflows*. Retrieved from https://www.thoughtworks.com/insights/articles/mlops-lifecycle-guide-orchestrating-machine-learning-workflows.html

[3] Fowler, M. (n.d.). *Feature Toggles (aka Feature Flags)*. Retrieved from https://martinfowler.com/articles/featureToggles.html

[4] Fowler, M. (n.d.). *Event-Driven Architecture*. Retrieved from https://martinfowler.com/articles/enterpriseIntegrationPatterns/EventDrivenArchitecture.html

[5] Thoughtworks. (n.d.). *Microservices: A definition of this new architectural term*. Retrieved from https://www.thoughtworks.com/insights/articles/microservices-a-definition-of-this-new-architectural-term

[6] Fowler, M. (n.d.). *Bounded Context*. Retrieved from https://martinfowler.com/bliki/BoundedContext.html

[7] Fowler, M. (n.d.). *Command Query Responsibility Segregation (CQRS)*. Retrieved from https://martinfowler.com/bliki/CQRS.html

[8] Thoughtworks. (n.d.). *Evolutionary Architecture*. Retrieved from https://www.thoughtworks.com/insights/articles/evolutionary-architecture.html