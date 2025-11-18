---
layout: post
title: 'Pattern: Shared Context Observer'
date: 2025-11-18
tags: [AgenticDesignPatterns]
---

### Agentic AI Pattern: Shared Context Observer

1.  **Pattern Name:** Shared Context Observer
2.  **Intent:** To enable multiple, independent agents to react to changes in a shared state or environment without being tightly coupled to the agent or event that caused the change. This pattern establishes a one-to-many dependency where a state change in one object (the context) automatically notifies all dependent agents.
3.  **Motivation:** Consider a multi-agent system managing a complex customer support ticket. A `TriageAgent` first categorizes the ticket and updates its status to "Technical Support." A `TechnicalAgent` must then pick it up, diagnose the issue, and add its findings. Once the `TechnicalAgent` updates the status to "Resolution Proposed," a `CommunicationAgent` needs to draft and send an email to the customer.

    Without a clear pattern, the `TriageAgent` would need to know explicitly about the `TechnicalAgent`. The `TechnicalAgent` would need to know explicitly about the `CommunicationAgent`. This creates a brittle, hard-to-maintain chain of direct dependencies. If a new `AnalyticsAgent` needs to be added to log resolution times, multiple existing agents would need to be modified.

    The Shared Context Observer pattern solves this by decoupling the agents. All agents observe a central `TicketContext` object. When any agent updates the ticket's status, the `TicketContext` notifies all subscribed agents. The `TechnicalAgent` reacts when the status becomes "Technical Support," and the `CommunicationAgent` reacts when it becomes "Resolution Proposed." New agents like the `AnalyticsAgent` can be added simply by having them subscribe to the context, with no changes to the other agents.
4.  **Applicability:** This pattern is useful when:
    *   A change in the state of one object or agent needs to be propagated to other, unknown agents.
    *   A system requires multiple agents to maintain a consistent view of a shared environment or dataset.
    *   The agent initiating a change should not be responsible for knowing which other agents need to be informed.
    *   You want to build a reactive, event-driven system where agents can be added or removed dynamically without affecting the core logic.
5.  **Structure:**

    ```mermaid
    graph TD
        subgraph Setup Phase
            ObserverAgentA[Observer Agent A] -- "Subscribes to" --> SharedContext{Shared Context}
            ObserverAgentB[Observer Agent B] -- "Subscribes to" --> SharedContext
            ObserverAgentC[Observer Agent C] -- "Subscribes to" --> SharedContext
        end

        subgraph Runtime Phase
            ActorAgent[Actor Agent] -- "1. Updates State" --> SharedContext
            SharedContext -- "2. Notifies Subscribers" --> ObserverAgentA
            SharedContext -- "2. Notifies Subscribers" --> ObserverAgentB
            SharedContext -- "2. Notifies Subscribers" --> ObserverAgentC
            ObserverAgentA -- "3. Reacts to Change" --> ActionA((Perform Action A))
            ObserverAgentB -- "3. Reacts to Change" --> ActionB((Perform Action B))
        end
    ```

6.  **Participants:**
    *   **Shared Context (Subject):** A central component that maintains the shared state of interest. It keeps a list of its subscribers (observers) and provides an interface for attaching and detaching them. When its state changes, it notifies all registered observers.
    *   **Observer Agent (Observer):** An agent that needs to react to changes in the `Shared Context`. It implements a standard interface (e.g., an `update` method) that the `Shared Context` calls when a notification is sent.
    *   **Actor Agent (Client):** Any agent or external process that modifies the state of the `Shared Context`. The Actor Agent is not concerned with which agents are observing the context; its only responsibility is to update the state accurately.
7.  **Collaborations:**
    1.  During initialization, one or more **Observer Agents** subscribe to the **Shared Context** to register their interest in state changes.
    2.  An **Actor Agent** interacts with the **Shared Context**, causing its internal state to change.
    3.  The **Shared Context**, upon detecting a state change, iterates through its list of subscribed **Observer Agents**.
    4.  For each subscriber, the **Shared Context** invokes the notification method (e.g., `update()`) on the **Observer Agent**.
    5.  Each **Observer Agent** then executes its own logic in response to the notification, potentially querying the **Shared Context** for more details about the state change before acting.
