# PomodoroBat

A simple Pomodoro Timer script written in batch for managing work and break intervals using the Pomodoro Technique.

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Features](#features)
- [Install](#install)
- [Download](#download)
- [Roadmap](#roadmap)
- [Development](#development)
- [Build Setup](#build-setup)
- [Contributing](#contributing)
- [License](#license)

## Overview

The Pomodoro Timer is designed to help you manage your work and break intervals more effectively. By following the Pomodoro Technique, you can improve your productivity and focus. This script features customizable work, short break, and long break durations, and provides sound notifications at the end of each interval.

## Project Structure

```plaintext
PomodoroBat
├── bin
│   ├── nircmd
│   │   ├── nircmd.exe
│   │   ├── nircmdc.exe
│   │   └── nircmd.chm
│   └── sound
│       ├── pb_alarm_clock.wav
│       ├── pb_clock-tick.wav
│       ├── pb_mixkit-tick-tock.wav
│       └── pb_ticking_1.wav
└── src
    └── main.bat
```

## Features

- Customizable work, short break, and long break durations.
- Sound notifications at the end of each interval.
- Session report generation.
- Settings persistence via a `settings.txt` file.
- Simple command-line interface.

## Install

1. **Clone the repository**:
    ```sh
    git clone https://github.com/nminhducit/PomodoroBat.git
    ```

2. **Navigate to the project directory**:
    ```sh
    cd PomodoroBat
    ```

## Download

Make sure you have `nircmd` for window activation (optional but recommended):

- Download `nircmd` from [NirSoft](https://www.nirsoft.net/utils/nircmd.html).
- Place `nircmd.exe`, `nircmdc.exe`, and `nircmd.chm` in the `bin/nircmd/` directory.

## Roadmap

- [x] Implement basic Pomodoro Timer functionality.
- [x] Add customizable time settings.
- [x] Include sound notifications.
- [x] Generate session reports.
- [ ] Improve user interface.
- [ ] Add more sound options.
- [ ] Integrate with productivity tools.

## Development

1. **Run the script**:
    ```sh
    start src\main.bat
    ```

2. **Follow the on-screen menu**:
    - **1. Start Pomodoro Timer**: Begin a Pomodoro session.
    - **2. View Report**: View the session report.
    - **3. Change Settings**: Customize your timer settings.
    - **4. Show Version**: Display version information.
    - **5. Exit**: Exit the script.

### Changing Settings

1. Run the script and select `Change Settings` from the menu.
2. Follow the prompts to enter your desired settings.

## Build Setup

1. Ensure you have `nircmd` installed in the `bin/nircmd/` directory.
2. Place your desired sound files in the `bin/sound/` directory.
3. Modify `src/main.bat` to update any paths or settings as needed.

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on [GitHub](https://github.com/NMINHDUCIT/PomodoroBat).

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


