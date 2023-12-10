# Course Scheduler in OCaml - README

## Introduction
The Course Scheduler project in OCaml is designed to help students manage their course schedules. This program allows users to view, add, and drop courses, and manage their credit load. It uses OCaml along with the Yojson library for parsing JSON files containing course and user data.

## Authors
- Grace Lim (gl487)
- Jerry Wang (yhw4)
- Collin Li (cl2353)
- Kevin Ram (kmr232)

## Features
- View available courses and their details (ID, name, description, credits, schedule).
- Add or drop courses based on course ID or name.
- View and manage the user's current course schedule.
- Calculate total credits of enrolled courses.
- Export course schedules to an ICS file for calendar integration.
- User authentication system.
- Color-coded terminal output for better readability.

## Prerequisites
- OCaml
- utop (OCaml interactive top-level)
- Yojson library

## Installation Guide
1. Ensure OCaml and utop are installed on your computer.
2. Install the Yojson library. You can install it using OPAM (OCaml package manager) with the command: `opam install yojson`
3. Clone or download this project to your local machine.

## Usage Guide
1. Open your terminal or command prompt.
2. Navigate to the project's directory.
3. To run the program, type `make play` and press enter. Follow the on-screen instructions to interact with the program.
4. To exit the program, enter `0` when prompted to choose an action.

## Running Test Cases
1. Navigate to the project directory in your terminal.
2. Run the test suite by typing `make test` and pressing enter.

## Generating Documentation
1. In the terminal, navigate to the project directory.
2. Generate the documentation by typing `make doc` and pressing enter.
3. View the documentation by typing `make open-doc`. This opens the `index.html` file containing all documentation and `.mli` files.

## Contributing
Contributions to the project are welcome. Please follow the standard OCaml coding conventions and ensure your code passes all existing tests before submitting a pull request.

## Support
For any questions or issues, please open an issue on the project's GitHub page.

## License
This project is licensed under the [MIT License](LICENSE). Please see the LICENSE file for more details.