8.  **Consequences:**
    *   **Benefits:**
        *   **Loose Coupling:** The pattern decouples agents that change state from agents that react to state changes. This is a core principle of good system design [1](https://refactoring.guru/design-patterns).
        *   **Modularity and Extensibility:** New `Observer Agents` can be introduced at any time without modifying the `Shared Context` or the `Actor Agents`. This supports an evolutionary architecture [2](https://www.thoughtworks.com/insights/articles/evolutionary-architecture.html).
        *   **Broadcast Communication:** Provides a clean mechanism for one-to-many communication, simplifying what would otherwise be complex and direct agent-to-agent messaging.
    *   **Drawbacks:**
        *   **Unexpected Cascades:** A single update to the `Shared Context` can trigger a complex and potentially unforeseen cascade of actions across many agents, making the system's behavior difficult to trace and debug.
        *   **Performance Bottlenecks:** If notifications are synchronous, the `Shared Context` can be blocked while waiting for all observers to complete their update logic. A large number of observers can lead to performance degradation.
        *   **State Management Overhead:** The `Shared Context` can become a complex, monolithic entity if not carefully designed. Concurrent updates from multiple `Actor Agents` can introduce race conditions and require sophisticated locking mechanisms.
9.  **Implementation Considerations:**
    *   **Asynchronous Notifications:** Use a message queue or event bus to implement the notification mechanism. This decouples the `Shared Context` from the `Observer Agents` in time, preventing performance bottlenecks and improving system resilience.
    *   **Push vs. Pull Model:** Decide whether the notification message itself contains all the changed data (push) or if it's a simple trigger that requires the observer to query the context for details (pull). The pull model is more flexible but can result in extra communication overhead.
    *   **Granular Subscriptions:** Instead of notifying all observers of every change, allow agents to subscribe to specific topics or types of changes within the `Shared Context`. This is the core idea of the Publish-Subscribe pattern [3](https://www.enterpriseintegrationpatterns.com/).
    *   **Concurrency Control:** If multiple agents can update the context simultaneously, ensure the `Shared Context` is thread-safe to prevent data corruption.
    *   **Bounded Contexts:** To avoid a single, massive shared context, apply principles from Domain-Driven Design. Decompose the problem into multiple, smaller `Shared Contexts`, each with its own well-defined boundary and set of observers [4](https://martinfowler.com/bliki/BoundedContext.html).
10. **Related Patterns:**
    *   **Publish-Subscribe Pattern:** The Shared Context Observer is a specific implementation of the broader Publish-Subscribe architectural pattern, where the `Shared Context` acts as the topic/broker [3](https://www.enterpriseintegrationpatterns.com/).
    *   **Event-Driven Architecture [5](https://martinfowler.com/articles/enterpriseIntegrationPatterns/EventDrivenArchitecture.html):** This pattern is inherently event-driven. A state change in the context is an "event" that triggers reactions in observer agents, promoting a highly decoupled and scalable system.
    *   **Blackboard Pattern:** A classic AI pattern where a shared knowledge base (the "blackboard") is collaboratively updated by multiple specialist agents ("knowledge sources"). The Shared Context Observer pattern can be seen as a modern implementation of this concept.
    *   **Command Query Responsibility Segregation (CQRS) [6](https://martinfowler.com/bliki/CQRS.html):** The `Actor Agent` performs a "Command" by updating the `Shared Context`. The `Observer Agents` perform "Queries" to read the state after being notified. Separating these models can optimize performance and complexity in sophisticated systems.

## References
[1] Refactoring.Guru. (n.d.). *Design Patterns*. Retrieved from https://refactoring.guru/design-patterns
[2] Thoughtworks. (2017). *Evolutionary Architecture*. Retrieved from https://www.thoughtworks.com/insights/articles/evolutionary-architecture.html
[3] Hohpe, G., & Woolf, B. (n.d.). *Enterprise Integration Patterns*. Retrieved from https://www.enterpriseintegrationpatterns.com/
[4] Fowler, M. (2014). *Bounded Context*. Retrieved from https://martinfowler.com/bliki/BoundedContext.html
[5] Fowler, M. (2017). *Event-Driven Architecture*. Retrieved from https://martinfowler.com/articles/enterpriseIntegrationPatterns/EventDrivenArchitecture.html
[6] Fowler, M. (2011). *Command Query Responsibility Segregation (CQRS)*. Retrieved from https://martinfowler.com/bliki/CQRS.html