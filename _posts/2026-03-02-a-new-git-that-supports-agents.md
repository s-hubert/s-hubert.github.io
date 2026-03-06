---
layout: post
title: "A New Git That Supports Agents"
tags: [Architecture, Collaboration, AgenticDesignPatterns]
date: 2026-03-02
---

If software engineering is moving from writing code to writing prompts, then Git is moving from version control to intent control. The next-generation Git will not just track code changes, but also the evolving intent and acceptance criteria that drive those changes. It will integrate with AI agents to automatically generate, test, and verify code based on high-level specifications.

Let's reflect on where Git thrived and where it fell short of its original vision, and how a new Git could better support agentic engineering.

## The Original Vision of Git
Git was designed to be a distributed version control system that allows multiple developers to collaborate on code without blocking each other. It tracks changes to files, manages branches, and facilitates merging. However, it primarily focuses on code changes and not on the intent behind those changes.
Git was also meant as a transfer protocol for code, between developers, but also between developers and machines - i.e. for deployments - however, despite some hello world scenarios, this didn't really take off. 

And now, the almighty Git is being questioned by the rise of AI agents that can generate code based on high-level prompts. The traditional git workflow may not be sufficient to manage the rapid and iterative changes that agents can produce, especially when those changes are driven by evolving intent rather than just code diffs.

## The Limitations of Git in an Agentic Era

