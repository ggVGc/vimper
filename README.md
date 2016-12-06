# reaper-vim

An attempt at a new shortcut mapping system for Reaper, based on modal input sequences rather than key chords, and repition counts for actions.
Shortcuts are mapped to Lua functions, each taking a count as argument.
A growing library of action functions will be accompanying this project, but a lot of functionality can be gotten by calling native Reaper actions by ID.
When triggering Reaper actions, the count indicates repitition, which is very useful and something that isn't really possible with the normal action mapping system.

This whole thing is fairly hacky. State is currently held in temporary files(file names configurable in `mapper.lua`.

To set up, each mappable character needs to be mapped in reaper. Run `gen_mapper_scripts.sh` to generate scripts for each character, load the scripts in the Reaper action editor, and map each one to the correct key.
I will make an importable keymap for this at some point.
