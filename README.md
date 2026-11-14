# Alchemy vs Magic : Team 8

# Members
Project Manager: Hamza Farah ([hamzafarah11](https://github.com/hamzafarah11))\
Communications Lead: Chase Cangelosi ([Chasecan308](https://github.com/Chasecan308))\
Git Master: Isaac Salinas ([isaacsalinas](https://github.com/isaacsalinas))\
Design Lead: Phillip Shoats ([Phillip11037](https://github.com/Phillip11037))\
Quality Assurance Tester: Dionie Alexander ([D10n1eAlex](https://github.com/D10n1eAlex))

# About Our Software

Alchemy vs Magic is a 2D turn-based combat game made in Godot. The player controls a party of two alchemists who take turns fighting enemies, using weapon loadouts and status ailments that wear off over a set number of turns. TODO: team, check and expand this description.

## Platforms Tested on
- TODO: list only the platforms the game has actually been run on (for example, Windows or macOS)

# Important Links
Kanban Board: [Team 8 Kanban Board](https://github.com/orgs/CSC-3380-Fall-2026/projects/10)\
Designs: TODO: add link\
Styles Guide(s): TODO: add link to our code standards

# How to Run Dev and Test Environment

## Dependencies
- [Godot Engine 4.4](https://godotengine.org/download/archive/4.4-stable/) (Standard version, not .NET)
- [Git](https://git-scm.com/downloads) (any recent version)

No plugins, add-ons or IDE extensions are required. All code is in GDScript, which runs inside the Godot editor.

### Downloading Dependencies
1. Download Godot 4.4 (Standard) for your operating system from the [Godot 4.4 download page](https://godotengine.org/download/archive/4.4-stable/). Godot doesn't need to be installed: unzip it and run the Godot executable.
2. Download and install Git from [git-scm.com](https://git-scm.com/downloads).

## Commands
Clone the repository:

```sh
git clone https://github.com/CSC-3380-Fall-2026/Team-8.git
cd Team-8
```

Open and run the project in the Godot editor:
1. Open Godot 4.4.
2. In the Project Manager, click **Import**, select the `project.godot` file in the cloned `Team-8` folder, then click **Import & Edit**.
3. The first time the project opens, Godot imports the assets. Wait for it to finish.
4. Press **F5** (or the Play button in the top right) to run the game. It starts in `Scenes/Main.tscn`.

Or run it from the command line, from inside the `Team-8` folder (replace `godot` with the path to your Godot 4.4 executable):

```sh
godot --path .
```

## Running Unit Tests
1. In the Godot editor, open `Tests/HealthTest.tscn`.
2. Press **F6** (Run Current Scene).
3. Check the Output panel at the bottom of the editor. Each test prints `PASS: ...` when it succeeds.
