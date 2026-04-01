# Visual Companion

The visual companion is a browser-based tool for showing mockups, diagrams, and visual options during brainstorming. It provides a web server that displays content in a consistent frame with light/dark theme support.

## How It Works

1. The agent starts the server using `start-server.sh`
2. The server provides a URL where the user can view content
3. The agent can push HTML content to the browser
4. User selections are sent back to the agent via WebSocket

## When to Use

Use the visual companion when showing:
- UI mockups and wireframes
- Layout comparisons
- Architecture diagrams
- Visual design options
- Side-by-side comparisons

Do NOT use for:
- Text-based questions
- Conceptual choices
- Simple A/B/C options
- Requirements gathering

## Server Scripts

- `start-server.sh` - Start the brainstorm server
- `stop-server.sh` - Stop the brainstorm server

## Template Files

- `frame-template.html` - Base HTML template with theming
- `helper.js` - Client-side JavaScript for interactions

## Example Content

```html
<div class="section">
  <h2>Choose Your Layout</h2>
  <p class="subtitle">Which layout works best for your use case?</p>
  
  <div class="options">
    <div class="option" data-value="A">
      <div class="letter">A</div>
      <div class="content">
        <h3>Sidebar Navigation</h3>
        <p>Classic layout with left sidebar</p>
      </div>
    </div>
    <div class="option" data-value="B">
      <div class="letter">B</div>
      <div class="content">
        <h3>Top Navigation</h3>
        <p>Modern layout with horizontal nav</p>
      </div>
    </div>
  </div>
</div>
```
