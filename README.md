# reaper-vim

An attempt at a new shortcut mapping system for Reaper, based on modal input sequences rather than key chords, and repetition counts for actions.
Shortcuts are mapped to Lua functions, each taking a count as argument.
A growing library of action functions will be accompanying this project, but a lot of functionality can be gotten by calling native Reaper actions by ID.
When triggering Reaper actions, the count indicates repitition, which is very useful and something that isn't really possible with the normal action mapping system.


# Usage
* Put this repository in your `Scripts` directory
* Import the keymap `keys.ReaperKeyMap`. BACKUP YOUR KEYMAP FIRST. This will overwrite any mappings you have for letters and numbers.

# Customization
Set up your mappings in `bindings.lua`

To add new bindable keys you need to create a new script in `mapper_scripts`, and map it to a key in reaper.
Alternatively, you can add a new entry in `gen_mapper_scripts.sh`, run it, and re-import the keymap, but this requires bash.
