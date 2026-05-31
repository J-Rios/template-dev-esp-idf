# template-dev-esp-idf

ESP-IDF base project template to be used as starting point for new projects. It includes a builtin container that generates a full development environment with all the required tools and setups for the project.

---

## Project Structure

- `container/`: Directory that stores scripts and the container file to build and use the development environment.
- `CMakeLists.txt`: Project root CMake file for the project.
- `main/`: Project main source code.
- `components/`: Additional software components.
- `script/`: Directory that contains additional auxiliary project scripts.
- `sdkconfig.defaults`: ESP-IDF project default SDK configuration.
- `partitions.csv`: ESP-IDF project flash memory partition table definition file.

---

## 1. Prerequisites

Use Linux (recommended Debian/Ubuntu) or Windows with WSL.

The next tools are needed:

- Make
- CMake
- Podman

If you are on a Debian based Linux system (Debian, Ubuntu, etc):

```bash
# Install Tools
sudo apt update && sudo apt install -y make cmake podman
```

---

## 2. Build the Container Image

The development environment image can be built using `make`:

```bash
sudo make setup
```

---

## 3. Usage

Launch the development environment by:

```bash
sudo make run
```

This will launch the container with the required configurations and mounts.

Once the container is started, it will automatically open the builtin vscode editor window. This vscode has the ESP-IDF extension already installed and this provides UI elements to setup the target MCU, configure, build, flash and debug the project.

The container is also available via it shell, so you could manually set the target MCU for the project, configure it, build, flash and monitor the serial interface via command line interface, if you need to:

```bash
idf.py set-target esp32
idf.py menuconfig
idf.py build
idf.py flash
idf.py monitor
```

## 4. Save Container Changes

If you have done some changes inside the container environment (i.e. updating/installing new vscode extension, applying some configurations, installing extra tools, etc) you can save this changes to make them persistent by issuing the next command at Host terminal while the container is running (recommended to close container vscode before running the command):

```bash
make save
```


## 5. Container Image Remove

In case you want to remove the container image:

```bash
sudo make remove
```

---

## 6. Notes

The development environment container contains:

- **VSCode (and extensions):** As main GUI tool for the development.
- **ESP-IDF:** The Espressif IoT Development Framework.
- **CMake:** Used to configure and build the project.
- **Ccache:** To speed up repeated compilations.
- **JLink Tools:** For programming and debugging via a JLink adapter.
- **OpenOCD:** For flash and debug support on many ESP32 development boards.
- **PlantUML:** To render UML diagrams if you add documentation diagrams.
- **Static Code Analysis Tools:** Includes `cppcheck` and `clang-tidy` for code quality checks.
- **Clang-Format:** For formatting C and C++ source code.

The Container needs to be build-run in "rootful" mode to avoid issues and restriction to access USB devices (we need this to use programmers/debuggers hardware devices). Limitation here to run it in "rootless" mode seems to be due WSL incompatibility and potential portability problems on host-container permissions sharing depending on running OS system.
