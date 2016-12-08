# reaper-vim

An attempt at a new shortcut mapping system for Reaper, based on modal input sequences rather than key chords, and repetition counts for actions.
Shortcuts are mapped to Lua functions, each taking a count as argument.
A growing library of action functions will be accompanying this project, but a lot of functionality can be gotten by calling native Reaper actions by ID.
When triggering Reaper actions, the count indicates repitition, which is very useful and something that isn't really possible with the normal action mapping system.


# Usage
* Put this repository in your `Scripts` directory
* Import the keymap `keys.ReaperKeyMap`. BACKUP YOUR KEYMAP FIRST. This will overwrite any mappings you have for letters and numbers.

# Customization
Set up your mappings in `vimper_bindings.lua` in your REAPER user directory. You can start by copying `example_bindings.lua` and edit it as you wish.
All available actions are currently defined in `actions.lua`, but adding new ones is simply a matter of defining your own lua functions in your own bindings file.
All arguments to `runAction()` are just the ID numbers of actions in the Reaper actions editor.

To add new bindable keys you need to create a new script in `mapper_scripts`, and map it to a key in reaper. Most people should not need to do this, and I will work towards having as many keys mappable as possible.
Alternatively, you can add a new entry in `gen_mapper_scripts.sh`, run it, and re-import the keymap, but this requires bash.
