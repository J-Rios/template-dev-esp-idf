# template-dev-esp-idf

Base template to be used as starting point for new esp-idf based projects. It contains a builtin OCI container that generates a fully development environment that contains all the required tools and setups for the project.

---

## Project Structure

- `CMakeLists.txt`: Project root CMake file for the project.
- `container/`: Directory that stores scripts and the container file to build and use the development environment.
- `main/`: Project main source code.
- `components/`: Additional software components.
- `script/`: Directory that contains useful project scripts.
- `sdkconfig.defaults`: ESP-IDF project default SDK configuration.
- `partitions.csv`: ESP-IDF project flash memory partition table definition file.

---

## 1. Prerequisites

The next tools are needed:

- Make
- CMake.
- Podman.
- VSCode (and ESP-IDF extension).

If you are on a Debian based Linux system (Debian, Ubuntu, etc):

```bash
sudo apt update && sudo apt install -y make cmake podman
```

---

## 2. Build the Container Image

The development environment image can be built using `make`:

```bash
make build-container
```

---

## 3. Usage

**Option A:**

Recommended usage is via **vscode** editor and **ESP-IDF** extension. Once you open the project with vscode, it will identify the `.devcontainer` definition file and ask to open the project through the container.

**Option B:**

To manually run the development environment:

```bash
make run-container
```

Then, you can manually set the target MCU for the project, configure it, build, flash and monitor the serial interface via:

```bash
idf.py set-target esp32
idf.py menuconfig
idf.py build
idf.py flash
idf.py monitor
```

---

## 5. Notes

The development environment container contains:

- **ESP-IDF:** The Espressif IoT Development Framework.
- **CMake:** Used by ESP-IDF to configure and build the project.
- **Ccache:** To speed up repeated compilations.
- **JLink Tools:** For programming and debugging via a JLink adapter.
- **OpenOCD:** For flash and debug support on many ESP32 development boards.
- **PlantUML:** To render UML diagrams if you add documentation diagrams.
- **Static Code Analysis Tools:** Includes `cppcheck` and `clang-tidy` for code quality checks.
- **Clang-Format:** For formatting C and C++ source code.
