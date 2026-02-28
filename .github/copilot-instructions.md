<!-- .github/copilot-instructions.md for s-hubert.github.io -->

This repository is a small personal Jekyll blog using the `minima` theme hosted on GitHub Page as described in here: https://raw.githubusercontent.com/jekyll/minima/refs/heads/master/README.md. The instructions below focus on the repository layout, templating patterns, and concrete developer workflows so an AI coding agent can make accurate, minimal, and safe edits.

- Project type: Jekyll static site (Ruby/Jekyll). Key config: `_config.yml` (theme: `minima`, plugins: `jekyll-feed`, `jekyll-sitemap`).
- Content: posts live in `_posts/` (standard Jekyll filenames). Draft-like content or post resources may appear under `_posts/_ideas/`.
- Layouts and includes: main article template `_layouts/post.html` includes `sharelinks.html` and `navlinks.html`. Global head markup is in `_includes/head.html`.

Quick goals for edits

- Make minimal, well-scoped changes that preserve existing Liquid templates and permalink behaviour.
- Prefer editing `css/override.css` or adding additional stylesheet files instead of changing the theme's core files.

Important patterns and examples

- Syntax highlighting is provided by a vendored highlight.js bundle under `/js/highlightjs/`. File references are in `_includes/head.html` (see: `highlight.min.js` and language files in `js/highlightjs/languages/`). If you add code blocks, do so using standard fenced code and language hints (` ```powershell `, ```tsql`, etc.).
- Custom CSS lives in `css/override.css` and is explicitly included from layouts. Prefer small augmentations there.
- Social/share buttons are implemented inline in `_includes/sharelinks.html` and use Liquid to build encoded URLs (`safeurl`, `safetitle`). If changing behavior, update both the markup and any related JS/CSS.

Conventions and constraints

- Posts use standard Jekyll front matter and Liquid filters (see `_layouts/post.html`). Keep existing Liquid tags (e.g., `relative_url`, `url_encode`, `date_to_xmlschema`).
- Do not remove or rename `css/override.css` or the `js/highlightjs/` folder unless you update all references in `_includes/head.html` and layouts.
- `site.url` may be relied on by share links; avoid breaking references that build `safeurl`.

When creating or modifying files

- If adding new pages, follow Jekyll conventions: include front matter, use `layout: post` for posts, and name files in `_posts` with the `YYYY-MM-DD-title.md` pattern.
- Small UI/CSS tweaks: prefer `css/override.css`. For larger design changes, document them in a short PR description.

What NOT to change

- Avoid global changes to the `minima` theme unless the change is intentional. Prefer overrides.
- Avoid adding or modifying external service keys (Google Analytics) unless explicitly instructed; `_includes/head.html` conditionally includes analytics based on `jekyll.environment` and `site.google_analytics`.

Files to reference when working on PRs

- `_config.yml` — site-wide settings and plugins
- `_layouts/post.html` — post template and how content is inserted
- `_includes/head.html` — script and stylesheet includes (highlight.js)
- `_includes/sharelinks.html` — social sharing logic
- `css/override.css` — repo-specific styling
- `js/highlightjs/` — syntax highlighting bundle

Mermaid diagrams
- Mermaid diagrams are used in posts for visual explanations. They are rendered client-side using the included `highlight.min.js` and language files. If adding or modifying diagrams, ensure they are properly fenced and that any new dependencies are included in `_includes/head.html`.
- When adding code blocks, use fenced `<pre class="mermaid"` tags for proper syntax highlighting. For example:
```markdown
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
```

If anything is ambiguous, ask the repo owner exactly which runtime/build approach they prefer (Gemfile/bundle vs. system gem). Also confirm whether you may add CI or a Gemfile before creating one.

End of file.
