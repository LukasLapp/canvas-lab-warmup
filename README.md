# Canvas Assignment Dashboard

A Ruby on Rails application that logs into your Canvas account to fetch active courses which can be selected through a dropdown box, in which the assignments for the chosen course are then shown with their corresponding due date and the amount of points that assignment is worth. This allows you to quickly view what assignments are actually due next.

---

## Setup Instructions

Follow these instructions in order to get this application running locally on your machine. 

### 1. Ensure the Ruby is installed

First, ensure that you have **Ruby** installed on your system. You can check if Ruby is already installed by running `ruby -v` in your terminal. This application was built using `ruby 4.0.6`.

### 2. Clone the Repository

Open your terminal and run:
```bash
git clone https://github.com/<your-username>/canvas-lab-warmup.git
cd canvas-lab-warmup
```

### 3. Install Dependencies

Ruby makes installing dependencies extremely easy. Run:

```gem install bundler
bundle install
```

### 4. Create Your .env File

Create a file named `.env` in the root directory of your project. Then edit the file to read:
```
CANVAS_API_TOKEN=YOUR-CANVAS-TOKEN-HERE
CANVAS_BASE_URL=https://boisestatecanvas.instructure.com
```

Ensure your never push your Canvas token to any repository. If you do, make sure your delete the current token and generate a new one. 

### 5. Run the machine

```
bin/dev
```

Then open <http://localhost:3000>. Stop the server with command `Ctrl+C`.

---

## Usage

1. Open <http://localhost:3000>. The dropdown will be populated with your current active courses from Canvas.
2. Pick a course and press **Fetch Assignments**
3. Once shown the course assignments, click **Back to Courses** at any time to return to the home page. 

---

## API Endpoints Used

| Method | Endpoint | What we use it for |
| --- | --- | --- |
| `GET` | `/api/v1/courses` | Retrieves the active courses associated with the user account. |
| `GET` | `/api/v1/courses/:course_id/assignments` | Retrieves the published assignments and assignment details for the selected course. |

---

## Reflection