# Startlex: Local Development Automation
A super simple script to automate and orchestrate working locally with Winslow and other web applications in [`deus_lex`](https://github.com/LexMachinaInc/deus_lex) on **macOS**. Nothing fancy, just some bash + AppleScript.

When executed, the script...
- Opens a tunnel to the target environment in a new iTerm tab
- Starts `pserve` for the configured application in a vertical split pane
- Starts a `gmake *-frontend-watch` process for the configured application in a vertical split pane
- Opens a second iTerm tab in the the local `deus_lex` repo directory  using the configured virtualenv
- Opens a Chrome tab to `localhost`, using the port of the configured application in another split pane

These are all things I found useful, but you may want to customize to your environment/tastes. See the **Customizing for Your Environment** section at the end of this README.

## Usage
### Synopsis

```bash
startlex.sh [OPTIONS]
```

### Options
<dl>
  <dt>-a</dt>
  <dd>
    The target application to run. Valid values include <code>winslow</code>, <code>citadel</code>, <code>usertool</code>, or <code>dashboarding</code> (matches the application directory under `deus_lex`)
    <dl>
      <dt>Default:</dt>
      <dd><code>winslow</code></dd>
    </dl>
  </dd>
  <dt>-t</dt>
  <dd>
    The target environment. Valid values include <code>macduff</code> or <code>primary</code>
    <dl>
      <dt>Default:</dt>
      <dd><code>macduff</code></dd>
    </dl>
  </dd>
  <dt>-h</dt>
  <dd>Print usage help</dd>
</dl>


### Examples

#### Winslow on Macduff
Since `winslow` and `macduff` are the default options, this is simply:

```bash
startlex.sh
```

#### Citadel on Primary
```bash
startlex.sh -a citadel -t primary
```

#### Winslow on Primary
```bash
startlex.sh -t primary
```

## Customizing for Your Environment
This script was written to work specifically with macOS and [iTerm2](https://www.iterm2.com/) with my specific bash environment (`/usr/local/bin/bash`). Much of this can be customized with some tweaks to the script (and, in the one case, a little Googling for the right key codes).

### Customize `bash` Executable
To use a different `bash` executable, just update the `#!` path at the top. If you're unsure where it is on your machine type `which bash` in a terminal to get the path.

**Note:** If you're using another shell (e.g. `fish`) you may need to do more work to port from `bash` command syntax to your shell's syntax.

### Customize virtual environment
This script has a variable called `vex_env`, which contains the hard-coded name of my current virtual environment. The script could easily be tweaked to make this configurable via command option, if so desired.

### Customize `deus_lex` Repo path
The path of the `deus_lex` repo on your machine may differ from the path hard-coded into the script in the `deus_lex_home` variable. This could also be made configurable via command option if desired.

### Customize Web Browser
Change the `"Google Chrome"` potion of the last line to your preferred browser.

### Change the Tab and Split Pane Actions
Actions are located in the `Scripts` section (below `Macros` section) beneath a comment describing the action. If you'd like to customize the number or order of tabs/panes that are opened you can do by removing or rearranging some sections. For instance, if you'd rather not open that second iTerm tab you can remove everything in the **# Run `git branch` in a new tab** section.

### Customize Preferred Terminal Application
The script assumes iTerm2 is the terminal application. Tweaking it to work with another terminal application is possible, but will require:
- Finding/replacing instances of "`iTerm`" in the script with your terminal application name
- Updating some of the `key code` to the correct code for your application. For instance, the `key code` to open a vertical split pane in `iTerm` is `52` with `command down` (AppleScript).

