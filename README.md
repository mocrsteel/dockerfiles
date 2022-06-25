# dockerfiles
Groups custom dockerfiles

## python-poetry-node

**Base image:** python:3.10.5
**Shell:** Bash + Starship
**User profiles:**

	- root
	- dev (default, no password)

**Workspace directory:** `/home/dev/workspace`

**Tech stack:**

	* Python: v3.10.5
	* Python package manager: Poetry
	* NodeJS: v18.3
	* Node package manager: Yarn
	* Rust (for starship shell install)

**Tested on:**

	- GitPod
	- Docker desktop (Windows 11 + WSL2 / Ubuntu 22.01)
	- Ubuntu 22.01