1. **Lack of Intent Tracking**: Git tracks what changed, but not why it changed. In an agentic context, understanding the intent behind code changes is crucial for effective collaboration and maintenance. The community has worked around this with conventions like Conventional Commits [[1]](https://www.conventionalcommits.org/en/v1.0.0/), but these are layered on top of git rather than native to it.
2. **Merge Conflicts**: As agents generate more code, merge conflicts will become more frequent and complex. Git's current model of branching and merging may not scale well in an environment where code is generated rapidly and iteratively by agents. As Mitchell Hashimoto has observed, agents cause so much churn that merge queues become untenable and branches proliferate [[2]](https://newsletter.pragmaticengineer.com/p/mitchell-hashimoto). GitHub's merge queue feature [[3]](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue) is a step in the right direction, but it is a workaround rather than a fundamental rethinking of the model.
3. **Code Review Bottlenecks**: With agents generating code, the volume of changes may overwhelm human reviewers. Git's current pull request model may not be sufficient to manage the quality and relevance of changes in an agentic workflow. Research at Microsoft found that review quality degrades as change size increases — the more files in a change, the lower the proportion of useful review feedback [[4]](https://www.microsoft.com/en-us/research/publication/characteristics-of-useful-code-reviews-an-empirical-study-at-microsoft/).
4. **Integration with AI Tools**: Git does not natively integrate with AI tools that can assist in code generation, testing, and validation. A new git would need to support seamless integration with these tools to enable a more efficient agentic engineering process. The emergence of the Model Context Protocol (MCP) [[5]](https://modelcontextprotocol.io/introduction) as an external standard for connecting AI agents to tools and data sources highlights how far git is from being natively agent-ready.
5. **No Provenance or Trust Model for Agent-Generated Code**: Git's trust model — GPG-signed commits, SSH keys — was built around human identity. As agents autonomously generate and commit code, git has no native mechanism to record which agent, which model version, or which prompt produced a given change. This lack of provenance makes it impossible to audit, triage, or selectively revert agent contributions — especially critical in compliance-sensitive or security-critical codebases. Emerging frameworks like SLSA (Supply-chain Levels for Software Artifacts) [[6]](https://slsa.dev/spec/v1.0/about) address supply chain integrity at the build level, but the source-level identity gap in git itself remains unresolved.


## Problems a New Git Must Solve

Before discussing solutions, it helps to name the core problems clearly. In an agentic workflow, a new git has to address:

1. **Loss of intent**: Git records what changed, but not the decision context behind the change, so teams lose the thread of why work happened.
2. **Churn collapse**: Agent-scale change volume drives branch proliferation, constant rebasing, and frequent merge conflicts that the current model cannot absorb efficiently.
3. **Human review overload**: Humans become the bottleneck as change sets grow, and review quality degrades under volume and noise.
4. **Disconnected toolchain**: Generation, testing, and validation systems remain outside version control, fragmenting quality signals and weakening end-to-end trust.
5. **Unreliable source-level provenance**: Teams cannot consistently answer who (human or agent) produced a change, under which model/prompt context, and whether that record is tamper-resistant.
6. **Weak rollback and triage semantics**: When an agent introduces a bad pattern, rollback remains commit-centric instead of actor/session-centric, slowing containment.
7. **Trust model mismatch**: Collaboration is shifting from default-trust to default-deny, but git’s collaboration model was designed for a different posture.
8. **Code history without engineering memory**: The timeline preserves diffs, but not evolving intent, evaluation criteria, and decision checkpoints.

In short, the gap is not only technical scale; it is semantic scale: git tracks code history, while agentic engineering needs intent, trust, and verification history.

## Reframing the Direction

We need to think the "New Git" way bigger than just version control. It needs to be a system of record for the entire engineering process, from intent to implementation to runtime validation. It needs to integrate with AI tools and provide a trust model for agent-generated code. It needs to support new workflows that are more iterative and less linear than the traditional git model.

If coding is cheap - close to zero - and may be done by agents on their own, why would we ever reuse third-party code, especially OSS libraries of which we only need 5% of their features? Wouldn't it be better to ask an agent to generate the code we need, and then maintain it ourselves?

And if we can keep a higher-level description of the feature intent and so forth, couldn't we let the agent decide when to rewrite a feature due to a new and improved model or technology that will result in better runtime performance, better security, or better maintainability?

The question is, is that feasible to believe in? I'd say yes. Even today's models can outperform human experts in scoped requirements tasks, generate higher-quality follow-up elicitation questions, and derive structured requirements from noisy or high-level artifacts such as user reviews and UI mockups [[7]](https://arxiv.org/abs/2501.19297) [[8]](https://arxiv.org/abs/2507.02858) [[9]](https://arxiv.org/abs/2307.07381) [[10]](https://arxiv.org/abs/2409.15473) [[11]](https://arxiv.org/abs/2602.16997).


## Open Design Questions
- Should a new git treat the runtime as a first-class target, where versioned change bundles can be executed, validated, and iterated automatically?
- What should be the canonical unit of diff and transfer in an agentic workflow: file diffs, intent/spec diffs, behavior diffs, or all three in linked form?
- In this model, is the LLM best framed as a compiler from intent to code, as an interpreter over executable specifications, or as a hybrid that switches by context?
- How should validation be split between commit-time and runtime, and under what policy can a failed runtime validation trigger autonomous rewrite and retry?
- If merge becomes primarily a validation checkpoint rather than a manual integration ritual, what should replace today’s branch-and-PR bottlenecks?
- What minimum provenance record (agent identity, model/version, prompt/context, validation evidence) must be captured to make history auditable and selectively reversible?
- How can source control, specification, and verification histories be unified into one tamper-resistant system of record without overwhelming human reviewers?

## Feasible Paths Today
- **Intent-aware commits**: Add structured intent metadata (user story, acceptance criteria, rationale) directly to each change so implementation can be traced back to why it exists. A practical near-term path is commit-attached notes, which augment history without rewriting commit objects [[12]](https://git-scm.com/docs/git-notes). Projects like git-memento show this is workable for agent session provenance today [[13]](https://github.com/mandel-macaque/memento), but the ecosystem still lacks a broadly adopted, enforced schema.
- **Separate higher-level specification layer**: Keep intent/spec artifacts as first-class versioned assets linked to code commits, so teams can traverse from implementation back to decision context. A practical path is a companion repository via submodules [[14]](https://git-scm.com/book/en/v2/Git-Tools-Submodules) or an in-repo subtree workflow [[15]](https://www.atlassian.com/git/tutorials/git-subtree), depending on desired coupling. The unresolved challenge is standardizing the linkage model so traceability remains consistent across tools and teams.
- **Container-based runtime**: Treat each versioned change bundle (code, specs, tests) as a deployable unit that can be executed and validated in isolation, enabling faster autonomous agent iteration. Docker provides the portable packaging/runtime primitive [[16]](https://docs.docker.com/get-started/docker-overview/), and Kubernetes provides orchestration over CRI-compatible runtimes [[17]](https://kubernetes.io/docs/setup/production-environment/container-runtimes/). The remaining gap is integrating this runtime loop natively into source control rather than bolting it on around git.
- **Spec-driven toolset**: Drive implementation and validation from executable intent, using BDD for shared behavioral specifications [[18]](https://cucumber.io/docs/bdd/) and TDD for incremental red-green-refactor execution [[19]](https://martinfowler.com/bliki/TestDrivenDevelopment.html). In this model, deviations from intent become machine-detectable and can trigger automated rollback/retry cycles. The key challenge is tight end-to-end integration across version control, test systems, and runtime policy.

## Summary and Next Steps

The core argument is that agentic engineering needs more than code history: it needs intent history, trust history, and verification history in one auditable flow. Existing git primitives can approximate this direction, but they do not yet provide a native model for intent-linked change, actor-level provenance, and runtime-aware validation.

1. **Define a minimal intent/provenance schema**: Specify the required fields for each change (intent, acceptance criteria, agent identity, model/version, prompt context, validation evidence), and map them to a concrete storage strategy (for example, notes plus policy checks).
2. **Run a thin end-to-end pilot**: Implement one feature path where intent is captured, code is generated, validation runs in a containerized loop, and failures trigger controlled rollback/retry; use the results to refine merge policy and reviewer touchpoints.

## Bibliography

- [1] [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)
- [2] [Mitchell Hashimoto on AI, open source, and the future of version control — The Pragmatic Engineer](https://newsletter.pragmaticengineer.com/p/mitchell-hashimoto)
- [3] [Managing a merge queue — GitHub Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue)
- [4] [Characteristics of Useful Code Reviews: An Empirical Study at Microsoft — Microsoft Research](https://www.microsoft.com/en-us/research/publication/characteristics-of-useful-code-reviews-an-empirical-study-at-microsoft/)
- [5] [Model Context Protocol: Introduction](https://modelcontextprotocol.io/introduction)
- [6] [SLSA: Supply-chain Levels for Software Artifacts — About SLSA v1.0](https://slsa.dev/spec/v1.0/about)
- [7] [Analysis of LLMs vs Human Experts in Requirements Engineering](https://arxiv.org/abs/2501.19297)
- [8] [Requirements Elicitation Follow-Up Question Generation](https://arxiv.org/abs/2507.02858)
- [9] [Investigating ChatGPT's Potential to Assist in Requirements Elicitation Processes](https://arxiv.org/abs/2307.07381)
- [10] [Exploring Requirements Elicitation from App Store User Reviews Using Large Language Models](https://arxiv.org/abs/2409.15473)
- [11] [Exploring LLMs for User Story Extraction from Mockups](https://arxiv.org/abs/2602.16997)
- [12] [git-notes Documentation](https://git-scm.com/docs/git-notes)
- [13] [mandel-macaque/memento (git-memento)](https://github.com/mandel-macaque/memento)
- [14] [Git Tools - Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
- [15] [Git subtree: the alternative to Git submodule](https://www.atlassian.com/git/tutorials/git-subtree)
- [16] [What is Docker?](https://docs.docker.com/get-started/docker-overview/)
- [17] [Kubernetes: Container Runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
- [18] [Behaviour-Driven Development (Cucumber)](https://cucumber.io/docs/bdd/)
- [19] [Test Driven Development (Martin Fowler)](https://martinfowler.com/bliki/TestDrivenDevelopment.html)
