# Startlex: Local Development Automation
A super simple script to automate and orchestrate working locally with Winslow and other web applications in [`deus_lex`](https://github.com/LexMachinaInc/deus_lex) on **macOS**. Nothing fancy, just some bash + AppleScript.

When executed, the script...
- Opens a tunnel to the target environment in a new **iTerm** tab
- Starts `pserve` for the configured application in a vertical split pane
- Starts a `gmake *-frontend-watch` process for the configured application in a vertical split pane
- Opens a second **iTerm** tab in the the local `deus_lex` repo directory  using the configured virtualenv
- Opens a Chrome tab to `localhost`, using the port of the configured application in another split pane

These are all things I found useful, but you may want to customize to your environment/tastes. See the **Customizing for Your Environment** section at the end of this README.

![startlex](https://user-images.githubusercontent.com/527082/86977084-76e55f00-c141-11ea-86ee-351a1a107412.gif)

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
  <dt>-e</dt>
  <dd>
    The vex virtual environment name.
    <dl>
      <dt>Default:</dt>
      <dd><code>3.8.2</code></dd>
    </dl>
  </dd>
  <dt>-d</dt>
  <dd>
    Your `deus_lex` repository root directory
    <dl>
      <dt>Default:</dt>
      <dd><code>~/Programming/deus_lex</code></dd>
    </dl>
  </dd>

  <dt>-h</dt>
  <dd>Print usage help</dd>
</dl>


### Examples

#### Winslow on macduff
Since `winslow` and `macduff` are the default options, this is simply:

```bash
startlex.sh
```

#### Citadel on primary
```bash
startlex.sh -a citadel -t primary
```

#### Winslow on primary
```bash
startlex.sh -t primary
```

#### Use a different virtual environment†
```bash
startlex.sh -e primary
```

#### Use a different `deus_lex` home directory†
```bash
startlex.sh -d ~/path/to/deus_lex
```

**†** If you find yourself using the `-e` or `-d` options frequently, you might be better served to modify the `VEX_ENV` or `LEX_HOME_DIR` variables in your copy of the script.

## Customizing for Your Environment
This script was written using `bash` and AppleScript to work with macOS and [iTerm2](https://www.iterm2.com/). However, much of it can also be customized with some tweaks to the script.

**Note:** The next version of the script will use `screen` or `tmux` so that it's more universally compatible with other operating systems and terminal emulators.

### 1. Customize virtual environment
This script has a variable called `vex_env`, which contains the hard-coded name of my current virtual environment. The script could easily be tweaked to make this configurable via command option, if so desired.

### 2. Customize `deus_lex` Repo path
The path of the `deus_lex` repo on your machine may differ from the path hard-coded into the script in the `deus_lex_home` variable. This could also be made configurable via command option if desired.

### 3. Customize Web Browser
Change the `"Google Chrome"` potion of the last line to your preferred browser.

### 4. Change the Tab and Split Pane Actions
Actions are located in the `Actions` section (below `Macros` section) beneath a comment describing the action. If you'd like to customize the number or order of tabs/panes that are opened you can do by removing or rearranging some sections. For instance, if you'd rather not open that second **iTerm** tab you can remove everything in the **# Run `git branch` in a new tab** section.

### 5. Customize Preferred Terminal Application
The script assumes **iTerm2** is the terminal application. Tweaking it to work with another terminal application is possible, but will require:
- Finding/replacing instances of `iTerm` in the script with your terminal application name
- Updating some of the `key code`-related AppleScript to use the correct code for your terminal application. For instance, the correct AppleScript snippet to open a new vertical split pane in **iTerm** is `key code 2 using command down`.
