# Dev Notes Aug 20

1. Generate ssh key using 
    - ssh-keygen -t -ed25519 -C "vineetn90@gmail.com"
    - will be prompted where to store
    - for default leave empty and just press enter
    - can optionally add a file name and then move it to ~/.ssh/
    - then add the key to your ssh agent eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519

2. python3 -m venv .venv
    - python3 → calls the Python 3 interpreter.
    -m venv → tells Python to run the built-in venv module (used for creating virtual environments).
    - .venv → the name of the directory where the virtual environment will be created.
    - 📦 This makes a folder called .venv in your project, containing:
        -its own Python interpreter
        -   its own pip
        - an isolated site-packages folder for dependencies

3. &&
    - This means “only run the next command if the previous one succeeds”.
    - So, if venv creation fails, it won’t try to activate it.

4. source .venv/bin/activate
    - Runs the activation script for the virtual environment.
    - Modifies your shell’s environment so:
    - python now points to .venv/bin/python
    - pip now points to .venv/bin/pip
    - Your shell prompt usually changes to show (.venv)
    - From here on, any pip install ... goes inside this project’s .venv, not globally